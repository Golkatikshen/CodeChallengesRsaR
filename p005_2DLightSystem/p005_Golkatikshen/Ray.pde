class Ray
{
  PVector origin;
  PVector dir;
  float t;
  
  Ray(PVector _origin, PVector _dir)
  {
    origin = _origin.copy();
    dir = _dir.copy();//new PVector(_dir.x-origin.x, _dir.y-origin.y);
    t = 0;
  }
  
  void display()
  {
    stroke(200, 50, 60);
    line(origin.x, origin.y, origin.x+dir.x*t, origin.y+dir.y*t);
  }
  
  void display(int r, int g, int b)
  {
    stroke(r, g, b);
    line(origin.x, origin.y, origin.x+dir.x*t, origin.y+dir.y*t);
  }
  
  PVector getCollisionPoint()
  {
    return new PVector(origin.x+dir.x*t, origin.y+dir.y*t);
  }
}
