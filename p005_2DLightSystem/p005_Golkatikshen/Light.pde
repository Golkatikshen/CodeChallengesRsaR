import java.awt.Polygon;

class Light
{
  Point pos;
  ArrayList<TripleRay> trays;
  ArrayList<PVector> col_points;
  Polygon poly;
  
  Light(int _x, int _y)
  {
    pos = new Point(_x, _y);
    trays = new ArrayList();
    col_points = new ArrayList();
    poly = new Polygon();
  }
  
  void display()
  {
    noStroke();
    fill(215);

    beginShape();
    for(int i=0; i<col_points.size(); i++)
    {
      PVector p = col_points.get(i);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    
    for(TripleRay r: trays)
    {
      r.display(debug_mode);
    }
      
    fill(240);
    ellipse(pos.x, pos.y, 6, 6);
  }
  
  void calculateRays(ArrayList<Wall> walls)
  {
    trays.clear();
    for(int i=0; i<walls.size(); i++)
      trays.add(new TripleRay(pos.toPVector(), walls.get(i).A.toPVector()));
      
    updateRays(walls);
  }
  
  void updateRays(ArrayList<Wall> walls)
  {
    for(int i=0; i<trays.size(); i++)
      trays.get(i).update(pos.toPVector());
    
    for(int j=0; j<trays.size(); j++)
    {
      for(int k=0; k<2; k++)
      {
        float t = -1;
        for(int i=0; i<walls.size(); i++)
        {
          float tmp_t = rayVSSegment(trays.get(j).rays[k].origin, trays.get(j).rays[k].dir, walls.get(i).A.toPVector(), walls.get(i).B.toPVector());
          if(tmp_t != -1)
          {
            if(t == -1)
              t = tmp_t;
            else
            {
              if(t > tmp_t)
                t = tmp_t;
            }
          }
        }
        
        trays.get(j).rays[k].t = t;
      }
    } 
    
    
    col_points = new ArrayList();
    for(int i=0; i<trays.size(); i++)
      for(int j=0; j<2; j++)
        col_points.add(trays.get(i).rays[j].getCollisionPoint());
        
    for(int i=0; i<col_points.size()-1; i++)
    {
      for(int j=i; j<col_points.size(); j++)
      {
        float angle_i = getAngle(pos.toPVector(), col_points.get(i));
        float angle_j = getAngle(pos.toPVector(), col_points.get(j));
        
        if(angle_i < angle_j)
        {
          PVector tmp = col_points.get(i);
          col_points.set(i, col_points.get(j));
          col_points.set(j, tmp);
        }
      }
    }
    
    for(int i=0; i<col_points.size(); i++)
    {
      PVector p = col_points.get(i);
      poly.addPoint((int)p.x, (int)p.y);
    }
  }
  
  void setPos(int x, int y)
  {
    pos = new Point(x, y);
  }
}
