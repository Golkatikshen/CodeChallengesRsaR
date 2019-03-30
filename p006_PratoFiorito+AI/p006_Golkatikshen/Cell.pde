class Cell
{
  float x;
  float y;
  float off_y;
  boolean darker;
  boolean unveiled;
  int num_mines;
  boolean is_mine;
  boolean end_game;
  boolean culprit;
  boolean win;
  boolean probable_mine;
  
  Cell(float _x, float _y, boolean _darker)
  {
    x = _x;
    y = _y;
    off_y = size_q/10;
    darker = _darker;
    unveiled = false;  
    is_mine = false;
    end_game = false;
    culprit = false;
    win = false;
    probable_mine = false;
  }
  
  void display()
  {
    if(unveiled)
    {
      if(darker)
        fill(220);
      else
        fill(250);
      if(culprit)
        fill(255, 0, 0);
      rect(x, y, size_q, size_q);
      
      if(!is_mine)
      {
        fill(10);
        if(num_mines != 0)
          text(num_mines, x+size_q/2, y+size_q/2-off_y);
      }

      if(end_game && is_mine)
      {
        if(win)
          fill(0, 200, 0);
        else
          fill(200, 0, 0);
        ellipse(x+size_q/2, y+size_q/2, size_q*0.6, size_q*0.6);
      }
    }
    else
    {
      if(darker)
        fill(120);
      else
        fill(150);
      rect(x, y, size_q, size_q);
      
      if(probable_mine)
      {
        fill(0, 0, 200);
        ellipse(x+size_q/2, y+size_q/2, size_q*0.6, size_q*0.6);
      }
    }
  }
  
  void endGame(boolean victory)
  {
    end_game = true;
    unveiled = true;
    win = victory;
  }
  
  int toggleProbableMine()
  {
    probable_mine = !probable_mine;
    if(probable_mine)
      return 1;
    else
      return -1;
  }
  
  boolean mouseHover()
  {
    return ((mouseX > x && mouseX < x+size_q) && (mouseY > y && mouseY < y+size_q));
  }
}
