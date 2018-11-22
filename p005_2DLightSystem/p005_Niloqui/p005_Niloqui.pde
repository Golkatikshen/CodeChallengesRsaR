ArrayList<Punto> luci = new ArrayList();
//ArrayList<Punto> puntiOggetti = new ArrayList<>();
//ArrayList<PVector> linee = new ArrayList();
ArrayList<Linea> linee = new ArrayList();
boolean cambiamenti = false, drawmode = false;
Punto temp, temp2;
char cartemp;

void reset(){
  background(20, 20, 20);
  
  linee.add(new Linea(-1, -1, -1, 721));
  linee.add(new Linea(-1, 721, 1281, 721));
  linee.add(new Linea(1281, 721, 1281, -1));
  linee.add(new Linea(-1, -1, 1281, -1));
}

int sign(float num){
  return num>0?1:(num<0?-1:0);
}

void set_valori_disegno(char param){
  switch(param){
  case 'c': // linee di costruzione
    stroke(255);
    strokeWeight(1);
    
    break;
  case 's': // sorgenti di luci
    noStroke();
    fill(255);
    
    break;
  case 'l': // linee
    stroke(255);
    strokeWeight(2);
    
    break;
  }
  
  
}


void setup(){
  size(1280, 720); // NON CAMBIARE QUESTI VALORI
  reset();
}

void draw(){
  if(cambiamenti || drawmode){ // Se sono state apportate modifiche ridisegna lo schermo
    reset();
    int i, N;
    
    // Disegna linee
    set_valori_disegno('l'); //<>//
    N = linee.size();
    Linea vl[] = new Linea[N];
    vl = linee.toArray(vl);
    
    for(i=0; i<N; i++){
      line(vl[i].p1.x, vl[i].p1.y, vl[i].p2.x, vl[i].p2.y);
    }
    
    
    // Disegna luci
    set_valori_disegno('s');
    N = luci.size();
    Punto vs[] = new Punto[N];
    vs = luci.toArray(vs);
    
    for(i=0; i<N; i++){
      // TO-DO
      // TO-DO
      // TO-DO
      
      
      ellipse(vs[i].x, vs[i].y, 8, 8);
      
      
      // TO-DO
      // TO-DO
      // TO-DO
    }
    
    if(!drawmode){ // La luce la disegno solo se non ci sono strutture momentanee
      // TO-DO
      // TO-DO
      
      for(i=0; i<N; i++){
        // TO-DO
        // TO-DO
        // TO-DO
      }
      
      // TO-DO
      // TO-DO
    }
    
    
    
    // Disegna oggetti temporanei
    if(drawmode){
      // PVector vtemp;
      
      switch(cartemp){
      case 'q': // disegna un quadrato
        float val = min(abs(mouseX - temp.x), abs(mouseY - temp.y));
        int signx = sign(mouseX - temp.x), signy = sign(mouseY - temp.y);
        
        set_valori_disegno('c');
        line(temp.x, temp.y, temp.x + val*signx, temp.y + val*signy);
        line(temp.x, temp.y, temp.x, temp.y + val*signy);
        line(temp.x, temp.y, temp.x + val*signx, temp.y);
        line(temp.x + val*signx, temp.y, temp.x + val*signx, temp.y + val*signy);
        line(temp.x, temp.y + val*signy, temp.x + val*signx, temp.y + val*signy);
        break;
        
      case 'r': // disegna un rettangolo
        set_valori_disegno('c');
        line(temp.x, temp.y, mouseX, mouseY);
        line(temp.x, temp.y, temp.x, mouseY);
        line(temp.x, temp.y, mouseX, temp.y);
        line(mouseX, temp.y, mouseX, mouseY);
        line(temp.x, mouseY, mouseX, mouseY);
        break;
        
      case 'l': // disegna una linea
        set_valori_disegno('c');
        line(temp.x, temp.y, mouseX, mouseY);
        break;
      
      case 'p': // disegna una poligono irregolare
        set_valori_disegno('c');
        line(temp.x, temp.y, mouseX, mouseY);
        break;
        
      case ' ':
        
        
        
        break;
        
      }
      
      
      
      
    }
    
    
    
    
    
    cambiamenti = false;
  }
  else{ 
    
    
    
  }
  
  
}
// ---- Fine funzione draw()



void keyPressed(){
  if(key == 'c'){ // clear
    luci.clear();
    linee.clear();
    cambiamenti = true;
    reset();
  }
  else if(key == 'q'){
    
    
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    cambiamenti = true;
    
    if(drawmode){
      switch(cartemp){
      case 'q': // disegna un quadrato
        drawmode = false;
        float val = min(abs(mouseX - temp.x), abs(mouseY - temp.y));
        int signx = sign(mouseX - temp.x), signy = sign(mouseY - temp.y);
        
        //linee.add(new Linea(temp.x, temp.y, temp.x + val*signx, temp.y + val*signy));
        linee.add(new Linea(temp.x, temp.y, temp.x, temp.y + val*signy));
        linee.add(new Linea(temp.x, temp.y, temp.x + val*signx, temp.y));
        linee.add(new Linea(temp.x + val*signx, temp.y, temp.x + val*signx, temp.y + val*signy));
        linee.add(new Linea(temp.x, temp.y + val*signy, temp.x + val*signx, temp.y + val*signy));
        break;
      
      case 'r': // disegna un rettangolo
        linee.add(new Linea(temp.x, temp.y, temp.x, mouseY));
        linee.add(new Linea(temp.x, temp.y, mouseX, temp.y));
        linee.add(new Linea(mouseX, temp.y, mouseX, mouseY));
        linee.add(new Linea(temp.x, mouseY, mouseX, mouseY));
        
        drawmode = false;
        break;
      
      case 'p': // disegna una poligono irregolare
        if( keyPressed && (key == CODED) ){
          if( keyCode == CONTROL ){ // 'close', chiudi la figura
            linee.add(new Linea(temp2.x, temp2.y, mouseX, mouseY));
            drawmode = false;
            
          }
          else if( keyCode == ALT ){ // 'stop', la figura rimane aperta
            drawmode = false;
            
            
          }
          
          
        }
        
        linee.add(new Linea(temp.x, temp.y, mouseX, mouseY));
        temp = new Punto(mouseX, mouseY);
        
        break;
        
      case 'l': // disegna una linea
        drawmode = false;
        linee.add(new Linea(temp.x, temp.y, mouseX, mouseY));
        break;
      
      case ' ':
        drawmode = false;
        
        break;
        
        
      }
      
      
    }
    else if(keyPressed){
      switch(cartemp = key){
      case 'p': // disegna una poligono irregolare
        temp2 = new Punto(mouseX, mouseY);
      case 'q': // disegna un quadrato
      case 'r': // disegna un rettangolo
      case 'l': // disegna una linea
        temp = new Punto(mouseX, mouseY);
        drawmode = true;  
        break;
        
      case ' ':
        
        
        drawmode = true;
        
        break;
        
        
      }
      
      
      
      
    }
    else{ // Posiziona una luce
      luci.add(new Punto(mouseX, mouseY));
    }
    
    
    
  }
}
