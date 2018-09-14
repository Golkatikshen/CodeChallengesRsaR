class BodyPart
{
  boolean neck = false; //neck = seconda BodyPart
  float x, changeAtX=-1;
  float y, changeAtY=-1;
  final float separation = 15;
  final float movement = 1;
  int direction, newDirection = 4;
  BodyPart nextBodyPart = null;
  
  BodyPart(BodyPart lastBodyPart)
  {
    switch(lastBodyPart.direction)
    {
      case 0: //Going down
        x = lastBodyPart.x;
        y = lastBodyPart.y-separation;
        break;
      case 1: //Going right
        x = lastBodyPart.x-separation;
        y = lastBodyPart.y;
        break;
      case 2: //Going left
        x = lastBodyPart.x+separation;
        y = lastBodyPart.y;
        break;
      case 3: //Going up
        x = lastBodyPart.x;
        y = lastBodyPart.y+separation;
        break;
    }
    direction = lastBodyPart.direction;
  }
   
   BodyPart(int x, int y)
   {
     this.x = x;
     this.y = y;
   }
   
  void move(Head head)
  {
    //Checks if a body part has to change direction
    if(x!=changeAtX || y!=changeAtY)
    {
      switch(direction)
      {
        case 0: //Down
          y+=movement;
          break;
        case 1: //Right
          x+=movement;
          break;
        case 2: //Left
          x-=movement;
          break;
        case 3: //Up
          y-=movement;
          break;
      }
    }
    else
    {
      //When the neck moved, the head is free to turn again
      if(neck)
        head.locked = false;
      changeDirectionAndNotify(newDirection);
      move(head);
    }
    //Checks if Snake went off the screen
    if(x == -5)
      x = 505;
    else if(x == 505)
      x = -5;
    else if(y == -5)
      y = 505;
    else if(y == 505)
      y = -5;
  }
  
  void changeDirectionAndNotify(int newDirection)
  {
    direction = newDirection;
    if(nextBodyPart != null)
    {
      //Notifies the next body part when to turn and where to turn
      nextBodyPart.changeAtX = x;
      nextBodyPart.changeAtY = y;
      nextBodyPart.newDirection = newDirection;
    }
    changeAtX = -1;
    changeAtY = -1;
    newDirection = 4;
  }
}
