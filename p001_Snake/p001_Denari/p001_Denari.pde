import java.util.LinkedList;


PShape square, food, noSquare;
int direction, Xfood, Yfood, i;
boolean start = true;
LinkedList<Coordinate> body = new LinkedList();
Coordinate head = new Coordinate(360, 280), tail;

void setup(){
  noStroke();
  size(760, 600);
  background(255);
  square = createShape(RECT, 0, 0, 40, 40);
  food = createShape(ELLIPSE, 20, 20, 20, 20);
  noSquare = createShape(RECT, 0, 0, 40, 40);
  noSquare.setFill(255);
  square.setFill(0);
  food.setFill(100);
  Xfood = (int)random(19) * 40;
  Yfood = (int)random(15) * 40;
  tail = new Coordinate(0, 0);
  direction = 0;
}

void draw(){
  if(start != true){
    tail = body.remove();
    shape(noSquare, tail.x, tail.y);
  }
  else
    start = false;
  for(i=0; i < body.size(); i++)
    shape(square, body.get(i).x, body.get(i).y);
  shape(food, Xfood, Yfood);
   //<>//
  move(direction);
  if(head.x == Xfood && head.y == Yfood){
    Xfood = (int)random(19) * 40; //<>//
    Yfood = (int)random(15) * 40;
    if(body.size() == 0)
      body.add(new Coordinate(head.x, head.y));
    else
      body.add(body.getLast());
  }
  body.add(new Coordinate(head.x, head.y));
  frameRate(20);
}

void keyPressed(){
  switch(key){
    case 'a':
      direction = 0;
    break;
    case 'w':
      direction = 1;
    break;
    case 'd':
      direction = 2;
    break;
    case 's':
      direction = 3;
    break;
  }
}

void move(int direction){
  //0 Sinistra 1 Avanti 2 Destra 3 Sotto
  
  switch(direction){
    case 0:
      if(head.x == 0)
        head.x = 720;
      else
        head.x -= 40;
      break;
    case 1:
      if(head.y == 0)
        head.y = 560;
      else
        head.y -= 40;
      break;
    case 2:
      if(head.x == 720)
        head.x = 0;
      else
        head.x += 40;
      break;
    case 3:
      if(head.y == 560)
        head.y = 0;
      else
        head.y += 40;
      break;
  }
}
