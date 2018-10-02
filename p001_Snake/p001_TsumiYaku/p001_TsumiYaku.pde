import java.util.LinkedList;

class Coordinate {
  int x, y;
  
  Coordinate(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

enum Direction {
  UP,
  DOWN,
  LEFT,
  RIGHT
};

LinkedList<Coordinate> snake = new LinkedList();
Direction dir;
Coordinate head;
Coordinate food;
int sz = 20;
int cols;
int rows;
boolean lost = false;

void setup() {
  background(0);
  fullScreen();
  rows = floor(height/sz);
  cols = floor(width/sz);
  head = new Coordinate(floor(cols/2), floor(rows/2));
  snake.add(new Coordinate(head.x, head.y));
  food = new Coordinate(floor(random(cols)), floor(random(rows)));
  dir = Direction.UP;
  frameRate(20);
  noStroke();
}

void draw(){ 
  fill(0,255,0);
  rect(food.x*sz, food.y*sz, sz, sz);
  moveSnake();
}

void keyPressed() {
  if((key == 'd' || key == 'D') && dir != Direction.LEFT) {
    dir = Direction.RIGHT;
  }
  if((key == 'w' || key == 'W') && dir != Direction.DOWN) {
    dir = Direction.UP;
  }
  if((key == 's' || key == 'S') && dir != Direction.UP) {
    dir = Direction.DOWN;
  }
  if((key == 'a' || key == 'A') && dir != Direction.RIGHT) {
    dir = Direction.LEFT;
  }  
}

void moveSnake() {
  if(dir == Direction.UP) {
    if(head.y != 0)
      head.y--;
    else head.y = rows-1;
  }
  if(dir == Direction.DOWN) {
    if(head.y != rows-1)
      head.y++;
    else head.y = 0;
  }
  if(dir == Direction.LEFT) {
    if(head.x != 0)
      head.x--;
    else head.x = cols-1;
  }
  if(dir == Direction.RIGHT) {
    if(head.x != cols-1)
      head.x++;
    else head.x = 0;
  }
  
  if(hit(head)) { //<>//
    lost = true;
  }
  
  if (lost) {
    fill(255, 0, 0);
    for(Coordinate c: snake)
      rect(c.x*sz, c.y*sz, sz, sz);
    noLoop();
    return;
  }  
    
  snake.add(new Coordinate(head.x, head.y));
  if(compareCoord(head, food)) {
    food.x = floor(random(cols));
    food.y = floor(random(rows));    
  } else {
    Coordinate tail = snake.poll();
    fill(0);
    rect(tail.x*sz, tail.y*sz, sz, sz);
    fill(255);
  }
  fill(255);
  rect(head.x*sz, head.y*sz, sz, sz);
}

boolean compareCoord(Coordinate a, Coordinate b) {
  return (a.x == b.x) && (a.y == b.y);
}

boolean hit(Coordinate a) {
  for(Coordinate b: snake)
    if(compareCoord(a, b))
      return true;
  return false;
}
