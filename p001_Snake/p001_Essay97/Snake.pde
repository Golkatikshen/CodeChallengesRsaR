public class Snake {
  PVector body[] = new PVector[4000];
  int dim = 0;
  float speed = 2.9;
  boolean passing = false;
  
  public Snake(){
    body[0] = new PVector(100, 100); //posizione iniziale della testa -> (100, 100)
    this.elongate();
  }
  
  public void display(){
    fill(255);
    stroke(255);
    strokeWeight(16);
    
    ellipse(body[0].x, body[0].y, 16, 16);
    fill(0);
    ellipse(body[0].x, body[0].y, 5, 5);
    
    for(int i = 0; i<dim; i++)
      line(body[i].x, body[i].y, body[i+1].x, body[i+1].y); 
  }
  
  public void move(int direction){    
    boolean outOfBounds = false;
    
    //a partire dall'ultimo punto, ogni segmento occupa il posto del precedente
    for(int i = dim; i>0; i--){
      body[i] = body[i-1].copy();
      if(body[i].x < 0) body[i].x = width;
      else if(body[i].x > width) body[i].x = 0;
      else if(body[i].y < 0) body[i].y = height;
      else if(body[i].y > height) body[i].y = 0;
    }
    
    //sposta anche la testa, seguendo la direzione indicata
    increment(direction);   
    if(body[0].x < 0) {body[0].x = width; outOfBounds = true;}
    else if(body[0].x > width) {body[0].x = 0; outOfBounds = true;}
    else if(body[0].y < 0) {body[0].y = height; outOfBounds = true;}
    else if(body[0].y > height) {body[0].y = 0; outOfBounds = true;}
    
    if(outOfBounds){
      stroke(0);
      line(body[0].x, body[0].y, body[dim-1].x,  body[dim-1].y);
    }
      
  }
  
  public void elongate(){
    for(int i = 1; i<=18; i++)
      body[dim+i] = new PVector(body[dim].x+2*i, body[dim].y+2*i);
      
    dim += 18;
  }
  
  public void increment(int dir){
    switch(dir){
      case UP:
        body[0].add(0, -speed);
        break;
      case DOWN:
        body[0].add(0, speed);
        break;
      case LEFT:
        body[0].add(-speed, 0);
        break;
      case RIGHT:
        body[0].add(speed, 0);
        break;
    }
  }
  
  public boolean touchedObstacle(){
    for(int i = dim; i>12; i--)
      if(body[i].dist(body[0]) <= 12)
        return true;
    
    return false;
  }
  
  public boolean tryToEat(Food f){
    return (body[0].dist(f.pos) <= 18);  //aumentare per farlo "mangiare" da più lontano
  }

}
