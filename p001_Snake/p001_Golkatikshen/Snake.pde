class Snake
{
  int cx; //cella_x
  int cy; //cella_y
  int pcx;
  int pcy; 
  int s;
  HEADING H;
  boolean changed;
  boolean perso;
  
  int clock;
  int wtime; //wait time
  
  BodyPart bp;
  
  int score;
  
  
  Snake(int _x, int _y, int _s)
  {
    cx = _x;
    cy = _y;
    pcx = cx;
    pcy = cy;
    s = _s;
    wtime = 200;
    score = 0;
    perso = false;
    
    changed = false;
    if(random(0, 1) == 0)
      H = HEADING.RIGHT;
    else
      H = HEADING.LEFT;
      
    clock = millis()+ wtime;
    
    bp = null;
    for(int i=0; i<4; i++)
      addBodyPart();
      
    surface.setTitle("SNAKE POWER - Score: 0");
  }
  
  void display()
  {
    //head graphics
    noStroke();
    fill(255, 0, 0);
    ellipse(cx*s+(float)s/2, cy*s+(float)s/2, s+1, s+1);
    if(bp != null)
      bp.display();
    
    //logic
    if(clock < millis())
    {
      changed = false;
      clock = millis() + wtime;
      pcx = cx;
      pcy = cy;
      
      switch(H)
      {        
        case UP:
        cy--;
        if(cy < 0)
          cy = height/s-1;
        break;
        
        case DOWN:
        cy++;
        if(cy > height/s-1)
          cy = 0;
        break;
        
        case LEFT:
        cx--;
        if(cx < 0)
          cx = width/s-1;
        break;
        
        case RIGHT:
        cx++;
        if(cx > width/s-1)
          cx = 0;
        break;
        
        default:
      }
      
      if(bp != null && H != HEADING.STOP)
      {
        bp.update(pcx, pcy);
        if(global_game_grid[cx][cy] == 2)
        {
          score += 10;
          surface.setTitle("SNAKE POWER - Score: " + score);
          destroyFoodIn(cx, cy);
          for(int i=0; i<5; i++)
            addBodyPart();
        }
          
        if(global_game_grid[cx][cy] == 1)
        {
          H = HEADING.STOP;
          perso = true;
          surface.setTitle("SNAKE POWER - Score: " + score + " - HAI PERSO! - Press r to restart");
        }
      }
    }
  }
  
  void addBodyPart()
  {
    if(bp == null)
      bp = new BodyPart(cx, cy, s);
    else
      bp.addBodyPart();
  }
}
