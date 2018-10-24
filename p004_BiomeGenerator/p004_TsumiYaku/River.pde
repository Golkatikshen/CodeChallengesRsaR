class River {
  int max_x;
  int max_y;
  int min_x;
  int min_y;
  Coordinate start;
  Coordinate end;
  
  boolean[][] visited;
  Coordinate[][] parents;
  
  public River(Coordinate start, Coordinate end) {
    max_x = max(start.x, end.x);
    max_y = max(start.y, end.y);
    min_x = min(start.x, end.x);
    min_y = min(start.y, end.y);
    this.start = start;
    this.end = end;
    
    parents = new Coordinate[max_x-min_x][max_y-min_y];
    visited = new boolean[max_x-min_x][max_y-min_y];
    this.generate();
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
    
    if(x < max_x-1 && !visited[x+1][y]) {
      if (x < end.x)
        chance.put(dir.EAST, 5);
      else
        chance.put(dir.EAST, 1);
    }
    else
      chance.put(dir.EAST, 0);
      
    if(y < max_y-1 && !visited[x][y+1]) {
      if (y < end.y)
        chance.put(dir.SOUTH, 5);
      else
        chance.put(dir.SOUTH, 1);
    }
    else
      chance.put(dir.SOUTH, 0);
      
    if(x > min_x && !visited[x-1][y]) {
      if (x > end.x)
        chance.put(dir.WEST, 5);
      else
        chance.put(dir.WEST, 1);
    }
    else
      chance.put(dir.WEST, 0);
      
    if(y > min_y && !visited[x][y-1]) {
      if (y > end.y)
        chance.put(dir.NORTH, 5);
      else
        chance.put(dir.NORTH, 1);
    }
    else
      chance.put(dir.NORTH, 0);
      
    for(int val: chance.values())
      tot_chance += val;
      
    Coordinate next = null;
    while(tot_chance > 0) {
       for(dir k: chance.keySet()) {
         next = null;
         float r = random(1);
         
         if (r < (float)chance.get(k)/(float)tot_chance) { //<>//
           tot_chance -= chance.get(k);
           chance.put(k, 0);
           if(k == dir.NORTH)
             next = new Coordinate(x, y-1);
           if(k == dir.SOUTH)
             next = new Coordinate(x, y+1);
           if(k == dir.EAST)
             next = new Coordinate(x+1, y);
           if(k == dir.WEST)
             next = new Coordinate(x-1, y);
         }
         if (next != null)
           visit(next, curr);
       }
    }    
  }
  
  public void riverDraw() {
    ArrayList<Coordinate> riv = new ArrayList<Coordinate>();
    
    Coordinate path = end;
    while(path.x != start.x || path.y != start.y) {
      int px = path.x;
      int py = path.y;
      
      Coordinate parent = parents[px-min_x][py-min_y];
      riv.add(path);
      path = parent;
    }
    
    fill(colors.get(b_type.WATER));
    for(Coordinate c: riv) {
      rect(c.x*scale, c.y*scale, scale, scale); 
    }
  }
  
}
