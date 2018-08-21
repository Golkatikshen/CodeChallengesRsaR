class Grid
{
  int s;
  
  Grid(int _s)
  {
    s = _s;
  }
  
  void display()
  {
    stroke(10);
      
    //vertical lines
    for(int i=s; i<width; i+=s)
      line(i, 0, i, height);
      
    //horizontal lines
    for(int i=s; i<height; i+=s)
      line(0, i, width, i);
  }
}
