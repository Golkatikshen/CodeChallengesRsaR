public abstract class Body{
  float startX, startY;
  
  public Body(float startX, float startY){
    this.startX = startX;
    this.startY = startY;
  }
  
  public void move(boolean vertical){ //TODO aggiungere il controllo sui bordi per l'entrata dall'altra parte
    if(vertical)
      startY += 1.4; //TODO provare velocità nel draw
    else
      startX += 1.4;
  }
  
  public abstract void display();
}
