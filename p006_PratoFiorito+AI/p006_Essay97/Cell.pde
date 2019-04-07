class Cell {
  char type; 
  boolean mine;
  static final float dim = 28;
  float x, y;
  int surroundingMines = 0;
  PFont f;
  
  Cell(char _type, boolean _mine, int _x, int _y) {
    type = _type;
    mine = _mine;
    x = _x*dim+(width-dim*N)/2;
    y = _y*dim+(height-dim*M)/2;
    f = createFont("Arial", 20, true);
  }
  
  void display() {
    rectMode(CORNER);
    fill(this.getColor());
    stroke(20);
    rect(x, y, dim, dim);
    
    if(type == 'p' && surroundingMines != 0){
      textFont(f);
      textAlign(LEFT, TOP);
      fill(#031DFF);
      text(str(surroundingMines), x+9, y+3); //offset a minchia almeno il numero sta al centro
    }
    
  }
  
  color getColor(){
    switch(type) {
      case 'n':
        return 180;
      case 'p':
        return 120;
      case 'm':
        return #F5472C;
    }
    return -1;
  }
  
  
  
  
}
