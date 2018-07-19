
PVector randomPoint()
{
  PVector p = new PVector(random(0, width), random(0, height));
  return p;
}

PVector randomIntPoint()
{
  PVector p = new PVector(int(random(0, width)),int(random(0, height)));
  return p;
}

float triangleArea(PVector a, PVector b, PVector c)
{
  float area = 0.5*abs((a.x-c.x)*(b.y-a.y)-(a.x-b.x)*(c.y-a.y));
  return area;
}
