public class Tail extends Body{
  private float endX, endY;
  private boolean last;
  
  public Tail(float startX, float startY, int direction){
    super(startX, startY, direction);
    this.setEnd();
    this.last = true;
  }
  
  public void setEnd(){ //setta la fine, in pratica controlla lunghezza del segmento di coda
    switch(direction){
    case UP:
        endX = startX;
        endY = startY + 50;
      break;
    case DOWN:
        endX = startX;
        endY = startY - 50;
      break;
    case RIGHT:
        endX = startX - 50;
        endY = startY;
      break;
    case LEFT:
        endX = startX + 50;
        endY = startY;
      break;
    }
  }
  
  public float getEndX(){
    return endX;
  }
  
  public float getEndY(){
    return endY;
  }
  
  public void setLast(){
    last = false;
  }
  
  public void display(){
    stroke(255);
    strokeWeight(12);
    line(startX, startY, endX, endY);
  }
  
  public void move(Queue<TurningPoint> turns, float prevX, float prevY, int totTails){
    for(TurningPoint t: turns.getList()){
      switch(direction){
      case RIGHT:
        if(t.getY()==startY && t.getX()>=endX && t.getX()<=startX){
          direction = t.getDirection();
        }
        break;
      case LEFT:
        if(t.getY()==startY && t.getX()>=startX && t.getX()<=endX)
          direction = t.getDirection();
        break;
      case UP:
        if(t.getX()==startX && t.getY()>=startY && t.getY()<=endY)
          direction = t.getDirection();
        break;
      case DOWN:
        if(t.getX()==startX && t.getY()>=endY && t.getY()<=startX)
          direction = t.getDirection();
        break;
      }
      
      if(this.last)
       turns.dequeue();
    }
    startX = prevX;
    startY = prevY;
    this.setEnd();
  }
}