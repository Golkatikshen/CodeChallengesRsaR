public class Snake {
  private Head h;
  private ArrayList<Tail> t = new ArrayList<Tail>();
  private float lastX, lastY;

  public Snake() {
    this.h = new Head(50, 50, RIGHT);
    this.t.add(new Tail(50, 50, RIGHT));
    this.lastX = t.get(0).getEndX();
    this.lastY = t.get(0).getEndY();
  }

  public void move(Queue<TurningPoint> turns) {
    float prevX, prevY;
    
    h.move();
    prevX = h.getStartX();
    prevY = h.getStartY();
    for (Tail i : t) {
      i.move(turns, prevX, prevY, t.size());
      i.setEnd();
    }
    
  }

  public void display() {
    h.display();
    for (Tail i : t)
      i.display();
  }

  public void addTail() { //settare a false il last della tail precedente
    Tail tmp = new Tail(lastX, lastY, h.getDirection());
    t.add(tmp);
    lastX = tmp.getEndX();
    lastY = tmp.getEndY();
    t.get(t.size()-2).setLast();
  }

  public float getX() {
    return h.getStartX();
  }

  public float getY() {
    return h.getStartY();
  }

  public void setDirection(int direction) {
    h.direction = direction;
  }
}
