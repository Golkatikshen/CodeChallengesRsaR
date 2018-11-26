class Point
{
  int x;
  int y;
  
  Point(int _x, int _y)
  {
    x = _x;
    y = _y;
  }
  
  Point(float _x, float _y)
  {
    x = (int)_x;
    y = (int)_y;
  }
  
  Point()
  {
    x = 0;
    y = 0;
  }
  
  PVector toPVector()
  {
    return new PVector(x, y);
  }
  
  String toString()
  {
    return "["+x+","+y+"]";
  }
  
  Point pcopy()
  {
    return new Point(x, y);
  }
}
