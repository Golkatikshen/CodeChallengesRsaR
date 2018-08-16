public abstract class Body{
  float startX, startY;
  int direction;
  
  public Body(float startX, float startY, int direction){
    this.startX = startX;
    this.startY = startY;
    this.direction = direction;
  }
  
  public void move(){ //TODO aggiungere il controllo sui bordi per l'entrata dall'altra parte
    //gestire il movimento in tutte le direzioni
    switch(direction){
    case UP:
      startY -= 1.4;
      break;
    case DOWN:
      startY += 1.4;
      break;
    case RIGHT:
      startX += 1.4;
      break;
    case LEFT:
      startX -= 1.4;
      break;
    }
  }
  
  public float getStartX(){
    return startX;
  }
  
  public float getStartY(){
    return startY;
  }
  
  public int getDirection(){
    return direction;
  }
  
  public abstract void display();
}
