  float x1 = random(100, 600);
  float y1 = random(100, 600);
  float x2 = random(100, 600);
  float y2 = random(100, 600);
  float x3 = random(100, 600);
  float y3 = random(100, 600);
  float coef = (y2-y1)/(x2-x1);
  int red = (int)random(255);
  int green = (int)random(255);
  int blue = (int)random(255);
  
void setup(){
  size(700, 700);
}

void draw() { //<>//
  triangle(x1, y1, x2, y2, x3, y3);
  MouseMoved();
}

void MouseMoved() {
  if(PointInTriangle(mouseX, mouseY))
      fill(color(red, green, blue));
   else{
   fill(255);
   red = (int)random(255);
   green = (int)random(255);
   blue = (int)random(255);
   }
}

float Sign (float x1, float y1, float x2, float y2, float x3, float y3)
{
    return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3);
}

boolean PointInTriangle (float px, float py)
{
    boolean b1, b2, b3;

    b1 = Sign(px, py, x1, y1, x2, y2) < 0.0f;
    b2 = Sign(px, py, x2, y2, x3, y3) < 0.0f;
    b3 = Sign(px, py, x3, y3, x1, y1) < 0.0f;

    return ((b1 == b2) && (b2 == b3));
}
