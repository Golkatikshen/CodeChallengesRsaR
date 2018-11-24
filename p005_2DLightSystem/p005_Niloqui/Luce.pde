class Luce{
  class LinVisibile{
    // Mi serve perchè 
    Linea linea;
    boolean muro;
    
    LinVisibile(Linea lin, boolean muro){
      linea = lin;
      this.muro = muro;
    }
    
  }
  
  Punto c;
  ArrayList<LinVisibile> muriVisibili = new ArrayList();
  
  Luce(Punto c){
    this.c = c;
  }
  
  Luce(float x, float y){
    this.c = new Punto(x, y);
  }
  
  void disegna(boolean drawmode){
    muriVisibili.clear();
    
    if(drawmode){
      // Se in modalità drawmode, il campo luminoso non viene disegnato
      ellipse(c.x, c.y, 8, 8);
    }
    else{
      ellipse(c.x, c.y, 2, 2);
      
    }
    
    
    
    
  }
  
  
  
  
  
  
}
