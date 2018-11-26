class Wall
{
  Point A;
  Point B;
  
  Wall(int _xA, int _yA, int _xB, int _yB)
  {
    A = new Point(_xA, _yA);
    B = new Point(_xB, _yB);
  }
  
  Wall(float _xA, float _yA, float _xB, float _yB)
  {
    A = new Point(_xA, _yA);
    B = new Point(_xB, _yB);
  }
  
  Wall(int _x, int _y)
  {
    A = new Point(_x, _y);
    B = new Point(_x, _y);
  }
  
  void display()
  {
    stroke(76, 169, 115); //verdeacqua
    line(A.x, A.y, B.x, B.y);
  }
}
