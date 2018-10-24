/* Parameters */
int scale = 10;
int cols;
int rows;
boolean sol = false;

/* Structures */
ArrayList<PVector> solution = new ArrayList<PVector>();
Maze maze;

void setup() {
  noStroke();
  size(600,600);
  cols = width/scale;
  rows = height/scale;
  maze = new Maze(cols, rows);
  PVector start = new PVector(0, 0);
  PVector end = new PVector(cols-1, rows-1);
  maze.generate(start, end);
}

void draw() {
  maze.mazeDraw(sol);
}

void keyPressed() {
  if(key == ' ')
    sol = !sol;
}
