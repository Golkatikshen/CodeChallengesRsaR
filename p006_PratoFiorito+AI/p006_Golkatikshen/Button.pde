class Button
{
  float x;
  float y;
  float w;
  float h;
  String str;
  float thickness;
  boolean hover;
  
  float yoff;
  int r;
  int g;
  int b;
  
  boolean done = false;
  float str_size;
  
  
  Button(float x_, float y_, float w_, float h_, String str_, float thickness_)
  {
    x = rele(x_, "h");
    y = rele(y_, "v");
    w = rele(w_, "h");
    h = rele(h_, "v");
    str = str_;
    thickness = rele(thickness_, "v");
    
    if(thickness < 4)
      thickness = 4;
      
    if(w < 3)
      w = 3;
      
    yoff = 0;
    r = 255;
    g = 0;
    b = 0;
  }
  
  Button(float x_, float y_, float w_, float h_, String str_, float thickness_, float _yoff)
  {
    x = rele(x_, "h");
    y = rele(y_, "v");
    w = rele(w_, "h");
    h = rele(h_, "v");
    str = str_;
    thickness = rele(thickness_, "v");
    
    if(thickness < 4)
      thickness = 4;
      
    if(w < 3)
      w = 3;
      
      
    yoff = rele(_yoff, "v");
    r = 255;
    g = 0;
    b = 0;
  }
  
  Button(float x_, float y_, float w_, float h_, String str_, float thickness_, float _yoff, int _r, int _g, int _b)
  {
    x = rele(x_, "h");
    y = rele(y_, "v");
    w = rele(w_, "h");
    h = rele(h_, "v");
    str = str_;
    thickness = rele(thickness_, "v");
    
    if(thickness < 4)
      thickness = 4;
      
    if(w < 3)
      w = 3;
      
      
    yoff = rele(_yoff, "v");
    r = _r;
    g = _g;
    b = _b;
  }
  
  
  void display()
  {
    rectMode(CENTER);
    
    fill(r, g, b);    
    rect(x, y, w+thickness, h+thickness);
    
    fill(0);
    rect(x, y, w, h);
    
    if(mouseHover())
      fill(r, g, b);
    else
      fill(255);
    
    
    textAlign(CENTER, CENTER);
    
    if(!done)
    {
      for(int i=0; i<w/2; i++)
      {
        textSize(w/2-i);
        if(textWidth(str) < w && textAscent()+textDescent() < h)
        {
          str_size = w/2-i;
          done = true;
          break;
        }
      }
    }
    else
      textSize(str_size);
      
    text(str, x, y+yoff);
    
    rectMode(CORNER);
  }
  
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y-h/2 && mouseY < y+h/2));
  }
}