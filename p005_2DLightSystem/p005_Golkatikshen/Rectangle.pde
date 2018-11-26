class Rectangle extends Obstacle
{
  Point A;
  Point B;
  
  Rectangle(Point _A, Point _B)
  {
    super();
    A = _A.pcopy();
    B = _B.pcopy();
    walls.add(new Wall(A.x, A.y, A.x, B.y)); //left wall
    walls.add(new Wall(A.x, B.y, B.x, B.y)); //bottom wall
    walls.add(new Wall(B.x, B.y, B.x, A.y)); //right wall
    walls.add(new Wall(B.x, A.y, A.x, A.y)); //upper wall
  }
  
  @Override
  boolean isInside(int x, int y)
  {
    Point top_left = new Point(A.x < B.x ? A.x : B.x, A.y < B.y ? A.y : B.y);
    Point bottom_right = new Point(A.x > B.x ? A.x : B.x, A.y > B.y ? A.y : B.y);
    return ((x >= top_left.x && x <= bottom_right.x) && (y >= top_left.y && y <= bottom_right.y));
  }
}
