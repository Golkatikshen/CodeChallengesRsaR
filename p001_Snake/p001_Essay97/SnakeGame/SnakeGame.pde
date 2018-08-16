Snake s = new Snake();
int prevDirection = RIGHT;
Queue<TurningPoint> turns = new Queue<TurningPoint>();

void setup(){
  size(1000, 500);
  fill(255);
}

void draw(){ //in questo draw ci sono solo prove
  background(0);
  for(TurningPoint t: turns.getList()){
    stroke(#F53131);
    point(t.getX(), t.getY());
  }
  
  s.display();
  s.move(turns);
}

void keyPressed(){
  if((prevDirection+keyCode-74)%2 != 0){  
    s.setDirection(keyCode); //setta la direzionde della testa
    prevDirection = keyCode;
    turns.enqueue(new TurningPoint(keyCode, s.getX(), s.getY()));
  }
}
