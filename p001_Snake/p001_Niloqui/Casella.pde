enum Direzione { SOPRA, SOTTO, DESTRA, SINISTRA, FERMO };
enum Tipo { TESTA, CORPO, CIBO };

class Casella{
  Direzione dir = Direzione.FERMO;
  Tipo tipo;
  int x, y;
  
  Casella(int x, int y, Tipo type){
    tipo = type;
    this.x = x;
    this.y = y;
  }
  
  void move(Direzione nuova_dir){
    switch(dir){
      case SOPRA:
        y -= CONST_GRID;
        break;
      case SOTTO:
        y += CONST_GRID;
        break;
      case DESTRA:
        x += CONST_GRID;
        break;
      case SINISTRA:
        x -= CONST_GRID;
        break;
    }
    
    dir = nuova_dir;
  }
  
  void disegna(){
    // TO-DO
    // QUANDO SI HA VOGLIA
  }
  
  
}
