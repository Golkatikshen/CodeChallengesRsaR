enum Direzione { SOPRA, SOTTO, DESTRA, SINISTRA, FERMO };
enum Tipo { TESTA, CORPO, CIBO };

class Casella{
  Direzione dir = Direzione.FERMO;
  Tipo tipo;
  int x, y, colore=0; // colore serve solo per il cibo
  Casella next = null;
  
  Casella(int x, int y, Tipo type){
    tipo = type;
    this.x = x;
    this.y = y;
  }
  
  void move(Direzione nuova_dir){
    switch(dir){
      case SOPRA:
        y -= 5;
        if(y < 0) y+= ALTE;
        break;
      case SOTTO:
        y += 5;
        if(y >= ALTE) y-= ALTE;
        break;
      case DESTRA:
        x += 5;
        if(x >= LARG) x-= LARG;
        break;
      case SINISTRA:
        x -= 5;
        if(x < 0) x+= LARG;
        break;
      case FERMO:
        break;
    }
    
    if(next != null)
      next.move(dir);
    
    if(mov == 0)
      dir = nuova_dir;
  }
  
  void disegna(){
    switch(tipo){
      case TESTA:
        fill(col_snake);
        rect(x+1, y+1, 18, 18);
        break;
      case CORPO:
        fill(col_snake);
        rect(x+3, y+3, 14, 14);
        break;
      case CIBO:
        fill(col_cibo[colore]);
        rect(x+2, y+2, 16, 16);
        break;
    }
    if(next != null)
      next.disegna();
  }
  
}
