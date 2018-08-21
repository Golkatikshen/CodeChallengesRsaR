class Food
{
  int cx;
  int cy; 
  int s;
  float r;
  
  Food(int _x, int _y, int _s)
  {
    cx = _x;
    cy = _y;
    s = _s;
    r = 0;
  }
  
  void display()
  {
    PVector p1 = new PVector(cos(0), sin(0));
    PVector p2 = new PVector(cos(2*PI/3), sin(2*PI/3));
    PVector p3 = new PVector(cos(4*PI/3), sin(4*PI/3));
    p1.rotate(r);
    p2.rotate(r);
    p3.rotate(r);
    
    p1.mult(s/2);
    p2.mult(s/2);
    p3.mult(s/2);
    
    p1.add(cx*s+s/2+1, cy*s+s/2+1);
    p2.add(cx*s+s/2+1, cy*s+s/2+1);
    p3.add(cx*s+s/2+1, cy*s+s/2+1);
    
    r += 0.01f;
    if(r >= 360)
      r = 0;
      
    fill(0, 0, 255);
    triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  }
}
