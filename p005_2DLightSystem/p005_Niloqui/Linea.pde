class Linea {
  Punto p1, p2;
  
  Linea(Punto p1, Punto p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  
  Linea(float x1, float y1, float x2, float y2){
    p1 = new Punto(x1, y1);
    p2 = new Punto(x2, y2);
  }
  
  void disegna(){
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  
  
}
