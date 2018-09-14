class Head extends BodyPart
{
  boolean locked = false;
  
  Head(){
    super(250, 250);
  }
  
  boolean crashesWithBody(ArrayList<BodyPart> body)
  {
    for(BodyPart bp : body)
      if(!(bp instanceof Head) && x==bp.x && y==bp.y)
        return true; //<>//
    return false;
  }
}
