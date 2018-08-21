
Grid grid;
Snake snake;
int s = 30;
int food_clock;
int food_spawn_timerate;

int[][] global_game_grid;
ArrayList<Food> food;

void setup()
{
  size(660, 600);
  
  grid = new Grid(s);
  restartGame();
}

void draw()
{
  background(0);
  grid.display();
  snake.display();
  for(Food f: food)
    f.display();
    
  //food manager logic
  if(food_clock < millis())
  {
    food_clock = millis() + food_spawn_timerate * 1000;
    int nx, ny;
    do{
      nx = (int)random(0, width/s);
      ny = (int)random(0, height/s);
    }while(global_game_grid[nx][ny] != 0);
    global_game_grid[nx][ny] = 2;
    food.add(new Food(nx, ny, s));
  }
}

void keyPressed()
{
  if(!snake.perso)
  {
    if((key == 'w' || key =='W') && snake.H != HEADING.DOWN && snake.changed == false)
    {
      snake.H = HEADING.UP;
      snake.changed = true;
    }
    
    if((key == 's' || key =='S') && snake.H != HEADING.UP && snake.changed == false)
    {
      snake.H = HEADING.DOWN;
      snake.changed = true;
    }
    
    if((key == 'a' || key =='A') && snake.H != HEADING.RIGHT && snake.changed == false)
    {
      snake.H = HEADING.LEFT;
      snake.changed = true;
    }
    
    if((key == 'd' || key =='D') && snake.H != HEADING.LEFT && snake.changed == false)
    {
      snake.H = HEADING.RIGHT;
      snake.changed = true;
    }
  }
  else
  {
    if((key == 'r' || key =='R'))
      restartGame();
  }
    
  /*if(key == 'x')
    snake.H = HEADING.STOP;
    
  if(key == 'c')
    snake.addBodyPart();*/
}

void restartGame()
{
  global_game_grid = new int[width/s][height/s];
  food = new ArrayList();
  
  snake = new Snake(int(random(3, 10)), int(random(3, 10)), s);
  
  food_spawn_timerate = 4; //spawn rate in sec
  food_clock = millis() + food_spawn_timerate * 1000;
}
