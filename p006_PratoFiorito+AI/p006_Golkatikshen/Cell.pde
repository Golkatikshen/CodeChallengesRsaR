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
  boolean flag;
  boolean anti_flag;
  
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
    flag = false;
    anti_flag = false;
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
        if(num_mines != 0)
        {
          if(num_mines == 1)
            fill(0, 10, 255);
          if(num_mines == 2)
            fill(20, 200, 20);
          if(num_mines == 3)
            fill(220, 0, 0);
          if(num_mines == 4)
            fill(0, 0, 150);
          if(num_mines == 5)
            fill(112, 0, 0);
          if(num_mines == 6)
            fill(15, 114, 175);
          if(num_mines == 7)
            fill(10);
          if(num_mines == 8)
            fill(130);
          text(num_mines, x+size_q/2, y+size_q/2-off_y);
        }
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
        fill(100);
      else
        fill(120);
      rect(x, y, size_q, size_q);
      
      if(flag)
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
  
  int toggleFlagMine()
  {
    flag = !flag;
    if(flag)
      return 1;
    else
      return -1;
  }
  
  void setFlagMine(Cell c)
  {
    //if(!flag)
    //println(x, y, c.x, c.y);
    flag = true;
  }
  
  void setAntiFlagMine()
  {
    anti_flag = true;
  }
  
  String getInfos(boolean b)
  {
    return x+", "+y+", "+b;
  }
  
  boolean mouseHover()
  {
    return ((mouseX > x && mouseX <= x+size_q) && (mouseY > y && mouseY <= y+size_q));
  }
}
