// Hello Triangles


Triangle t;

void setup()
{
  size(800, 600);
  strokeWeight(3);
  stroke(255);
  
  t = new Triangle();
}

void draw()
{
  background(20);
  t.display();
}

void keyPressed()
{
  if(key == 'g' || key == 'G')
    t.randomize();
}
