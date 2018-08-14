public class Head extends Body{
  private float diameter;
  
  public Head(float startX, float startY){
    super(startX, startY);
    diameter = 22;
  }
  
  public void display(){
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(startX, startY, diameter, diameter);
  }
  
}
