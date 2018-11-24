ArrayList<Luce> luci = new ArrayList();
ArrayList<Punto> punti = new ArrayList();
// ArrayList<Punto> punti_costruzione = new ArrayList();

ArrayList<Linea> linee = new ArrayList();
ArrayList<Linea> linee_costruzione = new ArrayList();

boolean cambiamenti = true, drawmode = false;
Punto temp, temp2, temp3, temp4;
char cartemp;
final boolean DEBUG = true;

void setup(){
  size(1280, 720); // NON CAMBIARE QUESTI VALORI
  
  luci.clear();
  punti.clear();
  linee.clear();
  linee_costruzione.clear();
  
  reset(true);
}

void reset(boolean hardReset){
  background(20, 20, 20);
  
  if(hardReset){
    Punto pippo[] = new Punto[4];
    punti.add(pippo[0] = new Punto(-1, -1));
    punti.add(pippo[1] = new Punto(-1, 720));
    punti.add(pippo[2] = new Punto(1280, 720));
    punti.add(pippo[3] = new Punto(1280, -1));
    
    linee.add(new Linea(pippo[0], pippo[1]));
    linee.add(new Linea(pippo[1], pippo[2]));
    linee.add(new Linea(pippo[2], pippo[3]));
    linee.add(new Linea(pippo[3], pippo[0]));
  }
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
    
  case 'l': // linee spente
    stroke(#898989);
    strokeWeight(1);
    break;
    
  case 'i': // linee illuminate
    stroke(255);
    strokeWeight(2);
    break;
    
  case 'd': // Singoli punti, debug mode only
    strokeWeight(2);
    stroke(0, 0, 255);
    fill(0, 255, 0);
    break;
  }
}


void draw(){
  if(cambiamenti || drawmode){ // Se sono state apportate modifiche ridisegna lo schermo
    cambiamenti = false;
    reset(false);
    int i, N;
    
    // Disegna linee
    set_valori_disegno('l');
    N = linee.size();
    
    for(i=0; i<N; i++){
      linee.get(i).disegna();
    }
    
    // Disegna punti, debug mode only
    if(DEBUG){
      set_valori_disegno('d');
      Punto p;
      N = punti.size();
      
      for(i=0; i<N; i++){
        p = punti.get(i);
        ellipse( p.x, p.y, 8, 8);
      }
    }
    
    // Disegna luci
    set_valori_disegno('s');
    N = luci.size();
    
    for(i=0; i<N; i++){
      luci.get(i).disegna(drawmode);
    }
    
    // Disegna oggetti temporanei
    set_valori_disegno('c');
    if(drawmode){
      switch(cartemp){
      case 'q': // disegna un quadrato
        float val = min(abs(mouseX - temp.x), abs(mouseY - temp.y));
        int signx = sign(mouseX - temp.x), signy = sign(mouseY - temp.y);
        
        line(temp.x, temp.y, temp.x + val*signx, temp.y + val*signy);
        line(temp.x, temp.y, temp.x, temp.y + val*signy);
        line(temp.x, temp.y, temp.x + val*signx, temp.y);
        line(temp.x + val*signx, temp.y, temp.x + val*signx, temp.y + val*signy);
        line(temp.x, temp.y + val*signy, temp.x + val*signx, temp.y + val*signy);
        break;
        
      case 'r': // disegna un rettangolo
        line(temp.x, temp.y, mouseX, mouseY);
        line(temp.x, temp.y, temp.x, mouseY);
        line(temp.x, temp.y, mouseX, temp.y);
        line(mouseX, temp.y, mouseX, mouseY);
        line(temp.x, mouseY, mouseX, mouseY);
        break;
        
      case 'l': // disegna una linea
        line(temp.x, temp.y, mouseX, mouseY);
        break;
      
      case 'p': // disegna una poligono irregolare
        line(temp3.x, temp3.y, mouseX, mouseY);
        break;
      }
    }
  }
}
// ---- Fine funzione draw()



void keyPressed(){
  if(key == 'c'){ // clear
    cambiamenti = true;
    luci.clear();
    linee.clear();
    punti.clear();
    linee_costruzione.clear();
    reset(true); // Viene già eseguita nel draw
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    cambiamenti = true;
    Punto vet[];
    int i, j;
    
    if(drawmode){
      if( (mouseX!=temp.x) && (mouseY!=temp.y) ){
        switch(cartemp){
        case 'q': // disegna un quadrato
        case 'r': // disegna un rettangolo
          vet = new Punto[4];
          float newx, newy;
          
          if(cartemp == 'q'){
            float val = min(abs(mouseX - temp.x), abs(mouseY - temp.y));
            int signx = sign(mouseX - temp.x), signy = sign(mouseY - temp.y);
            newy = temp.y + val*signy;
            newx = temp.x + val*signx;
          }
          else{
            newy = mouseY;
            newx = mouseX;
          }
          vet[0] = trova_punto_eo_aggiungi(temp.x, temp.y, punti, true);
          vet[1] = trova_punto_eo_aggiungi(newx, temp.y, punti, true);
          vet[2] = trova_punto_eo_aggiungi(newx, newy, punti, true);
          vet[3] = trova_punto_eo_aggiungi(temp.x, newy, punti, true);
          
          for(i=0; i<4; i++){
            j = trova_linea_in_lista(vet[i], vet[(i+1)%4], linee);
            if(j < 0)
              linee_costruzione.add(new Linea(vet[i], vet[(i+1)%4]));
          }
          
          controlla_intersezione_linee(linee, linee_costruzione);
          drawmode = false;
          break;
        
        case 'p': // disegna una poligono irregolare
          vet = new Punto[2];
          vet[0] = trova_punto_eo_aggiungi(temp3.x, temp3.y, punti, true);
          temp3 = vet[1] = trova_punto_eo_aggiungi(mouseX, mouseY, punti, true);
          
          j = trova_linea_in_lista(vet[0], vet[1], linee);
          if(j < 0)
            linee_costruzione.add(new Linea(vet[0], vet[1]));
          
          if( keyPressed && (key == CODED) ){
            // C'è l'if e l'elseif perchè un altro tasto codificato è lo SHIFT e quindi
            // non posso mettere drawmode=false fuori per farlo eseguire a prescindere
            if( keyCode == CONTROL ){ // 'close', chiudi la figura
              vet[0] = trova_punto_eo_aggiungi(temp4.x, temp4.y, punti, true);
              
              j = trova_linea_in_lista(vet[0], vet[1], linee);
              if(j < 0)
                linee_costruzione.add(new Linea(vet[0], vet[1]));
              
              drawmode = false;
            }
            else if( keyCode == ALT ){ // 'stop', la figura rimane aperta
              drawmode = false;
            }
          }
          
          controlla_intersezione_linee(linee, linee_costruzione);
          break;
          
        case 'l': // disegna una linea
          drawmode = false;
          vet = new Punto[2];
          
          vet[0] = trova_punto_eo_aggiungi(temp.x, temp.y, punti, true);
          vet[1] = trova_punto_eo_aggiungi(mouseX, mouseY, punti, true);
          
          j = trova_linea_in_lista(vet[0], vet[1], linee);
          if(j < 0)
            linee_costruzione.add(new Linea(vet[0], vet[1]));
          
          controlla_intersezione_linee(linee, linee_costruzione);
          break;
        }
      }
      
    }
    else if(keyPressed){
      switch(cartemp = key){
      case 'p': // disegna una poligono irregolare
      case 'q': // disegna un quadrato
      case 'r': // disegna un rettangolo
      case 'l': // disegna una linea
        drawmode = true;
        temp = trova_punto_eo_aggiungi(mouseX, mouseY, punti, true);
        
        if(cartemp == 'p') // Solo nel caso del poligono irregolare
          temp4 = temp3 = temp2 = temp;
        
        break;
      }
    }
    else{ // Posiziona una luce
      luci.add(new Luce(mouseX, mouseY));
    }
  }
} // ---- Fine funzione mousePressed()

Linea trova_linea_eo_aggiungi(Punto p1, Punto p2, ArrayList<Linea> list, boolean toadd){
  // Cerca un punto nella lista e, se non lo trova, lo crea e lo aggiunge
  // se toadd=true.
  // Ritorna il riferimento al punto, sia che esso fosse stato già creato in passato,
  // sia che sia stato creato in questa funzione
  Linea sas;
  int i = trova_linea_in_lista(p1, p2, list);
  
  if(i >= 0){
    sas = list.get(i);
  }
  else{
    sas = new Linea(p1, p2);
    if(toadd) list.add(sas);
  }
  
  return sas;
}

int trova_linea_in_lista(Punto p1, Punto p2, ArrayList<Linea> list){
  // Cerca una linea nella lista e ritorna l'indice.
  //  Se non trova nulla, restituisce -1
  int i=0, N = list.size();
  boolean trovato=false;
  
  while(i<N && !trovato){
    if( list.get(i).equals(p1, p2) )
      trovato = true;
    else
      i++;
  }
  
  if(trovato)
    return i;
  return -1;
}

Punto trova_punto_eo_aggiungi(float x, float y, ArrayList<Punto> list, boolean toadd){
  // Cerca un punto nella lista e, se non lo trova, lo crea e lo aggiunge
  // se toadd=true.
  // Ritorna il riferimento al punto, sia che esso fosse stato già creato in passato,
  // sia che sia stato creato in questa funzione
  Punto fiat;
  int i = trova_punto_in_lista(x, y, list);
  
  if(i >= 0){
    fiat = list.get(i);
  }
  else{
    fiat = new Punto(x, y);
    if(toadd) list.add(fiat);
  }
  
  return fiat;
}

int trova_punto_in_lista(float x, float y, ArrayList<Punto> list){
  // Cerca un punto nella lista e ritorna l'indice.
  // Se non trova nulla, restituisce -1
  int i=0, N = list.size();
  boolean trovato=false;
  
  while(i<N && !trovato){
    if( list.get(i).equals(x, y) )
      trovato = true;
    else
      i++;
  }
  
  if(trovato)
    return i;
  return -1;
}

void controlla_intersezione_linee(ArrayList<Linea> linee,
                                  ArrayList<Linea> linee_costruzione){
   int j, Nj = linee.size();
   Linea test, lin;
   boolean fine_ciclo=false; //<>//
   
   if( !linee_costruzione.isEmpty() ){
     test = linee_costruzione.remove(0);
     
     for(j=4; j<Nj && !fine_ciclo; j++){
       // j=4 perchè le prime 4 linee sono il bordo dello schermo
       lin = linee.get(j);
       
       // Serve creare due nuovi oggetti Punto per evitare di modificare qualche
       // altro oggetto Punto creato in precedenza
       temp = new Punto(0,0);
       temp2 = new Punto(0,0);
       
       if( test.inter(lin, temp, temp2) ){
         
         if( (temp2.y == -1) && (temp.x != -1) ){
           linee.remove(j); // linee.remove(lin); //<>//
           temp = trova_punto_eo_aggiungi(temp.x, temp.y, punti, true);
           
           if( temp.equals(test.p1) ){
             fine_ciclo = true;
             // linee.add(new Linea(test.p1, test.p2));
             linee.add(test);
             if(temp2.x == 1){
               linee.add(new Linea(test.p1, lin.p1));
             }
             else{ // temp2.x == 2
               linee.add(new Linea(test.p1, lin.p2));
             }
           }
           else if( temp.equals(test.p2) ){
             fine_ciclo = true;
             // linee.add(new Linea(test.p2, test.p1));
             linee.add(test);
             if(temp2.x == 1){
               linee.add(new Linea(test.p2, lin.p1));
             }
             else{ // temp2.x == 2
               linee.add(new Linea(test.p2, lin.p2));
             }
           }
           else if( temp.equals(lin.p1) ){
             // linee.add(new Linea(lin.p1, lin.p2));
             linee.add(lin);
             if(temp2.x == 1){
               test = new Linea(lin.p1, test.p1);
             }
             else{ // temp2.x == 2
               test = new Linea(lin.p1, test.p2);
             }
             linee_costruzione.add(test);
           }
           else if( temp.equals(lin.p2) ){
             // linee.add(new Linea(lin.p2, lin.p1));
             linee.add(lin);
             if(temp2.x == 1){
               test = new Linea(lin.p2, test.p1);
             }
             else{ // temp2.x == 2
               test = new Linea(lin.p2, test.p2);
             }
             linee_costruzione.add(test);
           }
           else{ // test non è uguale a nessun altro punto => linee non parallele
             // linee.remove(j); // linee.remove(lin);
             // temp = trova_punto_eo_aggiungi(temp.x, temp.y, punti, true); //<>//
             
             linee.add(new Linea(temp, lin.p1));
             linee.add(new Linea(temp, lin.p2));
             linee_costruzione.add(new Linea(temp, test.p1));
             linee_costruzione.add(new Linea(temp, test.p2));
             
             fine_ciclo = true;
           }
         }
         else if( temp2.x != -1 ){
           // Le due linee si trovano sulla stessa retta e vanno divise in tre
           // linee distinte
           
           // fine_ciclo = true;
           // linee.remove(j);
           
           if( temp.equals(lin.p1) ){ // temp2.equals(lin.p2)
             // lin.p1 e lin.p2 sono i punti interni
             fine_ciclo = true;
             // linee.add(lin);
             
             if( test.p1.distQuad(lin.p1) < test.p1.distQuad(lin.p2) ){
               linee_costruzione.add(new Linea(lin.p1, test.p1));
               linee_costruzione.add(new Linea(lin.p2, test.p2));
             }
             else{
               linee_costruzione.add(new Linea(lin.p2, test.p1));
               linee_costruzione.add(new Linea(lin.p1, test.p2));
             }
           }
           else if( temp2.equals(test.p2) ){ // temp.equals(test.p1)
             // test.p1 e test.p2 sono i punti interni
             fine_ciclo = true;
             // linee.add(lin);
             linee.remove(j);
             linee.add(test);
             
             if( lin.p1.distQuad(test.p1) < lin.p1.distQuad(test.p2) ){
               linee.add(new Linea(lin.p1, test.p1));
               linee.add(new Linea(lin.p2, test.p2));
             }
             else{
               linee.add(new Linea(lin.p2, test.p1));
               linee.add(new Linea(lin.p1, test.p2));
             }
           }
           else if( temp.equals(test.p2) ){
             linee.remove(j);
             linee.add(new Linea(lin.p2, test.p2));
             linee.add(new Linea(test.p2, lin.p1));
             
             if( temp2.equals(lin.p1) ){
               // this.p2 e lin.p1 sono i punti interni
               linee_costruzione.add(test = new Linea(lin.p1, test.p1));
             }
             else{ // temp2.equals(lin.p2)
               // this.p2 e lin.p2 sono i punti interni
               linee_costruzione.add(test = new Linea(lin.p2, test.p1));
             }
           }
           else if( temp.equals(test.p1) ){
             linee.remove(j);
             linee.add(new Linea(lin.p2, test.p1));
             linee.add(new Linea(test.p1, lin.p1));
             
             if( temp2.equals(lin.p1) ){
               // this.p1 e lin.p1 sono i punti interni
               linee_costruzione.add(test = new Linea(lin.p1, test.p2));
             }
             else{ // temp2.equals(lin.p2)
               // this.p1 e lin.p2 sono i punti interni
               linee_costruzione.add(test = new Linea(lin.p2, test.p2));
             }
           }
         }
         /*
         else if( temp.equals(test.p1) && temp2.equals(test.p2) ){
           // La linea di costruzione coincide con una precedentemente creata
           // Non bisogna fare nulla perchè la linea test è già stata eliminata dalla
           // lista linee_costruzione e non bisogna reinserirla nella lista linee
         }
         */
       } //<>//
     }
     
     if(j>=Nj && !fine_ciclo){
       trova_punto_eo_aggiungi(test.p1.x, test.p1.y, punti, true);
       trova_punto_eo_aggiungi(test.p2.x, test.p2.y, punti, true);
       
       linee.add(test);
     }
     
     controlla_intersezione_linee(linee, linee_costruzione);
   }
}
