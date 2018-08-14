public class Tail extends Body{
  private float endX, endY;
  
  public Tail(float startX, float startY, boolean vertical){
    super(startX, startY);
    this.setEnd(vertical);    
  }
  
  public void setEnd(boolean vertical){
    if(vertical){
      endX = startX;
      endY += 1.4;
    }
    else{
      endX += 1.4;
      endY = startY;
    }
  }
  
  public void display(){
    stroke(255);
    strokeWeight(12);
    line(startX, startY, endX, endY);
  }
}
