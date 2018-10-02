static final int CONST_GRID = 20, ALTE = 600, LARG = 800,
      ALTEDIV = 30, LARGDIV = 40; // Altezza e larghezza già divise per la griglia
color col_snake;
color col_cibo[];
boolean gameover;
ArrayList<Casella> snake;
Casella head;
Casella cibo;
Direzione direz, new_direz;

/* la griglia e' fatta da rettangoli 20*20
 */

boolean spazio_libero(Casella test, int i){
  int N=snake.size();
  
  for(; i<N; i++){
    Casella temp = snake.get(i);
    if( (temp.x == test.x) && (temp.y == test.y) ){
      return false;
    }
  }
  
  return true;
}

void genera_coordinate_cibo(){
  cibo.x = (int)random(0, LARGDIV-0.01) * CONST_GRID;
  cibo.y = (int)random(0, ALTEDIV-0.01) * CONST_GRID;
  
  while(!spazio_libero(cibo, 0)){
    cibo.x += CONST_GRID;
    if(cibo.x >= LARG) cibo.x-= LARG;
  }
  
  cibo.colore = (int)random(0, 2.99);
}

void condizioni_iniziali(){
  head = new Casella(200, 300, Tipo.TESTA);
  cibo = new Casella(0, 0, Tipo.CIBO);
  snake = new ArrayList<Casella>();
  direz = (new_direz  = Direzione.FERMO);
  gameover = false;

  snake.add(head);
  genera_coordinate_cibo();
}

void setup(){
  col_cibo = new color[] {color(#FF6262), color(#FFCF48), color(#F5F179)};
  col_snake = color(#30E337);
  condizioni_iniziali();
  
  size(800, 600);
  background(20);
  cibo.disegna();
  head.disegna();
  //frameRate(60); // Forse da modificare
}

void draw(){
  if(gameover){
    textSize(50);
    fill(255);
    text("Game Over", 250, 200);
    text("Click 'r' to restart", 250, 270);
    if(keyPressed == true && (key=='r' || key=='R')){
      condizioni_iniziali();
    }
  }
  else{
    head.move(direz);
    direz = new_direz;
    if(head.x == cibo.x && head.y == cibo.y){
      Casella ultima, nuova;
      int i=0;
      genera_coordinate_cibo();
      
      for(;i<(cibo.colore%2 +1); i++){
        ultima = snake.get(snake.size() -1);
        nuova = new Casella(ultima.x, ultima.y, Tipo.CORPO);
        ultima.next = nuova;
        snake.add(nuova);
      }
    }
    else if(!spazio_libero(head, 1)){
      gameover = true;
    }
    
    //delay(20); 
    // Scommentare l'istruzione sopra per andare piu' piano
    background(20);
    cibo.disegna();
    head.disegna();
  } //<>//
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        if(direz != Direzione.SOTTO) new_direz = Direzione.SOPRA;
        break;
      case DOWN:
        if(direz != Direzione.SOPRA) new_direz = Direzione.SOTTO;
        break;
      case LEFT:
        if(direz != Direzione.DESTRA) new_direz = Direzione.SINISTRA;
        break;
      case RIGHT:
        if(direz != Direzione.SINISTRA) new_direz = Direzione.DESTRA;
        break;
    }
  }
}
