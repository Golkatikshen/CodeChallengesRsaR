int good_chance = 15;
int bad_chance = 1;

class River {
  int max_x;
  int max_y;
  int min_x;
  int min_y;
  Coordinate start;
  Coordinate end;
  boolean found = false;
  boolean dead = false;
  
  boolean[][] visited;
  Coordinate[][] parents;
  
  public River(Coordinate start, Coordinate end) {
    max_x = max(start.x, end.x);
    max_y = max(start.y, end.y);
    min_x = min(start.x, end.x);
    min_y = min(start.y, end.y);
    this.start = start;
    this.end = end;
    
    parents = new Coordinate[max_x-min_x+1][max_y-min_y+1];
    visited = new boolean[max_x-min_x+1][max_y-min_y+1];
    this.generate(); //<>//
  }
  
  private void generate() {
    this.visit(start, start);    
  }
  
  private void visit(Coordinate curr, Coordinate prev) {
    HashMap<dir, Integer> chance = new HashMap<dir, Integer>();
    
    int x = curr.x;
    int y = curr.y;
    int tot_chance = 0;
    visited[x-min_x][y-min_y] = true;
    parents[x-min_x][y-min_y] = prev;
    
    if(x == end.x && y == end.y) {
      found = true;
      return;
    }
    
    if(x < max_x) {
      if (x < end.x)
        chance.put(dir.EAST, good_chance);
      else
        chance.put(dir.EAST, bad_chance);
    }
      
    if(y < max_y) {
      if (y < end.y)
        chance.put(dir.SOUTH, good_chance);
      else
        chance.put(dir.SOUTH, bad_chance);
    }
      
    if(x > min_x) {
      if (x > end.x)
        chance.put(dir.WEST, good_chance);
      else
        chance.put(dir.WEST, bad_chance);
    }
      
    if(y > min_y) {
      if (y > end.y)
        chance.put(dir.NORTH, 5);
      else
        chance.put(dir.NORTH, 1);
    }
      
    for(int val: chance.values())
      tot_chance += val;
    
    if(chance.size() == 0) {
      return;
    }
    
    Coordinate next;
    while(tot_chance > 0) {
       for(dir k: chance.keySet()) {
         next = null;
         float r = random(1);
         
         if (r < (float)chance.get(k)/(float)tot_chance) {
           tot_chance -= chance.get(k);
           chance.put(k, 0);
           if(k == dir.NORTH && !visited[x-min_x][y-1-min_y])
             next = new Coordinate(x, y-1);
           if(k == dir.SOUTH && !visited[x-min_x][y+1-min_y])
             next = new Coordinate(x, y+1);
           if(k == dir.EAST && !visited[x+1-min_x][y-min_y])
             next = new Coordinate(x+1, y);
           if(k == dir.WEST && !visited[x-1-min_x][y-min_y])
             next = new Coordinate(x-1, y);
         }
         if (next != null && !found)
           visit(next, curr);
       }
    }    
  }
  
  public void place() {
    ArrayList<Coordinate> riv = new ArrayList<Coordinate>();
    
    Coordinate path = end;
    while(path.x != start.x || path.y != start.y) {
      int px = path.x;
      int py = path.y;
      
      Coordinate parent = parents[px-min_x][py-min_y];
      riv.add(path);
      path = parent;
    }
    
    for(Coordinate c: riv) {
      t_map[c.x][c.y] = b_type.WATER; 
    }
    t_map[start.x][start.y] = b_type.WATER;
  }
  
}
