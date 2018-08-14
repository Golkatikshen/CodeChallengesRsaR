public class Head extends Body{
  private float diameter;
  
  public Head(float startX, float startY, boolean vertical){
    super(startX, startY);
    diameter = 22;
  }
  
  public void display(){
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(50, 50, diameter, diameter);
  }
  
}
