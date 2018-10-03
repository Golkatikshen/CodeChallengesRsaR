//Maze Generator

//const
int WIDTH = 14;  // <- affects all type of mazes
int HEIGHT = 14; // <- does not affects triangle and hex maze
int TYPE = 0;
// ^ squared = 0
//   triangular = 1
//   hexagonal = 2

int square_size = 20; //square side length
int half_square_size = square_size/2;
int tri_size = 24; //triangle side length
int half_tri_size = tri_size/2;
float tri_apothem = tri_size/(2*sqrt(3));
float tri_height = tri_size*sqrt(3)/2;
float hex_size = 14; //hexagon radius
float hex_apothem = hex_size*sqrt(3)/2;
float r60 = radians(60);
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
  
  println("R: Regenerate");
  println("S: Solve maze");
  println("1,2,3: Chenge maze type");
  println("Modify the values in the above const section to change the size of the maze");
}

void draw()
{
  background(30);
  M.display();
}

void keyPressed()
{
  if(key == 'r' || key == 'R')
    M = new Maze(WIDTH, HEIGHT, TYPE);
    
  if(key == 's' || key == 'S')
    M.solveMaze();
  
  if(key == '1')
    TYPE = 0;
  if(key == '2')
    TYPE = 1;
  if(key == '3')
    TYPE = 2;
    
  if(key == '1' || key == '2' || key == '3')
    M = new Maze(WIDTH, HEIGHT, TYPE);
}
