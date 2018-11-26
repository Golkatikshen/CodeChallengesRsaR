class DWall extends Obstacle
{
  int Ax;
  int Bx;
  int Ay;
  int By;
  
  DWall(Point A, Point B)
  {
    super();
    Ax = A.x;
    Ay = A.y;
    Bx = B.x;
    By = B.y;
    walls.add(new Wall(A.x, A.y, B.x, B.y));
    walls.add(new Wall(B.x, B.y, A.x, A.y));
  }
  
  @Override
  boolean isInside(int x, int y)
  {
    return (distanceToSegment(x, y, Ax, Ay, Bx, By) < 10);
  }
}
