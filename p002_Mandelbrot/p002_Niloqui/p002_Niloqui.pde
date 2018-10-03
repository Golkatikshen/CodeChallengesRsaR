double cx = 0.0, cy = 0.0; // Coordinate del centro
int zoom = 0;
boolean nuovo_comando=true;
int iterazioni = 256;

/* Legenda dei tasti:
 * 'r' = reset
 * '+' = incrementa numero iterazioni
 * 'i' = decrementa numero iterazioni
 * freccia su = zoom in avanti
 * freccia giù = zoom indietro
 * click sinistro = centra il grafico nel punto indicato
 */

void setup(){
  size(601, 601);
  loadPixels();
}

void draw(){
  if(nuovo_comando){
    int i, j;
    
    // 601
    for(i=0; i<601; i++){ //<>//
      for(j=0; j<601; j++){
        pixels[j*601 + i] = calcola_colore(i, j);
      }  
    }
    
    updatePixels();
    nuovo_comando = false;
  }
}

color calcola_colore(int i, int j){
  int k=iterazioni-1; //<>//
  double x, y, tempx, tempy, t, pluto;
  
  tempx = x = -(300-i)*4/(pow(2,zoom) * 601.0) +cx;
  tempy = y = (300-j)*4/(pow(2,zoom) * 601.0) +cy;
  
  for(; k>=0 && modulo_al_quadrato(tempx, tempy)<4.0; k--){
    t = tempx;
    tempx = t*t -tempy*tempy +x;
    tempy = y + 2*t*tempy;
  }
  pluto = pow(k,10)*256/pow(iterazioni-1,10);
   //<>//
  return color((int)(pluto*2), (int)pluto, (int)(pluto*2));
}

double modulo_al_quadrato(double x,double y){ //<>//
  return x*x + y*y;
}

void keyPressed(){
  if((key == 'r' || key == 'R') && (zoom!=0 || cx!=0 || cy!=0 || iterazioni!=256)){ // reset
    zoom = 0;
    iterazioni = 256;
    cx = (cy = 0.0);
    nuovo_comando = true;
    println("Reset eseguito con successo.");
  }
  else if(key == '+' && iterazioni<4000){ // aumenta iterazioni
    iterazioni *= 2;
    println("Iterazioni: " + iterazioni);
    nuovo_comando = true;
  }
  else if(key == '-' && iterazioni>4){ // decrementa iterazioni
    iterazioni /= 2;
    println("Iterazioni: " + iterazioni);
    nuovo_comando = true;
  }
  else if(key == CODED){ // zoom
    switch(keyCode){
      case UP:
        if(zoom < 50){
          nuovo_comando = true;
          zoom++;
          println("Zoom: " + zoom);
        }
        break;
      case DOWN:
        if(zoom > 0){
          nuovo_comando = true;
          zoom--;
          println("Zoom: " + zoom);
        }
        break;
      default:
    }
  }
}

void mousePressed(){
  if(mouseButton == LEFT){ // metti al centro il punto indicato dal mouse
    cx = -(300-mouseX)*4/(pow(2,zoom) * 601.0) +cx;
    cy = (300-mouseY)*4/(pow(2,zoom) * 601.0) +cy;
    nuovo_comando = true;
    println("Nuovo centro: ("+cx+", "+cy+")");
  }
}
