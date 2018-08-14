Snake s = new Snake();
int prevDirection = RIGHT;

void setup(){
  size(1000, 500);
  fill(255);
}

void draw(){
  background(0);
  s.display();
  s.move(false);
}

void keyPressed(){
  switch(keyCode){
  case UP:
    if(prevDirection == DOWN) break; //se sta andando in giu non puo andare direttamente su
    //andare a destra
    break;
  case DOWN:
    break;
  case LEFT:
    break;
  case RIGHT:
    break;
  }
}
