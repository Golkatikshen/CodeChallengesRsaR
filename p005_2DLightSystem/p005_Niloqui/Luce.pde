class Luce{
  class LinVisibile{
    // Mi serve perchè devo sapere se il confine è un muro o 'aria'
    Linea linea;
    boolean muro;
    
    LinVisibile(Linea lin, boolean muro){
      linea = lin;
      this.muro = muro;
    }
  }
  
  class Vettore{
    // Ogni punto è salvato come distanza distanza al quadrato dal centro della
    // luce e con l'angolo compreso tra questo vettore e la semiretta orizzontale pos.
    float roquad, teta;
    Punto p;
    
    Vettore(float lunghezza_al_quadrato, float angolo, Punto p){
      roquad = lunghezza_al_quadrato;
      teta = angolo;
      this.p = p;
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
      // ArrayList<Punto> ps = new ArrayList();
      // ps.addAll(punti);
      Vettore[] vp = new Vettore[punti.size()];
      int i, N = punti.size();
      Linea test;
      // Punto p = new Punto(0, c.y);
      
      for(i=0; i<N; i++){
        vp[i] = new Vettore(c.distQuad(punti.get(i)),
                            calcola_angolo(punti.get(i)),
                            punti.get(i));
      }
      merge_sort(vp, N);
      // Il vettore vp è ordinato per l'angolo che hanno i vari punti presenti con
      // il centro della luce
      
      for(i=0; i<N; i++){
        test = new Linea(c, vp[i].p);
        
        if( !intersezione_con_muri(test) ){
          boolean prolungamento, senso_antiorario = true;
          // senso_antiorario = true => Il punto che si otterrà con il prolungamento
          // deve essere connesso con il prossimo punto che verrà trovato
          // senso_antiorario = false => Il punto che si otterrà con il prolungamento
          // deve essere connesso con il punto precedentemente trovato. Il punto
          // che dovrà collegarsi con il successivo sarà il punto vp[i].p
          // senso_antiorario è inizializzata se no Processing rompe il cazzo
          ArrayList<Punto> lista_punti_connessi = punti_connessi_con_p(vp[i].p);
          
          // Se lista_punti_connessi.size() == 1 allora solo un punto è collegato
          // con vp[i].p con una linea
          // Se lista_punti_connessi.size() >= 2 il punto è collegato a più punti
          // con più linee.
          // Non dovrebbero esserci punti isolati (ovvero lista.size() == 0 )
          int j=0, minori=0, maggiori=0;
          
          for(; j<lista_punti_connessi.size(); j++){
            float ang = calcola_angolo(lista_punti_connessi.get(j));
            if(ang > (vp[i].teta + PI)){
              ang -= 2*PI;
            }
            else if(ang < (vp[i].teta - PI)){
              ang += 2*PI;
            }
            
            if( ang < vp[i].teta ){
              minori++;
            }
            else if( ang > vp[i].teta ){
              maggiori++;
            }
          }
          
          if( minori>0 && maggiori>0 ){
            // Significa che il punto potrebbe essere l'angolo di una figura
            // che oscacola il passaggio della luce
            prolungamento=false;
          }
          else{
            // Significa che il punto non può essere l'angolo di una figura
            // che oscacola il passaggio della luce
            prolungamento=true;
            
            if(maggiori>0)
              senso_antiorario = false;
            else
              senso_antiorario = true;
          }
          
          LinVisibile toadd;
          if(prolungamento){
            float l = 1300*1300 + 800*800; // 2330000 oppure 2.330.000
            Punto p = new Punto(vp[i].p.x + sqrt(l)*cos(vp[i].teta),
                                vp[i].p.y + sqrt(l)*sin(-1*vp[i].teta));
                                // Punto fittizio fuori dallo schermo
            Punto ret = new Punto(0, 0);
            Punto ret2 = new Punto(0, 0);
            Linea linea= new Linea(vp[i].p, p);
            
            for(j=0; j<linee.size(); j++){
              if( linea.inter(linee.get(j), ret, ret2) && (ret2.x == -10) ){
                l = vp[i].p.distQuad(ret);
                p.cambiaCoord(ret);
              }
            }
            
            if(senso_antiorario){
              // Prima collegare il punto iniziale, dopo quello trovato con il
              // prolungamento iniziale
              if( muriVisibili.isEmpty() ){ //<>//
                toadd = new LinVisibile(test, false);
                // test = new Linea(c, vp[i].p)
              }
              else{
                Punto ultimo_punto = muriVisibili.get(muriVisibili.size()-1).linea.p2;
                toadd = new LinVisibile( new Linea(ultimo_punto, vp[i].p), true );
              }
              ret = vp[i].p;
              ret2 = p;
            }
            else{
              // Prima collegare il punto trovato con il prolungamento, dopo il punto
              // iniziale
              if( muriVisibili.isEmpty() ){
                toadd = new LinVisibile(new Linea(c, p), false);
              }
              else{
                Punto ultimo_punto = muriVisibili.get(muriVisibili.size()-1).linea.p2;
                toadd = new LinVisibile( new Linea(ultimo_punto, p), true );
              }
              ret = p;
              ret2 = vp[i].p;
            }
            muriVisibili.add(toadd);
            
            toadd = new LinVisibile(new Linea(ret, ret2), false);
            muriVisibili.add(toadd);
          } // Fine caso 'true' di if(prolungamento) 
          else{
            if( muriVisibili.isEmpty() ){
              toadd = new LinVisibile(test, false );
              // test = new Linea(c, vp[i].p)
            }
            else{
              Punto ultimo_punto = muriVisibili.get(muriVisibili.size()-1).linea.p2;
              toadd = new LinVisibile( new Linea(ultimo_punto, vp[i].p), true );
            }
            muriVisibili.add(toadd);
          }
        }
      }
      
      // Aggiunta ultimo triangolo
      LinVisibile toadd;
      Punto ultimo_punto = muriVisibili.get(muriVisibili.size()-1).linea.p2;
      Punto primo_punto = muriVisibili.get(0).linea.p2;
      Linea prova = new Linea(ultimo_punto, primo_punto);
      toadd = new LinVisibile( prova, true );
      muriVisibili.add(toadd);
      
      // Disegno vero e proprio dei triangoli //<>//
      for(i=0; i<muriVisibili.size(); i++){
        noStroke();
        fill(255, 35);
        triangle(c.x, c.y,
              muriVisibili.get(i).linea.p1.x, muriVisibili.get(i).linea.p1.y,
              muriVisibili.get(i).linea.p2.x, muriVisibili.get(i).linea.p2.y);
        stroke(255, 255, 255);
        strokeWeight(2);
        if( muriVisibili.get(i).muro )
          line(muriVisibili.get(i).linea.p1.x, muriVisibili.get(i).linea.p1.y,
              muriVisibili.get(i).linea.p2.x, muriVisibili.get(i).linea.p2.y);
      }
      
    }
  }
  
  ArrayList<Punto> punti_connessi_con_p(Punto p){
    ArrayList<Punto> lista = new ArrayList();
    lista.clear(); // Dovrebbe essere inutile, verificare con il debug
    int i, N = linee.size();
    
    for(i=0; i<N; i++){
      if( linee.get(i).p1.equals(p) ){
        lista.add(linee.get(i).p2);
      }
      else if( linee.get(i).p2.equals(p) ){
        lista.add(linee.get(i).p1);
      }
    }
    
    return lista;
  }
  
  ArrayList<Linea> linee_per_punto(Punto p){
    ArrayList<Linea> lista = new ArrayList();
    lista.clear(); // Dovrebbe essere inutile, verificare con il debug
    int i, N = linee.size();
    
    for(i=0; i<N; i++){
      if( linee.get(i).p1.equals(p) || linee.get(i).p2.equals(p) ){
        lista.add(linee.get(i));
      }
    }
    
    return lista;
  }
  
  boolean intersezione_con_muri(Linea lin){
    Punto inutile1 = new Punto(0, 0);
    Punto inutile2 = new Punto(0, 0);
    
    return intersezione_con_muri(lin, inutile1, inutile2);
  }
  
  boolean intersezione_con_muri(Linea lin, Punto ret, Punto ret2){
    boolean intersect = false;
    int i, N = linee.size();
    
    for(i=0; i<N && !intersect; i++){
      if( lin.inter(linee.get(i), ret, ret2) ){
        intersect = true;
      }
    }
    
    return intersect;
  }
  
  void merge_sort(Vettore[] A, int N){
    Vettore[] B = new Vettore[N];
    
    merge_sort_rec(A, B, 0, N-1);
  }
  
  private void merge_sort_rec(Vettore[] A, Vettore[] B, int l, int r){
    if( l >= r ){
      return;
    }
    int m = (r+l)/2;
    
    merge_sort_rec(A, B, l, m);
    merge_sort_rec(A, B, m+1, r);
    merge(A, B, l, m, r);
  }
  
  private void merge(Vettore[] A, Vettore[] B, int l, int m, int r){
    int i, j, k;
    i = l;
    j = m+1;
    k = l;
    
    while(k <= r){
      if( i > m ){
        B[k] = A[j];
        j++;
      }
      else if( j > r ){
        B[k] = A[i];
        i++;
      }
      else if( (A[i].teta < A[j].teta)?true:
                 ( (A[i].teta > A[j].teta)?false:(A[i].roquad<= A[j].roquad) ) ){
        B[k] = A[i];
        i++;
      }
      else{
        B[k] = A[j];
        j++;
      }
      k++;
    }
    
    for(k=l; k<=r; k++){
      A[k] = B[k];
    }
  }
  
  private float calcola_angolo(Punto p){
    float ang;
    PVector v1 = new PVector(1, 0);
    PVector v2 = new PVector(p.x -c.x, p.y -c.y);
    
    ang = PVector.angleBetween(v1, v2);
    if(c.y < p.y) ang *= -1;
    
    return ang;
  }
  
  
  
}
