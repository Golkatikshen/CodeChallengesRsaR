import java.awt.Polygon;

class CPolygon
{
  Polygon polygon;
  PVector site;
  PVector center;
  
  CPolygon(PVector _site)
  {
    polygon = new Polygon();
    site = _site.copy();
  }
  
  void addPoint(PVector v)
  {
    if(!alreadyAdded(v))
      polygon.addPoint(int(v.x), int(v.y));
  }
  
  void calculateCenter()
  {
    int sumx = 0, sumy = 0;
    for(int i=0; i<polygon.npoints; i++)
    {
      sumx += polygon.xpoints[i];
      sumy += polygon.ypoints[i];
    }
    
    center = new PVector(sumx/polygon.npoints, sumy/polygon.npoints);
  }
  
  boolean isInside(PVector p)
  {
    return polygon.contains(p.x, p.y);
  }
  
  boolean isInside(int x, int y)
  {
    return polygon.contains(x, y);
  }
  
  boolean alreadyAdded(PVector p)
  {
    boolean b = false;
    for(int i=0; i<polygon.npoints; i++)
      if(int(p.x) == polygon.xpoints[i] && int(p.y) == polygon.ypoints[i])
        b = true;
        
    return b;
  }
  
  void sortPoints()
  {
    for(int i=0; i<polygon.npoints-1; i++)
    {
      for(int j=i; j<polygon.npoints; j++)
      {
        PVector vi = new PVector(polygon.xpoints[i], polygon.ypoints[i]);
        PVector vj = new PVector(polygon.xpoints[j], polygon.ypoints[j]);
        if(less(vi, vj))
        {
          int tmpx = polygon.xpoints[i];
          int tmpy = polygon.ypoints[i];
          polygon.xpoints[i] = polygon.xpoints[j];
          polygon.ypoints[i] = polygon.ypoints[j];
          polygon.xpoints[j] = tmpx;
          polygon.ypoints[j] = tmpy;
        }
      }
    }
  }
  
  boolean less(PVector a, PVector b)
  {
    if (a.x - center.x >= 0 && b.x - center.x < 0)
        return true;
    if (a.x - center.x < 0 && b.x - center.x >= 0)
        return false;
    if (a.x - center.x == 0 && b.x - center.x == 0) {
        if (a.y - center.y >= 0 || b.y - center.y >= 0)
            return a.y > b.y;
        return b.y > a.y;
    }

    // compute the cross product of vectors (center -> a) x (center -> b)
    int det = int((a.x - center.x) * (b.y - center.y) - (b.x - center.x) * (a.y - center.y));
    if (det < 0)
        return true;
    if (det > 0)
        return false;

    // points a and b are on the same line from the center
    // check which point is closer to the center
    int d1 = int((a.x - center.x) * (a.x - center.x) + (a.y - center.y) * (a.y - center.y));
    int d2 = int((b.x - center.x) * (b.x - center.x) + (b.y - center.y) * (b.y - center.y));
    return d1 > d2;
  }
  
  float area() 
  { 
    float area = 0;         // Accumulates area in the loop
    int j = polygon.npoints-1;  // The last vertex is the 'previous' one to the first
  
    for(int i=0; i<polygon.npoints; i++)
    { 
      area = area + (polygon.xpoints[j]+polygon.xpoints[i]) * (polygon.ypoints[j]-polygon.ypoints[i]); 
      j = i;  //j is previous vertex to i
    }
    
    return area/2;
  }
  
  int getNPoints()
  {
    return polygon.npoints;
  }
  
  int getXPoint(int i)
  {
    return polygon.xpoints[i];
  }
  
  int getYPoint(int i)
  {
    return polygon.ypoints[i];
  }

  void display()
  {
    noFill();
    stroke(0);
    beginShape();
    for(int i=0; i<polygon.npoints; i++)
      vertex(polygon.xpoints[i], polygon.ypoints[i]);
    endShape(CLOSE);
    stroke(255, 0, 0);
    point(center.x, center.y);
  }
}
