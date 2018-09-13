class Mouse
{
  float x;
  float y;
  
  Mouse()
  {
    x = random(400.0);
    y = random(400.0);
  }
  
  void drawMouse(){
    rect(x, y, 5, 5); 
  }
}
