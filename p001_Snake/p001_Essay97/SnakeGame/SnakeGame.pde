Snake s = new Snake();

void setup(){
  size(1000, 500);
  fill(255);
}

void draw(){
  background(0);
  s.display();
  s.move(false);
}
