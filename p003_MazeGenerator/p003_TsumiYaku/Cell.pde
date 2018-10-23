class Cell {
  class Walls {
    boolean north;
    boolean south;
    boolean east;
    boolean west;
    
    Walls(boolean w) {
      north = w;
      south = w;
      east = w;
      west = w;
    }
  }
  
  PVector pos;
  Walls walls;
  
  Cell(int x, int y, boolean w) {
    pos = new PVector(x,y);
    walls = new Walls(w);
  }
  
  public void wallDraw() {
    fill(255);
    if (walls.north)
      rect(pos.x*scale, pos.y*scale, scale, 1);
      
    if (walls.south)
      rect(pos.x*scale, (pos.y+1)*scale-1, scale, 1);
      
    if (walls.west)
      rect(pos.x*scale, pos.y*scale, 1, scale);
      
    if (walls.east)
      rect((pos.x+1)*scale-1, pos.y*scale, 1, scale);
    }
  
}
