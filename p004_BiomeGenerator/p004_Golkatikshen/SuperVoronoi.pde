class SuperVoronoi
{
  int n_sites;
  PVector[] sites;
  //ArrayList<PVector> sites;
  ArrayList<Event> event_q;
  ArrayList<Node> beachline;
  ArrayList<Edge> completed_edges;
  ArrayList<CPolygon> polygons;
  
  //float Yd; // directrix
  
  SuperVoronoi(int _n_sites)
  {
    n_sites = _n_sites;
    sites = new PVector[n_sites];
    event_q = new ArrayList();
    beachline = new ArrayList();
    completed_edges = new ArrayList();
    polygons = new ArrayList();
    
    for(int i=0; i<n_sites; i++)
    {
      int nx = int(random(10, width-10));
      int ny;
      boolean duplicate;
      do{
        duplicate = false;
        ny = int(random(10, height-10));
        for(int j=0; j<i; j++)
          if(sites[j].y == ny)
            duplicate = true;
      }while(duplicate);
      
      sites[i] = new PVector(nx, ny);
    }
    
    //sorting sites by Y
    PVector p_tmp;
    for(int i=0; i<n_sites-1; i++)
      for(int j=i; j<n_sites; j++)
        if(sites[i].y > sites[j].y)
        {
          p_tmp = sites[i];
          sites[i] = sites[j];
          sites[j] = p_tmp;
        }
    
    //println("\n");
    for(PVector p: sites)
    {
      //println(p);
      Event e = new Event(true);
      e.point = p.copy();
      e.y = e.point.y;
      event_q.add(e);
    }
    //println("");
    
    while(!event_q.isEmpty())
    {
      Event e = event_q.get(0);
      event_q.remove(0);
      
      if(e.is_site_event)
        addParabola(e.point);
      else
        removeParabola(e.parabola, e.y);
    }
    
    for(int i=1; i<beachline.size(); i+=2)
    {
      EdgeNode n = (EdgeNode)beachline.get(i);
      completed_edges.add(new Edge(n.pos, n.dir, n.A, n.B));
    }
    
    println("Voronoi generated");
    
    for(int i=0; i<sites.length; i++)
      polygons.add(new CPolygon(sites[i]));
    
    for(int i=0; i<completed_edges.size(); i++)
    {
      for(int j=0; j<polygons.size(); j++)
      {
        if(polygons.get(j).site.equals(completed_edges.get(i).adjacent_site_A) || polygons.get(j).site.equals(completed_edges.get(i).adjacent_site_B))
        {
          polygons.get(j).addPoint(completed_edges.get(i).A);
          polygons.get(j).addPoint(completed_edges.get(i).B);
        }
      }
    }
    
    for(int j=0; j<polygons.size(); j++)
    {
      polygons.get(j).calculateCenter();
      polygons.get(j).sortPoints();
    }
    
    println("Polygons generated");
  }
  
  void addParabola(PVector point)
  {
    if(beachline.size() == 0)
    {
      beachline.add(new ArcNode(point));
      return;
    }
    
    ArcNode par = arcAbovePoint(point);
    for(int i=0; i<event_q.size(); i++)
    {
      if(!event_q.get(i).is_site_event)
        if(event_q.get(i).parabola.equals(par))
        {
          event_q.remove(i);
          i = event_q.size();
        }
    }
        
    ArcNode a, b, c;
    b = new ArcNode(point);
    a = new ArcNode(par.pos);
    c = new ArcNode(par.pos);
    EdgeNode xl, xr;//  = left and right edges, which comes from point on par under u
    PVector p;
    if(beachline.size() == 1 && (par.pos.y-1 < point.y && point.y < par.pos.y+1))
      p = new PVector((par.pos.x+point.x)/2, -10000);
    else
      p = new PVector(point.x, parabolaFunction(point.x, par.pos.x, par.pos.y, point.y/*<-directrix_y*/));
    xl = new EdgeNode(p);
    xr = new EdgeNode(p);
    xl.isNormalTo(a.pos, b.pos);
    xr.isNormalTo(b.pos, c.pos);
    
    //a, xl, b, xr, c
    for(int i=0; i<beachline.size(); i++)
      if(beachline.get(i).equals(par))
      {
        beachline.set(i, a);
        beachline.add(i+1, xl);
        beachline.add(i+2, b);
        beachline.add(i+3, xr);
        beachline.add(i+4, c);
        i = beachline.size();
      }
    
    checkCircleEvent(a, point.y);
    checkCircleEvent(c, point.y);
  }
  
  
  void removeParabola(ArcNode parabola, float Yd)
  {
    //println("culo: to remove: "+parabola.pos);
    
    ArcNode l = null, r = null;
    for(int i=0; i<beachline.size(); i+=2)
      if(beachline.get(i) == (parabola))
      {
        l = (ArcNode)beachline.get(i-2);
        r = (ArcNode)beachline.get(i+2);
      }
    
    int c = 0;
    for(int i=0; i<event_q.size(); i++)
    {
      if(!event_q.get(i).is_site_event)
        if(event_q.get(i).parabola.equals(l) || event_q.get(i).parabola.equals(r))
        {
          event_q.remove(i);
          i--;
          c++;
          if(c == 2)
            i = event_q.size();
        }
    }
    
    
    PVector s = calculateCircleCenter(l.pos, parabola.pos, r.pos);
    EdgeNode x = new EdgeNode(s);//new edge, starts at s, normal to (l.site, r.site)
    x.isNormalTo(l.pos, r.pos);
    
    for(int i=0; i<beachline.size(); i+=2)
      if(beachline.get(i).equals(parabola))
      {
        completed_edges.add(new Edge(s, beachline.get(i-1).pos, beachline.get(i).pos, beachline.get(i-2).pos));
        completed_edges.add(new Edge(s, beachline.get(i+1).pos, beachline.get(i).pos, beachline.get(i+2).pos));
        beachline.remove(i-1);
        beachline.remove(i-1);
        beachline.remove(i-1);
        beachline.add(i-1, x);
        i = beachline.size();
      }
    
    checkCircleEvent(l, Yd);
    checkCircleEvent(r, Yd);
  }
  
  void checkCircleEvent(ArcNode parabola, float Yd)
  {
    ArcNode l = null, r = null;
    EdgeNode xl = null, xr = null;
    for(int i=0; i<beachline.size(); i+=2)
      if(beachline.get(i).equals(parabola))
      {
        if(i-2 >= 0)
          l = (ArcNode)beachline.get(i-2);
        if(i+2 < beachline.size())
          r = (ArcNode)beachline.get(i+2);
        if(i-1 >= 0)
          xl = (EdgeNode)beachline.get(i-1);
        if(i+1 < beachline.size())
          xr = (EdgeNode)beachline.get(i+1);
      }
      
    if(l == null || r == null || l.pos.equals(r.pos))
      return;
      
    PVector s = calculateCircleCenter(l.pos, parabola.pos, r.pos);
    //when there is no s (edges go like\ /) RETURN
    if(!checkRaysIntersects(xr.pos, xl.pos, xr.dir, xl.dir))
      return;
    
    float radius = dist(s.x, s.y, parabola.pos.x, parabola.pos.y);
    if(s.y + radius <= Yd)
      return;
      
    Event e = new Event(false);
    e.parabola = parabola;
    e.y = s.y + radius;
    event_q.add(e);
        
    Event e_tmp;
    for(int i=0; i<event_q.size()-1; i++)
      for(int j=i; j<event_q.size(); j++)
        if(event_q.get(i).y > event_q.get(j).y)
        {
          e_tmp = event_q.get(i);
          event_q.set(i, event_q.get(j));
          event_q.set(j, e_tmp);
        }        
  }
  
  
  ArcNode arcAbovePoint(PVector p)
  {
    if(beachline.size() == 1)
      return (ArcNode)beachline.get(0);
      
    //println("POINT TO ADD: " + p);
    
    for(int i=0; i<beachline.size(); i+=2)
    {
      if(i != 0 && i != beachline.size()-1)
      {
        EdgeNode el = (EdgeNode)beachline.get(i-1);
        EdgeNode er = (EdgeNode)beachline.get(i+1);
        ArcNode p0 = (ArcNode)beachline.get(i);
        //println(el.dir, er.dir, p0.pos, p.y);
        float intersection_l = getXbyIntersectionRayVSParabola(el.pos, el.dir, p0.pos, p.y);
        float intersection_r = getXbyIntersectionRayVSParabola(er.pos, er.dir, p0.pos, p.y);
        
        //println("A: "+intersection_l, intersection_r);
        if(intersection_l <= p.x && p.x <= intersection_r)
          return p0;
      }
      
      if(i == 0)
      {
        EdgeNode er = (EdgeNode)beachline.get(i+1);
        ArcNode p0 = (ArcNode)beachline.get(i);
        float intersection = getXbyIntersectionRayVSParabola(er.pos, er.dir, p0.pos, p.y);
        //println("B: "+intersection);
        if(p.x < intersection)
          return p0;
      }
      
      if(i == beachline.size()-1)
      {
        EdgeNode el = (EdgeNode)beachline.get(i-1);
        ArcNode p0 = (ArcNode)beachline.get(i);
        float intersection = getXbyIntersectionRayVSParabola(el.pos, el.dir, p0.pos, p.y);
        //println("C: "+intersection);
        if(p.x > intersection)
          return p0;
      }
    }
    
    return null;
  }
  
  void display()
  {
    /*stroke(0);
    for(int i=0; i<completed_edges.size(); i++)
      completed_edges.get(i).display();
      
    stroke(200, 0, 0);
    for(PVector p : sites)
      point(p.x, p.y);*/
      
    for(CPolygon P : polygons)
      P.display();
  }
}

class Event
{
  PVector point;
  ArcNode parabola;
  boolean is_site_event;
  float y;
  
  Event(boolean _is_site_event)
  {
    is_site_event = _is_site_event;
    point = null;
    parabola = null;
  }
}

class Node
{
  PVector pos;
  Node nl;
  Node nr;
  
  Node(float _x, float _y)
  {
    pos = new PVector(_x, _y);
    nl = null;
    nr = null;
  }
}

class EdgeNode extends Node
{
  PVector A;
  PVector B;
  PVector dir;
  
  EdgeNode(PVector _p)
  {
    super(_p.x, _p.y);
  }
  
  void isNormalTo(PVector a, PVector b)
  {
    A = a.copy();
    B = b.copy();
    
    dir = PVector.sub(A,B);
    dir = dir.rotate(-HALF_PI);
    dir = dir.mult(100000);
    dir = PVector.add(pos, dir);    
  }
}

class Edge
{
  PVector A;
  PVector B;
  PVector adjacent_site_A;
  PVector adjacent_site_B;
  
  Edge(PVector _A, PVector _B, PVector _adjacent_site_A, PVector _adjacent_site_B)
  {
    A = _A.copy();
    B = _B.copy();
    adjacent_site_A = _adjacent_site_A.copy();
    adjacent_site_B = _adjacent_site_B.copy();
  }
  
  void display()
  {
    line(A.x, A.y, B.x, B.y);
  }
}

class ArcNode extends Node
{
  ArcNode(PVector _p)
  {
    super(_p.x, _p.y);
  }
}


PVector calculateCircleCenter(PVector A, PVector B, PVector C)
{
  float yDelta_a = B.y - A.y;
  float xDelta_a = B.x - A.x;
  float yDelta_b = C.y - B.y;
  float xDelta_b = C.x - B.x;
  PVector center = new PVector(0,0);
  
  float aSlope = yDelta_a/xDelta_a;
  float bSlope = yDelta_b/xDelta_b;
  
  PVector AB_Mid = new PVector((A.x+B.x)/2, (A.y+B.y)/2);
  PVector BC_Mid = new PVector((B.x+C.x)/2, (B.y+C.y)/2);
  
  if(yDelta_a == 0)         //aSlope == 0
  {
      center.x = AB_Mid.x;
      if (xDelta_b == 0)         //bSlope == INFINITY
      {
          center.y = BC_Mid.y;
      }
      else
      {
          center.y = BC_Mid.y + (BC_Mid.x-center.x)/bSlope;
      }
  }
  else if (yDelta_b == 0)               //bSlope == 0
  {
      center.x = BC_Mid.x;
      if (xDelta_a == 0)             //aSlope == INFINITY
      {
          center.y = AB_Mid.y;
      }
      else
      {
          center.y = AB_Mid.y + (AB_Mid.x-center.x)/aSlope;
      }
  }
  else if (xDelta_a == 0)        //aSlope == INFINITY
  {
      center.y = AB_Mid.y;
      center.x = bSlope*(BC_Mid.y-center.y) + BC_Mid.x;
  }
  else if (xDelta_b == 0)        //bSlope == INFINITY
  {
      center.y = BC_Mid.y;
      center.x = aSlope*(AB_Mid.y-center.y) + AB_Mid.x;
  }
  else
  {
      center.x = (aSlope*bSlope*(AB_Mid.y-BC_Mid.y) - aSlope*BC_Mid.x + bSlope*AB_Mid.x)/(bSlope-aSlope);
      center.y = AB_Mid.y - (center.x - AB_Mid.x)/aSlope;
  }
  
  return center;
}

float parabolaFunction(float x, float focus_x, float focus_y, float directrix_y)
{
  return pow(x-focus_x, 2)/(2*(focus_y-directrix_y))+(focus_y+directrix_y)/2;
}

boolean checkRaysIntersects(PVector as, PVector bs, PVector ad, PVector bd)
{
  float dx = bs.x - as.x;
  float dy = bs.y - as.y;
  float det = bd.x * ad.y - bd.y * ad.x;
  if(det == 0)
    return false;
    
  float u = (dy * bd.x - dx * bd.y) / det;
  float v = (dy * ad.x - dx * ad.y) / det;
  
  if(v >= 0 && u >= 0)
    return true;
    
  return false;
}

float getXbyIntersectionRayVSParabola(PVector s, PVector dir, PVector f, float d)
{
  if(d == f.y)
  {
    println("D=F.Y! "+ s, dir, f, d);
    return f.x;
  }
    
  if(dir.x == 0 || d-f.y == 0)
  {
    println("QUALCOSA DI BRUTTO DA GESTIRE!");
    if(dir.x == 0)
      println("X!");
    
    if(d-f.y == 0)
      println("D-F.Y!");
      
    return -1;
  }
  
  double A = s.x;
  double B = s.y;
  double H = dir.x;
  double K = dir.y;
  double x = f.x;
  double y = f.y;
  
  double num_f_r = A*H/(d-y)-H*x/(d-y)+K;
  double radice = sqrt((float)(2*A*H*K/(d-y)-2*B*H*H/(d-y)+H*H*y/(d-y)+d*H*H/(d-y)-2*H*K*x/(d-y)+K*K));
  
  double t1 = (y-d)*(-radice+num_f_r)/(H*H);
  double t2 = (y-d)*(radice+num_f_r)/(H*H);
  //println("T1: "+t1+"; T2: "+t2);
  if(t1 > t2)
    return (float)(A+t1*H);
  else
    return (float)(A+t2*H);
}
