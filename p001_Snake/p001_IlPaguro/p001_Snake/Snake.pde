class Snake
{
  boolean dead = false;
  Head head = new Head();
  ArrayList<BodyPart> body = new ArrayList<BodyPart>();
  
  Snake(){
    body.add(head);
    addBodyPart();
  }
  
  void move()
  {
    if(!dead)
      for(BodyPart bp : body)
        bp.move(head);
  }
  
  void addBodyPart()
  {
    BodyPart lastBodyPart = body.get(body.size()-1);
    //Adds a new body part which moves in the same direction as the last one
    body.add(new BodyPart(lastBodyPart));
    lastBodyPart.nextBodyPart = body.get(body.size()-1);
    if(lastBodyPart instanceof Head)
      body.get(body.size()-1).neck = true;
  }
  
  void drawSnake()
  {
    for(int i=0; i<body.size(); i++)
      ellipse(body.get(i).x, body.get(i).y, 15, 15);
  }
}
