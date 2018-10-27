class River
{
  ArrayList<Segment> segments;
  
  River()
  {
    segments = new ArrayList();
    
    PVector s = new PVector(0, height/2);
    PVector e;
    float off = 0.05;
    float v = 0;
    noiseDetail(3, 0.7);
    do{
      v += off;
      float angle = map(noise(v), 0, 1, 0, 180);
      e = new PVector(cos(radians(angle)), sin(radians(angle)));
      //println(noise(v));
      angle -= 90;
      angle *= -1;
      //println("A: "+angle);
      e = e.rotate(-HALF_PI);
      e = e.mult(6);
      e = e.add(s);
      segments.add(new Segment(s, e));
      s = e.copy();
    }while(e.x < width);
  }
  
  void display()
  {
    for(Segment s: segments)
    {
      s.display();
      //println(s.A, s.B);
    }
  }
}

class Segment
{
  PVector A;
  PVector B;
  
  Segment(PVector _A, PVector _B)
  {
    A = _A.copy();
    B = _B.copy();
  }
  
  Segment(float ax, float ay, float bx, float by)
  {
    A = new PVector(ax, ay);
    B = new PVector(bx, by);
  }
  
  void display()
  {
    stroke(0, 0, random(0, 255));
    line(A.x, A.y, B.x, B.y);
  }
}
