boolean dentro_triangolo=false;
Point a, b, c;

void setup(){
  println("Premere 'c' per cambiare triangolo.");
  size(1120, 630); // (16 * 70):(9 * 70)
  randomizza_vertici();
  
  disegna_triangolo();
}

void disegna_triangolo(){
  randomizza_colore();
  background(0, 128, 128);
  triangle(a.x, a.y, b.x, b.y, c.x, c.y);
}

void randomizza_vertici(){
  a = new Point(random(0, 1120), random(0, 630));
  b = new Point(random(0, 1120), random(0, 630));
  c = new Point(random(0, 1120), random(0, 630));
}

void keyPressed(){
  if ((key == 'c') || (key == 'C')) {
    randomizza_vertici();
    disegna_triangolo();
  }
}

void draw(){
  if( mouse_dentro_triangolo(a, b, c) ){
    if(!dentro_triangolo){
      randomizza_colore();
      triangle(a.x, a.y, b.x, b.y, c.x, c.y);
      dentro_triangolo = true;
    }
  }
  else{
    if(dentro_triangolo){
      dentro_triangolo = false;
    }
  }
}

boolean mouse_dentro_triangolo(Point a, Point b, Point c){
  Point maus = new Point(mouseX, mouseY);
  
  if( coso(a, b, c, maus) )
    if( coso(b, a, c, maus) )
      return true;
  
  return false;
}

boolean coso(Point o, Point p1, Point p2, Point p){
  PVector v1 = new PVector(1, 0), v2; //<>//
  
  v2 = new PVector(p1.x -o.x, p1.y -o.y);
  float op1 = PVector.angleBetween(v1, v2);
  if(o.y < p1.y) op1 *= -1;
  v2 = new PVector(p2.x -o.x, p2.y -o.y);
  float op2 = PVector.angleBetween(v1, v2);
  if(o.y < p2.y) op2 *= -1;
  v2 = new PVector(p.x -o.x, p.y -o.y);
  float op = PVector.angleBetween(v1, v2);
  if(o.y < p.y) op *= -1;
  
  if( op1-op2 > PI ){
    op2 += 2*PI;
    if(op < 0) op += 2*PI;
  }
  else if( op2-op1 > PI ){
    op1 += 2*PI;
    if(op < 0) op += 2*PI;
  }
  
  if( op1 > op2 ){
    if( (op <= op1) && (op >= op2) )
      return true;
  }
  else{
    if( (op >= op1) && (op <= op2) )
      return true;
  }
  
  return false;
}

void randomizza_colore(){
  fill(random(0, 255), random(0, 255), random(0, 255));
}
