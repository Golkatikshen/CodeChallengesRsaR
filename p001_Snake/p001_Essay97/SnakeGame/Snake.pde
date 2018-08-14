public class Snake{
  private Head h;
  private ArrayList<Tail> t = new ArrayList<Tail>();
  
  public Snake(){
    this.h = new Head(50, 50, false);
    this.t.add(new Tail(50, 50, false));
  }
  
  public void move(boolean vertical){
    h.move(vertical);
    
    for(Tail i: t)
      i.move(vertical);
  }
  
  public void display(){
    h.display();
    
    for(Tail i: t)
      i.display();
  }
}
