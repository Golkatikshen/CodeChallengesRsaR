
Cell the_void = new C_Square(-10000, -10000);

void polygon(float x, float y, float radius, int npoints)
{
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) 
  {
    float sx = x + cos(a+PI/2) * radius;
    float sy = y + sin(a+PI/2) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
