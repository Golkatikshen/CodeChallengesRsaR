
float distance(PVector a, PVector b)
{
  return dist(a.x, a.y, b.x, b.y);
}

float distanceToLine(float px, float py, float x1, float y1, float x2, float y2) 
{
  float A = px - x1; // position of point rel one end of line
  float B = py - y1;
  float C = x2 - x1; // vector along line
  float D = y2 - y1;
  float E = -D; // orthogonal vector
  float F = C;

  float dot = A * E + B * F;
  float len_sq = E * E + F * F;

  return abs(dot) / sqrt(len_sq);
}

float distanceToSegment(float x, float y, float x1, float y1, float x2, float y2)
{
  /*a = a.copy();
  b = b.copy();
  PVector u = b.sub(a);
  PVector v = (new PVector(px, py)).sub(a);
  float g = u.dot(v)/u.dot(u);
  
  float dtl = distanceToLine(px, py, a.x, a.y, b.x, b.y);
  float dta = dist(px, py, a.x, a.y);
  float dtb = dist(px, py, b.x, b.y);
  
  if(g < 0)
    return dta;
  if(g > 1)
    return dtb;
  return dtl;*/

  float A = x - x1;
  float B = y - y1;
  float C = x2 - x1;
  float D = y2 - y1;

  float dot = A * C + B * D;
  float len_sq = C * C + D * D;
  float param = -1;
  if (len_sq != 0) //in case of 0 length line
      param = dot / len_sq;

  float xx, yy;

  if (param < 0) {
    xx = x1;
    yy = y1;
  }
  else if (param > 1) {
    xx = x2;
    yy = y2;
  }
  else {
    xx = x1 + param * C;
    yy = y1 + param * D;
  }

  float dx = x - xx;
  float dy = y - yy;
  return sqrt(dx * dx + dy * dy);
}
