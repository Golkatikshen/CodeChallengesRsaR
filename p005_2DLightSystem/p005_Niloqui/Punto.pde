class Punto{
  float x, y;
  
  Punto(float xx, float yy){
    x = xx;
    y = yy;
  }
  
  void cambiaCoord(Punto p){
    x = p.x;
    y = p.y;
  }
  
  boolean equals(Punto pun){
    return (pun.x == x) && (pun.y == y);
  }
  
  boolean equals(float xx, float yy){
    return (xx == x) && (yy == y);
  }
  
  float distQuad(Punto p){ // Distanza al quadrato
    return pow(x -p.x, 2) + pow(y -p.y, 2);
  }
  
  float prodVett(Punto p){ // this x p
    return (x*p.y - y*p.x);
  }
  
  float prodScal(Punto p){ // this * p
    return (x*p.x + y*p.y);
  }
  
  Punto addiz(float a, float b, Punto p){ //a*this + b*p
    return new Punto(a*x +b*p.x, a*y + b*p.y);
  }
  
}
