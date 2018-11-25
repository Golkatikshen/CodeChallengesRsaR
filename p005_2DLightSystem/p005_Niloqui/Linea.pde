class Linea {
  Punto p1, p2;
  
  Linea(Punto p1, Punto p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  
  /*
  Linea(float x1, float y1, float x2, float y2){
    p1 = new Punto(x1, y1);
    p2 = new Punto(x2, y2);
  }
  */
  
  void disegna(){
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  boolean equals(Punto pp1, Punto pp2){
    return ((p1 == pp1) && (p2 == pp2)) || ((p2 == pp1) && (p1 == pp2));
  }
  
  boolean inter(Linea lin, Punto ret, Punto ret2){ // intersezione
    // Le coordinate del punto di intersezione, se esistono, vengono salvate in ret
    // In caso di due linee sulla stessa retta e incidenti, i punti ret corrispondo
    // ai punti centrali dell'intersezione
    // Maggiori informazioni riguardante le formule:
    // https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
    
    float t, u, rxs, qmpxr, qmpxs;
    boolean intersezione;
    Punto r, s, qmp; // qmp = 'q meno p'
    
    // Denominatore
    r = p2.addiz(1, -1, p1);
    s = lin.p2.addiz(1, -1, lin.p1);
    rxs = r.prodVett(s);
    // Numeratore di t
    qmp = lin.p1.addiz(1, -1, p1);
    qmpxr = qmp.prodVett(r);
    
    if(rxs == 0){
      if(qmpxr == 0){ // Linee 'collineari'
        float rr = r.prodScal(r);
        intersezione = true;
        
        t = (qmp.prodScal(r))/rr; // Serve per lin.p1
        u = ((qmp.addiz(1, 1, s)).prodScal(r))/rr; // Serve per lin.p2
        
        if( (t<=0 && u<=0) || (t>=1 && u>=1) ){
          // Linee sulla stessa retta ma non incidenti
          intersezione = false;
          ret.x = ret.y = ret2.x = ret2.y = -10;
        }
        //
        // I prossimi sono i casi in cui non coincide nessun vertice
        //
        else if( (t>0 && t<1) && (u>0 && u<1) ){
          // lin.p1 e lin.p2 sono i punti interni
          ret.cambiaCoord(lin.p1);
          ret2.cambiaCoord(lin.p2);
        }
        else if( (t<0 && u>1) || (u<0 && t>1) ){
          // this.p1 e this.p2 sono i punti interni
          ret.cambiaCoord(this.p1);
          ret2.cambiaCoord(this.p2);
        }
        else if( (t>0 && t<1) && u>1 ){
          // this.p2 e lin.p1 sono i punti interni
          ret.cambiaCoord(this.p2);
          ret2.cambiaCoord(lin.p1);
        }
        else if( (t>0 && t<1) && u<0 ){
          // this.p1 e lin.p1 sono i punti interni
          ret.cambiaCoord(this.p1);
          ret2.cambiaCoord(lin.p1);
        }
        else if( (u>0 && u<1) && t<0 ){
          // this.p1 e lin.p2 sono i punti interni
          ret.cambiaCoord(this.p1);
          ret2.cambiaCoord(lin.p2);
        }
        else if( (u>0 && u<1) && t>1 ){
          // this.p2 e lin.p2 sono i punti interni
          ret.cambiaCoord(this.p2);
          ret2.cambiaCoord(lin.p2);
        }
        //
        // I prossimi sono i casi in cui due vertici coincidono
        //
        else if( u<0 && t==1 ){
          // this.p1 è l'unico punto interno, lin.p1 coincide con this.p2
          ret.cambiaCoord(this.p1);
          ret2.x = 2; // lin.p2 è l'altro estremo
          ret2.y = -10;
        }
        else if( (u>0 && u<1) && t==1 ){
          // lin.p2 è l'unico punto interno, lin.p1 coincide con this.p2
          ret.cambiaCoord(lin.p2);
          ret2.x = 1; // this.p1 è l'altro estremo
          ret2.y = -10;
        }
        else if( (u>0 && u<1) && t==0 ){
          // lin.p2 è l'unico punto interno, lin.p1 coincide con this.p1
          ret.cambiaCoord(lin.p2);
          ret2.x = 2; // this.p2 è l'altro estremo
          ret2.y = -10;
        }
        else if( u>1 && t==0 ){
          // this.p2 è l'unico punto interno, lin.p1 coincide con this.p1
          ret.cambiaCoord(this.p2);
          ret2.x = 2; // lin.p2 è l'altro estremo
          ret2.y = -10;
        }
        else if( t>1 && u==0 ){
          // this.p2 è l'unico punto interno, lin.p2 coincide con this.p1
          ret.cambiaCoord(this.p2);
          ret2.x = 1; // lin.p1 è l'altro estremo
          ret2.y = -10;
        }
        else if( (t>0 && t<1) && u==0 ){
          // lin.p1 è l'unico punto interno, lin.p2 coincide con this.p1
          ret.cambiaCoord(lin.p1);
          ret2.x = 2; // this.p2 è l'altro estremo
          ret2.y = -10;
        }
        else if( (t>0 && t<1) && u==1 ){
          // lin.p1 è l'unico punto interno, lin.p2 coincide con this.p2
          ret.cambiaCoord(lin.p1);
          ret2.x = 1; // this.p1 è l'altro estremo
          ret2.y = -10;
        }
        else if( t<0 && u==1 ){
          // this.p1 è l'unico punto interno, lin.p2 coincide con this.p2
          ret.cambiaCoord(this.p1);
          ret2.x = 1; // lin.p1 è l'altro estremo
          ret2.y = -10;
        }
        //
        // 
        //
        else if( (t==0 && u==1) || (t==1 && u==0) ){
          // Le due linee coincidono
          ret.cambiaCoord(this.p1);
          ret2.cambiaCoord(this.p2);
        }
      } // Fine if(qmpxr == 0)
      else{ // Linee parallele e non incidenti
        intersezione = false;
        ret.x = ret.y = ret2.x = ret2.y = -10;
      }
    }
    else{ // rxs != 0
      u = qmpxr / rxs;
      qmpxs = qmp.prodVett(s);
      t = qmpxs / rxs;
      
      if( t>0 && t<1 && u>0 && u<1 ){ // Linee incidenti
        intersezione = true;
        ret.cambiaCoord(p2.addiz(t, 1-t, p1));
        ret2.cambiaCoord(lin.p2.addiz(u, 1-u, lin.p1));
        ret2.x = ret2.y = -10;
      }
      else{ // Linee non parallele e non incidenti
        intersezione = false;
        ret.x = ret.y = ret2.x = ret2.y = -10;
      }
    }
    
    return intersezione;
  }
  
  
}
