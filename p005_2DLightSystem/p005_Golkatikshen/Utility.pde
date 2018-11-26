float getAngle(PVector center, PVector point)
{
  float delta_x = point.x - center.x;
  float delta_y = center.y - point.y;
  float theta_radians = atan2(delta_y, delta_x);
  if (theta_radians < 0)
        theta_radians = abs(theta_radians);
    else
        theta_radians = 2 * PI - theta_radians;
        
  return theta_radians;
}
    
float rayVSSegment(PVector origin, PVector dir, PVector seg_A, PVector seg_B)
{
  seg_B = new PVector(seg_B.x-seg_A.x, seg_B.y-seg_A.y); //seg_B to dir
  
  if(seg_B.x-seg_A.x == 0 || dir.x-origin.x == 0)
  {
    if(seg_B.x-seg_A.x == 0 && dir.x-origin.x == 0)
      return -1;
  }
  else
  {
    float m1 = (dir.y-origin.y)/(dir.x-origin.x);
    float m2 = (seg_B.y-seg_A.y)/(seg_B.x-seg_A.x);
    if(m1 == m2)
      return -1;
  }
    
  float T2 = (dir.x*(seg_A.y-origin.y) + dir.y*(origin.x-seg_A.x))/(seg_B.x*dir.y - seg_B.y*dir.x);
  float T1;
  if(dir.x != 0)
    T1 = (seg_A.x+seg_B.x*T2-origin.x)/dir.x;
  else
    T1= (seg_A.y+seg_B.y*T2-origin.y)/dir.y;
  
  if(T1>=0 && 0<=T2 && T2<=1)
    return T1;
    
  return -1;
}

PVector segmentIntersection(PVector p0, PVector p1, PVector p2, PVector p3)
{
    float s10_x = p1.x - p0.x;
    float s10_y = p1.y - p0.y;
    float s32_x = p3.x - p2.x;
    float s32_y = p3.y - p2.y;

    float denom = s10_x * s32_y - s32_x * s10_y;

    if(denom == 0)
      return null; // collinear

    boolean denom_is_positive = (denom > 0);

    float s02_x = p0.x - p2.x;
    float s02_y = p0.y - p2.y;

    float s_numer = s10_x * s02_y - s10_y * s02_x;

    if((s_numer < 0) == denom_is_positive)
      return null; //do not collide

    float t_numer = s32_x * s02_y - s32_y * s02_x;

    if((t_numer < 0) == denom_is_positive)
      return null; //do not collide

    if(((s_numer > denom) == denom_is_positive) || ((t_numer > denom) == denom_is_positive))
      return null; //do not collide


    // collision detected

    float t = t_numer / denom;

    PVector intersection_point = new PVector(p0.x + (t * s10_x), p0.y + (t * s10_y));
    
    return intersection_point;
}

float distanceToSegment(float x, float y, float x1, float y1, float x2, float y2)
{
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
