public class Food{
  private PVector pos = new PVector();
  private int points;
  
  public Food(Snake s){
    this.update(s);
  }
  
  public void display(){
    noStroke();
    fill(#F20A0A); //rosso
    
    ellipse(pos.x, pos.y, 19, 19);
  }
  
  public void update(Snake s){
    boolean posAvailable = true; 
    do{
      pos.x = random(1000);
      pos.y = random(600);
      
      posAvailable = true;
      for(int i = 0; i<s.dim && posAvailable; i++){
        if(pos.dist(s.body[i]) < 10)
          posAvailable = false;
        else
          posAvailable = true;
      }
    }
    while(!posAvailable);
    
    points = int(random(1, 4));
  }
}
