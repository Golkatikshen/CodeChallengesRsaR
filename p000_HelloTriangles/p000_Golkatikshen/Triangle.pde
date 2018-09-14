class Triangle
{
  PVector p0;
  PVector p1;
  PVector p2;
  
  Triangle()
  {
    randomize();
  }
  
  void display()
  {
    if(mouseHoverTriangle())
      fill(100, 10, 1);
    else
      noFill();
      
    beginShape();
    vertex(p0.x, p0.y);
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    endShape(CLOSE);
  }
  
  void randomize()
  {
    p0 = randomIntPoint();
    p1 = randomIntPoint();
    p2 = randomIntPoint();
  }
  
  boolean mouseHoverTriangle()
  {
    PVector m = new PVector(mouseX, mouseY);
    float T = triangleArea(p0, p1, p2);
    float t0 = triangleArea(p0, p1, m);
    float t1 = triangleArea(p0, m, p2);
    float t2 = triangleArea(m, p1, p2);
    
    return (T == t0+t1+t2);
  }
}
