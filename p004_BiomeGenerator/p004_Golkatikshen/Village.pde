class Village
{
  PVector pos;
  int id; //river_segment_id;
  float radius;
  
  Village(PVector p, int _id)
  {
    pos = p.copy();
    id = _id;
    radius = random(20, 50);
  }
  
  void display()
  {
    fill(255, 0, 255);
    noStroke();
    ellipse(pos.x, pos.y, 6, 6);
  }
}
