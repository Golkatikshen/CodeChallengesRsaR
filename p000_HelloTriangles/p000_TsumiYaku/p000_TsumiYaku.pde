float x1 = random(600);
float y1 = random(600);
float x2 = random(600);
float y2 = random(600);
float x3 = random(600);
float y3 = random(600);

void setup() {
  background(255);
  size(600, 600);

}

void draw() {
  background(255);
  stroke(0);
  if(pointInside(mouseX, mouseY)) {
    fill(0,255,0);
  } else {
    fill(255,0,0);
  }
  triangle(x1, y1, x2, y2, x3, y3);
}




float Sign (float x1, float y1, float x2, float y2, float x3, float y3)
{
    return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3);
}

boolean pointInside(float xpoint, float ypoint) {
  boolean tf1, tf2, tf3;
  
  tf1 = Sign(xpoint, ypoint, x1, y1, x2, y2) < 0;
  tf2 = Sign(xpoint, ypoint, x2, y2, x3, y3) < 0;
  tf3 = Sign(xpoint, ypoint, x3, y3, x1, y1) < 0;
  
  return ((tf1 == tf2) && (tf2 == tf3));
}
