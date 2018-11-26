class Circle extends Obstacle
{
  Point pos;
  int r;
  
  Circle(int _x, int _y, int _r)
  {
    super();
    pos = new Point(_x, _y);
    r = _r;
    
    int d = 26;
    float inc_angle = TWO_PI/d;
    float prec_angle = 0;
    float angle = inc_angle;
    for(float i=0; i<d; i++)
    {
      walls.add(new Wall(pos.x+cos(prec_angle)*r, pos.y+sin(prec_angle)*r, pos.x+cos(angle)*r, pos.y+sin(angle)*r));
      prec_angle = angle;
      angle += inc_angle;
    }
  }
  
  @Override
  boolean isInside(int x, int y)
  {
    return (dist(x, y, pos.x, pos.y) <= r);
  }
}
