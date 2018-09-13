Snake snake;
Mouse mouse;
boolean mouseKilled = false;
final float killRange = 10;

void setup()
{
  size(500, 500);
  snake = new Snake();
  mouse = new Mouse();
}

void draw()
{
  background(255);
  if(mouseKilled)
  {
    mouse = new Mouse();
    mouseKilled = false;
  }
  mouse.drawMouse();
  snake.move();
  snake.drawSnake();
  if(snakeEats())
  {
    mouseKilled = true;
    snake.addBodyPart();
  }
}

void keyPressed()
{
    if((key == 'w' || keyCode == UP) && snake.head.direction != 0 && !snake.head.locked)
    {
      snake.head.locked = true;
      snake.head.direction = 3;
      snake.head.changeDirectionAndNotify(3);
    }
    if((key == 'a' || keyCode == LEFT) && snake.head.direction != 1 && !snake.head.locked)
    {
      snake.head.locked = true;
      snake.head.direction = 2;
      snake.head.changeDirectionAndNotify(2);
    }
    if((key == 's' || keyCode == DOWN) && snake.head.direction != 3 && !snake.head.locked)
    {
      snake.head.locked = true;
      snake.head.direction = 0;
      snake.head.changeDirectionAndNotify(0);
    }
    if((key == 'd' || keyCode == RIGHT) && snake.head.direction != 2 && !snake.head.locked)
    {
      snake.head.locked = true;
      snake.head.direction = 1;
      snake.head.changeDirectionAndNotify(1);
    }
}

boolean snakeEats()
{
  if((snake.head.x>=mouse.x-killRange&&snake.head.x<=mouse.x+killRange) && (snake.head.y>=mouse.y-killRange&&snake.head.y<=mouse.y+killRange))
    return true;
  return false;
}
