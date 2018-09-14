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
    fill(255, 0, 0);
    rect(x, y, 7, 7, 1); 
  }
}
