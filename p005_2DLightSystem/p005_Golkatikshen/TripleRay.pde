class TripleRay
{
  PVector origin;
  PVector target;
  Ray[] rays;
  
  TripleRay(PVector _origin, PVector _target)
  {
    target = _target.copy();
    rays = new Ray[2];
    for(int i=0; i<2; i++)
      rays[i] = new Ray(_origin, new PVector(0, 0));
    update(_origin);
  }
  
  void display(boolean b)
  {
    stroke(200, 50, 60);
    if(b)
    {
      rays[0].display(0, 0, 255); //blue
      rays[1].display(255, 0, 0); //red
    }
  }
  
  void update(PVector or)
  {
    origin = or.copy();
    rays[0].origin = or.copy();
    rays[1].origin = or.copy();
    float angle, off = 0.00001;
    angle = atan2(target.y-origin.y, target.x-origin.x);
    rays[0].dir = new PVector(cos(angle+off), sin(angle+off));
    rays[1].dir = new PVector(cos(angle-off), sin(angle-off));
  }
}
