class Maze {
  
  Cell[][] cells;
  ArrayList<Cell> solution = new ArrayList<Cell>();
  boolean[][] visited;
  int wdh;
  int hgh;
  PVector[][] parents = new PVector[wdh][hgh];
  Cell start;
  Cell end;
  
  public Maze (int x, int y) { 
    wdh = x;
    hgh = y;
    cells = new Cell[x][y];
    visited = new boolean[x][y];
    parents = new PVector[x][y];
    
    for(int i = 0; i < x; i++) 
      for(int j = 0; j < y; j++) {
        visited[i][j] = false;
        cells[i][j] = new Cell(i, j, true);
      }
  }
  
  private ArrayList<Cell> neighbors(Cell cell) {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();
    int x = (int)cell.pos.x;
    int y = (int)cell.pos.y;
    
    if (x > 0 && !visited[x-1][y])
      neighbors.add(cells[x-1][y]);
    
    if (x < wdh-1 && !visited[x+1][y])
      neighbors.add(cells[x+1][y]);
      
    if (y > 0 && !visited[x][y-1])
      neighbors.add(cells[x][y-1]);
      
    if (y < hgh-1 && !visited[x][y+1])
      neighbors.add(cells[x][y+1]);
    
    return neighbors;
  }
  
  void visit(Cell curr, Cell prev) {
    int x = (int)curr.pos.x;
    int y = (int)curr.pos.y;
    parents[x][y] = prev.pos;
    
    visited[x][y] = true;
    ArrayList<Cell> neighbors = neighbors(curr);
    
    while(neighbors.size() > 0) {
      Cell next = neighbors.remove(floor(random(neighbors.size())));
      int nx = (int)next.pos.x;
      int ny = (int)next.pos.y;
      
      if(!visited[nx][ny]) {
        if(nx > x) {
          curr.walls.east = false;
          next.walls.west = false;
        }
        else if (nx < x) {
          curr.walls.west = false;
          next.walls.east = false;
        }
        else if (ny > y) {
          curr.walls.south = false;
          next.walls.north = false;
        }
        else if (ny < y) {
          curr.walls.north = false;
          next.walls.south = false;
        }
        visit(next, curr);
      }
       //<>//
    }
    
  }
  
  public void generate(PVector start, PVector end) {
    int sx = (int)start.x;
    int sy = (int)start.y;
    int ex = (int)end.x;
    int ey = (int)end.y;
    this.start = cells[sx][sy];
    this.end = cells[ex][ey];
    
    visit(cells[sx][sy], cells[sx][sy]);
    
    Cell path = cells[ex][ey];
  
    while(path.pos.x != sx || path.pos.y != sy) {
      int px = (int)path.pos.x;
      int py = (int)path.pos.y;
      
      PVector parent = parents[px][py];
      solution.add(path);
      path = cells[(int)parent.x][(int)parent.y];      
    }
  }
  
  public void mazeDraw(boolean sol) {
    background(0);
    
    if(sol) {
      fill(0,255,0);
      for(Cell c: solution) {
        int cx = (int)c.pos.x;
        int cy = (int)c.pos.y;
        
        rect(cx*scale, cy*scale, scale, scale);
      }
    }
    fill(0,0,255);
    rect(start.pos.x*scale, start.pos.y*scale, scale, scale);
    fill(255,0,0);
    rect(end.pos.x*scale, end.pos.y*scale, scale, scale);
    
    for(int i = 0; i < wdh; i++)
      for(int j = 0; j < hgh; j++)
        cells[i][j].wallDraw(); //<>//
  }
  
  
  
}
