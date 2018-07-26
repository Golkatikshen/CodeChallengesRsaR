float x1 = random(400);
float y1 = random(400);

float x2 = random(400);
float y2 = random(400);

float x3 = random(400);
float y3 = random(400);

float a, b, c;

boolean changeColor=true;

void setup() 
{
  size(500, 500); //Dimensione della finestra
  triangle(x1, y1, x2, y2, x3, y3);
}

void draw()
{ 
  a = ((y2 - y3)*(mouseX - x3) + (x3 - x2)*(mouseY - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
  b = ((y3 - y1)*(mouseX - x3) + (x1 - x3)*(mouseY - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
  c = 1-a-b;
  
  if(((a>=0 && a<=1) && (b>=0 && b<=1) && (c>=0 && c<=1))  && changeColor) //<>//
  {
    fill(255, 0, 0);
    stroke(0, 0, 0);
    triangle(x1, y1, x2, y2, x3, y3);
    changeColor=false;
  }
  else
  {
    if(!((a>=0 && a<=1) && (b>=0 && b<=1) && (c>=0 && c<=1)))
    {
        changeColor=true;
        fill(0, 0, 0);
        stroke(255, 255, 255);
        triangle(x1, y1, x2, y2, x3, y3);  
    }
  }
}
