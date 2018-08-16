public class TurningPoint {
  private int direction, nTails;
  private float X, Y;

  public TurningPoint(int direction, float X, float Y){
    this.direction = direction;
    this.X = X;
    this.Y = Y;
    this.nTails = 0;
  }
  
  public float getX(){
    return X;
  }

  public float getY(){
    return Y;
  }
  
  public int getDirection(){
    return direction;
  }
  
  public void incrementNTails(){
    nTails++;
  }
  
  public int getNTails(){
    return nTails;
  }
}
