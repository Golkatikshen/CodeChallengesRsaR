class Pixel
{
  float h;
  float m;
  float n;
  color c;
  int x;
  int y;
  boolean darkened;
  BTYPE bt;
  
  Pixel(int _x, int _y, float _h, color _c, float _m, float _n, BTYPE _bt)
  {
    x = _x;
    y = _y;
    h = _h;
    m = _m;
    n = _n;
    c = _c;
    bt = _bt;
    
    darkened = false;
  }
  
  void display()
  {
    pixels[y*width+x] = c;
  }
  
  void toTheDarkness()
  {
    if(darkened)
      return;
      
    c = color(red(c)*0.7, green(c)*0.7, blue(c)*0.7);
    darkened = true;
  }
}
