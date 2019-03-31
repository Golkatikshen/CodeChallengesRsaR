class MineSweeper
{
  int n_row;
  int n_col;
  float start_x;
  float start_y;
  boolean game_started = false;
  boolean end_game = false;
  Cell[][] cells;
  int tot_mines = 0;
  int num_flagged_mines = 0;
  
  MineSweeper(int _x, int _y)
  {
    n_col = _x;
    n_row = _y;
    cells = new Cell[n_row][n_col];
    
    start_x = width/2-(size_q*(float(n_col)/2));
    start_y = height/2-(size_q*(float(n_row)/2));
    
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        cells[i][j] = new Cell(start_x+size_q*j, start_y+size_q*i, (i%2==0)^(j%2==0));
        
    textAlign(CENTER, CENTER);
  }
  
  void display()
  { 
    fill(50);
    rect(start_x-3, start_y-3, size_q*n_col+6, size_q*n_row+6);
    
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        cells[i][j].display();
        
    textSize(15);
    fill(255);
    textAlign(LEFT);
    if(game_started)
    {
      text("Num mines: "+tot_mines, 5, 20);
      text("Num probable mines: "+num_flagged_mines, 5, 40);
      text("Right click to toggle flag", 5, 60);
    }
    if(end_game)
      text("Premi B per tornare al menù.", 5, 590);
    textAlign(CENTER, CENTER);
    textSize(size_q*0.9);
  }
  
  void click()
  {
    if(!end_game)
      for(int i=0; i<n_row; i++)
        for(int j=0; j<n_col; j++)
        {
          if(cells[i][j].mouseHover())
          {
            if(!game_started)
              startGame(i, j);
            clickCell(i, j);
          }
        }
  }
  
  void rightClick()
  {
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        if(cells[i][j].mouseHover() && !cells[i][j].unveiled)
          cells[i][j].toggleFlagMine();
          
    calcNumFlag();
  }
  
  void checkVictory()
  {
    if(tot_mines == calcNumVeiled())
    {
      end_game = true;
      for(int i=0; i<n_row; i++)
        for(int j=0; j<n_col; j++)
          cells[i][j].endGame(true);
    }
  }
  
  void startGame(int y, int x)
  {
    game_started = true;
    placeMines(y, x);
    calcNumCloseMines();
    calcTotMines();
  }
  
  void clickCell(int y, int x)
  {
    if(cells[y][x].is_mine)
    {
      end_game = true;
      cells[y][x].culprit = true;
      for(int i=0; i<n_row; i++)
        for(int j=0; j<n_col; j++)
          cells[i][j].endGame(false);
    }
    else
      recursivelyUnveil(y, x);
      
    calcNumFlag();
    checkVictory();
  }
  
  void recursivelyUnveil(int y, int x)
  {
    if(y<0 || y>=n_row || x<0 || x>=n_col)
      return;
    
    if(cells[y][x].unveiled)
      return;
      
    cells[y][x].unveiled = true;
    if(cells[y][x].num_mines != 0)
      return;
      
    recursivelyUnveil(y-1, x);
    recursivelyUnveil(y+1, x);
    recursivelyUnveil(y, x-1);
    recursivelyUnveil(y, x+1);
    recursivelyUnveil(y-1, x-1);
    recursivelyUnveil(y+1, x+1);
    recursivelyUnveil(y+1, x-1);
    recursivelyUnveil(y-1, x+1);
  }
  
  //Algoritmo per la generazione del campo
  void placeMines(int y, int x)
  {
    int num_to_place = int(n_col*n_row*(0.12+(diff*0.03))); //EASY 0.12 | NORMAL 0.15 | HARD 0.18
    ArrayList<Cell> poll = new ArrayList();
    
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        poll.add(cells[i][j]);
        
    //Rimozione della prima cella cliccata e di quelle nei dintorni
    //per evitare un inizio su una casella numerata o mina
    poll.remove(cells[y][x]);
    if(y!=0)
      poll.remove(cells[y-1][x]);
        
    if(y!=n_row-1)
      poll.remove(cells[y+1][x]);
        
    if(x!=0)
      poll.remove(cells[y][x-1]);
        
    if(x!=n_col-1)
      poll.remove(cells[y][x+1]);
        
    if(y!=0 && x!=0)
      poll.remove(cells[y-1][x-1]);
      
    if(y!=n_row-1 && x!=0)
      poll.remove(cells[y+1][x-1]);
      
    if(y!=0 && x!=n_col-1)
      poll.remove(cells[y-1][x+1]);
      
    if(y!=n_row-1 && x!=n_col-1)
      poll.remove(cells[y+1][x+1]);
    
    
    //println(num_to_place); //numero di mine da piazzare dato da (numero di celle)*(0.12+(diff*0.3))
    while(num_to_place != 0 && !poll.isEmpty())
    {
      Cell c = poll.get(int(random(0, poll.size())));
      int r = int(random(0, poll.size()));
      if(r <= num_to_place)
      {
        c.is_mine = true;
        num_to_place--;
      }
      poll.remove(c);
    }
  }
  
  //Calcola il numero di mine totali nella mappa
  void calcTotMines()
  {
    int count = 0;
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        if(cells[i][j].is_mine)
          count ++;
          
    tot_mines = count;
  }
  
  //Calcola il numero di celle ancora coperte
  int calcNumVeiled()
  {
    int count = 0;
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        if(!cells[i][j].unveiled)
          count ++;
          
    return count;
  }
  
  void calcNumFlag()
  {
    int count = 0;
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        if(cells[i][j].flag && !cells[i][j].unveiled)
          count ++;
          
    num_flagged_mines = count;
  }
  
  //Calcola il numero di mine vicine per ogni cella
  void calcNumCloseMines()
  {
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
      {
        Cell c = cells[i][j];
        
        if(i!=0)
          if(cells[i-1][j].is_mine)
            c.num_mines++;
            
        if(i!=n_row-1)
          if(cells[i+1][j].is_mine)
            c.num_mines++;
            
        if(j!=0)
          if(cells[i][j-1].is_mine)
            c.num_mines++;
            
        if(j!=n_col-1)
          if(cells[i][j+1].is_mine)
            c.num_mines++;
            
        if(i!=0 && j!=0)
          if(cells[i-1][j-1].is_mine)
            c.num_mines++;
            
        if(i!=n_row-1 && j!=0)
          if(cells[i+1][j-1].is_mine)
            c.num_mines++;
            
        if(i!=0 && j!=n_col-1)
          if(cells[i-1][j+1].is_mine)
            c.num_mines++;
            
        if(i!=n_row-1 && j!=n_col-1)
          if(cells[i+1][j+1].is_mine)
            c.num_mines++;
      }
  }
  
  
  //AI +-+-+-+-+-+-+-+-+-+-+-+
  
  void stepAI()
  {
    checkForSureMines();
  }
  
  void checkForSureFreeCells()
  {
    int count = 0;
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
        if(cells[i][j].unveiled && cells[i][j].num_mines != 0)
        {
          count = 0;
          
          if(i!=0)
            if(cells[i-1][j].flag)
              count++;
              
          if(i!=n_row-1)
            if(cells[i+1][j].flag)
              count++;
              
          if(j!=0)
            if(cells[i][j-1].flag)
              count++;
              
          if(j!=n_col-1)
            if(cells[i][j+1].flag)
              count++;
              
          if(i!=0 && j!=0)
            if(cells[i-1][j-1].flag)
              count++;
              
          if(i!=n_row-1 && j!=0)
            if(cells[i+1][j-1].flag)
              count++;
              
          if(i!=0 && j!=n_col-1)
            if(cells[i-1][j+1].flag)
              count++;
              
          if(i!=n_row-1 && j!=n_col-1)
            if(cells[i+1][j+1].flag)
              count++;
              
          if(count == cells[i][j].num_mines)
          {
            if(i!=0)
              if(!cells[i-1][j].unveiled && !cells[i-1][j].flag)
                clickCell(i-1, j);
                
            if(i!=n_row-1)
              if(!cells[i+1][j].unveiled && !cells[i+1][j].flag)
                clickCell(i+1, j);
                
            if(j!=0)
              if(!cells[i][j-1].unveiled && !cells[i][j-1].flag)
                clickCell(i, j-1);
                
            if(j!=n_col-1)
              if(!cells[i][j+1].unveiled && !cells[i][j+1].flag)
                clickCell(i, j+1);
                
            if(i!=0 && j!=0)
              if(!cells[i-1][j-1].unveiled && !cells[i-1][j-1].flag)
                clickCell(i-1, j-1);
                
            if(i!=n_row-1 && j!=0)
              if(!cells[i+1][j-1].unveiled && !cells[i+1][j-1].flag)
                clickCell(i+1, j-1);
                
            if(i!=0 && j!=n_col-1)
              if(!cells[i-1][j+1].unveiled && !cells[i-1][j+1].flag)
                clickCell(i-1, j+1);
                
            if(i!=n_row-1 && j!=n_col-1)
              if(!cells[i+1][j+1].unveiled && !cells[i+1][j+1].flag)
                clickCell(i+1, j+1);
          }
        }
  }
  
  void checkForSureMines()
  {
    int count = 0;
    for(int i=0; i<n_row; i++)
      for(int j=0; j<n_col; j++)
      {     
        count = 8;
        
        if(i!=0)
          if(cells[i-1][j].unveiled)
            count--;
            
        if(i!=n_row-1)
          if(cells[i+1][j].unveiled)
            count--;
            
        if(j!=0)
          if(cells[i][j-1].unveiled)
            count--;
            
        if(j!=n_col-1)
          if(cells[i][j+1].unveiled)
            count--;
            
        if(i!=0 && j!=0)
          if(cells[i-1][j-1].unveiled)
            count--;
            
        if(i!=n_row-1 && j!=0)
          if(cells[i+1][j-1].unveiled)
            count--;
            
        if(i!=0 && j!=n_col-1)
          if(cells[i-1][j+1].unveiled)
            count--;
            
        if(i!=n_row-1 && j!=n_col-1)
          if(cells[i+1][j+1].unveiled)
            count--;
            
        if(count == cells[i][j].num_mines)
        {
          if(i!=0)
            if(!cells[i-1][j].unveiled)
              cells[i-1][j].setFlagMine();
              
          if(i!=n_row-1)
            if(!cells[i+1][j].unveiled)
              cells[i+1][j].setFlagMine();
              
          if(j!=0)
            if(!cells[i][j-1].unveiled)
              cells[i][j-1].setFlagMine();
              
          if(j!=n_col-1)
            if(!cells[i][j+1].unveiled)
              cells[i][j+1].setFlagMine();
              
          if(i!=0 && j!=0)
            if(!cells[i-1][j-1].unveiled)
              cells[i-1][j-1].setFlagMine();
              
          if(i!=n_row-1 && j!=0)
            if(!cells[i+1][j-1].unveiled)
              cells[i+1][j-1].setFlagMine();
              
          if(i!=0 && j!=n_col-1)
            if(!cells[i-1][j+1].unveiled)
              cells[i-1][j+1].setFlagMine();
              
          if(i!=n_row-1 && j!=n_col-1)
            if(!cells[i+1][j+1].unveiled)
              cells[i+1][j+1].setFlagMine();
        }
      }
      
    calcNumFlag();
  }
}
