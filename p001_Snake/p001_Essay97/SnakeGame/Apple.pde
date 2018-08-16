public class Apple{
  int points;
  float posX, posY;
  
  public Apple(){
    this.points = (int)random(1, 4);
    this.posX = random(width);
    this.posY = random(height);
  }
  
  public float getPosX(){
    return posX;
  }
  
  public float getPosY(){
    return posY;
  }
  
  public int getPoints(){
    return points;
  }
  
  public void display(){
    fill(#FA2121);
    noStroke();
    ellipseMode(CENTER);
    ellipse(posX, posY, 12, 12);
  }
  
  public void refresh(){
    points = (int)random(1, 4);
    posX = random(width);
    posY = random(height);
  }

}
