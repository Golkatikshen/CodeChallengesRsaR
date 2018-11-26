class LightSystem
{
  ArrayList<Wall> walls;
  ArrayList<Obstacle> obstacles;
  
  Light current_light;
  
  boolean on_line_creation;
  Point tmp_line_v;
  
  boolean on_rect_creation;
  Point tmp_rect_v;
  
  boolean on_circle_creation;
  Point tmp_circle_c;
  
  boolean on_poly_creation;
  ArrayList<Point> tmp_poly_ps;
  
  LightSystem()
  {
    walls = new ArrayList();
    obstacles = new ArrayList();
    
    on_line_creation = false;
    on_rect_creation = false;
    on_circle_creation = false;
    on_poly_creation = false;
    tmp_poly_ps = new ArrayList();
    
    obstacles.add(new Rectangle(new Point(-10, -10), new Point(width+10, height+10))); //borders
    obstacles.add(new Rectangle(new Point(210, 100), new Point(330, 200)));
    obstacles.add(new Rectangle(new Point(630, 290), new Point(750, 500)));
    obstacles.add(new DWall(new Point(500, 70), new Point(600, 80)));
    Poly poly = new Poly();
    poly.addPoint(550, 300);
    poly.addPoint(660, 360);
    poly.addPoint(543, 420);
    poly.generatePolyWalls();
    obstacles.add(poly);
    obstacles.add(new Circle(180, 400, 50)); 
    
    current_light = new Light(0, 0);
    
    updateWalls();
  }
  
  void display()
  {
    if(mode.equals("LIGHT"))
    {
      strokeWeight(1);
      current_light.display();
    }
    
    if(on_line_creation)
    {
      noFill();
      stroke(200, 0, 200);
      line(tmp_line_v.x, tmp_line_v.y, mouseX, mouseY);
    }
    
    if(on_rect_creation)
    {
      noFill();
      stroke(200, 0, 200);
      rect(tmp_rect_v.x, tmp_rect_v.y, mouseX-tmp_rect_v.x, mouseY-tmp_rect_v.y);
    }
    
    if(on_circle_creation)
    {
      noFill();
      stroke(200, 0, 200);
      float r = dist(tmp_circle_c.x, tmp_circle_c.y, mouseX, mouseY);
      ellipse(tmp_circle_c.x, tmp_circle_c.y, r*2, r*2);
    }
    
    if(on_poly_creation)
    {
      noFill();
      stroke(200, 0, 200);
      for(int i=0; i<tmp_poly_ps.size(); i++)
      {
        Point p1 = tmp_poly_ps.get(i);
        Point p2;
        if(i == tmp_poly_ps.size()-1)
          p2 = new Point(mouseX, mouseY);
        else
          p2 = tmp_poly_ps.get(i+1);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
    
    strokeWeight(3);
    for(Wall w: walls)
      w.display();
  }
  
  void update()
  {
    current_light.setPos(mouseX, mouseY);
    current_light.updateRays(walls);
  }
  
  void updateWalls()
  {
    walls.clear();
    for(Obstacle o: obstacles)
      for(int i=0; i<o.walls.size(); i++)
        walls.add(o.walls.get(i));
    
    for(int i=0; i<walls.size(); i++)
      for(int j=i+1; j<walls.size(); j++)
      {
        Wall w1 = walls.get(i);
        Wall w2 = walls.get(j);
        PVector p = segmentIntersection(w1.A.toPVector(), w1.B.toPVector(), w2.A.toPVector(), w2.B.toPVector());
        if(p != null)
          walls.add(new Wall((int)p.x, (int)p.y));
      }
    
    current_light.calculateRays(walls);
  }
  
  void deleteObstacle()
  {
    for(int i=1; i<obstacles.size(); i++)
      if(obstacles.get(i).isInside(mouseX, mouseY))
      {
        obstacles.remove(i);
        i--;
      }
      
    updateWalls();
  }
  
  
  void lineCreation()
  {
    if(!on_line_creation)
      tmp_line_v = new Point(mouseX, mouseY);
    else
    {
      obstacles.add(new DWall(tmp_line_v, new Point(mouseX, mouseY)));
      updateWalls();
    }
    
    on_line_creation = !on_line_creation;
  }
  
  void rectCreation()
  {
    if(!on_rect_creation)
      tmp_rect_v = new Point(mouseX, mouseY);
    else
    {
      obstacles.add(new Rectangle(tmp_rect_v, new Point(mouseX, mouseY)));
      updateWalls();
    }
    
    on_rect_creation = !on_rect_creation;
  }
  
  void circleCreation()
  {
    if(!on_circle_creation)
      tmp_circle_c = new Point(mouseX, mouseY);
    else
    {
      obstacles.add(new Circle(tmp_circle_c.x, tmp_circle_c.y, (int)dist(tmp_circle_c.x, tmp_circle_c.y, mouseX, mouseY)));
      updateWalls();
    }
    
    on_circle_creation = !on_circle_creation;
  }
  
  void polyCreation(boolean closing)
  {
    if(!closing)
    {
      if(!on_poly_creation)
      {
        on_poly_creation = true;
        tmp_poly_ps.clear();
      }
      
      tmp_poly_ps.add(new Point(mouseX, mouseY));
    }
    else
    {
      on_poly_creation = false;
      Poly poly = new Poly();
      for(int i=0; i<tmp_poly_ps.size(); i++)
        poly.addPoint(tmp_poly_ps.get(i).x, tmp_poly_ps.get(i).y);
      poly.generatePolyWalls();
      obstacles.add(poly);
      updateWalls();
    }
  }
}
