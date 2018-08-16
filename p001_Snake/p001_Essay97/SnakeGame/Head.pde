public class Head extends Body{
  private float diameter;
  
  public Head(float startX, float startY, int direction){
    super(startX, startY, direction);
    diameter = 22;
  }
  
  public void display(){
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(startX, startY, diameter, diameter);
  }
  
}
