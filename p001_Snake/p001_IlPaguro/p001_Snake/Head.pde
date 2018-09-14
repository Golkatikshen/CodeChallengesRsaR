class Head extends BodyPart
{
  boolean locked = false;
  
  Head(){
    super(250, 250);
  }
  
  boolean crashesWithBody(ArrayList<BodyPart> body)
  {
    for(BodyPart bp : body)
      if(!(bp instanceof Head) && x>=bp.x-5 && x<=bp.x+5 && y>=bp.y-5 && y<=bp.y+5)
        return true; //<>//
    return false;
  }
}
