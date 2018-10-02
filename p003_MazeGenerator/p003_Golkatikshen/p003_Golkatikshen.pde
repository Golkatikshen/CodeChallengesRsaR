//Maze Generator

//const
int WIDTH = 18;
int HEIGHT = 18;
int TYPE = 1;
// ^ squared = 0
//   triangular = 1
//   hexagonal = 2

int square_size = 20; //square side length
int half_square_size = square_size/2;
int tri_size = 30; //triangle side length
int half_tri_size = tri_size/2;
float tri_apothem = tri_size/(2*sqrt(3));
float tri_height = tri_size*sqrt(3)/2;
float hex_size = 10; //radius
//const


Maze M;

void setup()
{
  size(750, 600);
  strokeWeight(2);
  rectMode(CENTER);
  
  the_void.check = true;
  the_void.sol_check = true;
  M = new Maze(WIDTH, HEIGHT, TYPE);
}

void draw()
{
  background(30);
  M.display();
  polygon(50, 50, 20, 6);
}

void keyPressed()
{
  if(key == 'r' || key == 'R')
    M = new Maze(WIDTH, HEIGHT, TYPE);
    
  if(key == 's' || key == 'S')
    M.solveMaze();
  
  if(key == '0')
    TYPE = 0;
  if(key == '1')
    TYPE = 1;
  if(key == '2')
    TYPE = 2;
    
  if(key == '0' || key == '1' || key == '2')
    M = new Maze(WIDTH, HEIGHT, TYPE);
}
