Snake s = new Snake();
int prevDirection = RIGHT;
Queue<TurningPoint> turns = new Queue<TurningPoint>();
Apple apple = new Apple();
int points = 0;
PFont f;

void setup(){
  size(1000, 500);
  fill(255);
  f = createFont("Arial", 20, true);
  textFont(f);
}

void draw(){  
  background(0);  
  s.display();
  s.move(turns);
  apple.display();
  if(dist(s.getX(), s.getY(), apple.getPosX(), apple.getPosY()) <= 12){ //somma dei raggi di testa e mela (un po' di meno)
    points += apple.getPoints();
    apple.refresh();
  }
  fill(255);
  text("points: "+str(points), 890, 30);
}

void keyPressed(){
  if((prevDirection+keyCode-74)%2 != 0){ //se le direzioni non sono opposte, basato sul valore numerico delle costanti   
    s.setDirection(keyCode);
    prevDirection = keyCode;
    turns.enqueue(new TurningPoint(keyCode, s.getX(), s.getY()));
  }
}
