class BodyPart
{
  int cx;
  int cy;
  int pcx;
  int pcy; 
  int s;
  int off;
  
  BodyPart bp;
  
  BodyPart(int _x, int _y, int _s)
  {
    cx = _x;
    cy = _y;
    s = _s;
    off = 4;
    
    bp = null;
  }
  
  void display()
  {
    rect(cx*s+off, cy*s+off, s-(off*2)+1, s-(off*2)+1);
    if(bp != null)
      bp.display();
  }
  
  void update(int x, int y)
  {
    pcx = cx;
    pcy = cy;
    cx = x;
    cy = y;
    
    global_game_grid[pcx][pcy] = 0;
    global_game_grid[cx][cy] = 1;
    
    if(bp != null)
      bp.update(pcx, pcy);
  }
  
  void addBodyPart()
  {
    if(bp == null)
      bp = new BodyPart(cx, cy, s);
    else
      bp.addBodyPart();
  }
}
