Snake snake; 
int direction, points;
Food food;
PFont f;
boolean dead;

void setup(){
  size(1000, 600);
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  f = createFont("Arial", 20, true);
  
  snake = new Snake();
  direction = RIGHT;
  food = new Food(snake);
  points = 0;
  dead = false; 
}

void draw(){
  background(0);
  
  textFont(f);
  fill(160);
  text("Points: "+points, 860, 30);
  food.display();
  snake.display();
  
  //controllo morte
  if(snake.touchedObstacle()){
    dead = true;
    background(255);
    noLoop();
    textFont(f, 100);
    fill(0);
    textAlign(CENTER);
    text("You're", width/2, 200);
    textFont(f, 120);
    text("DEAD", width/2, 310);
    textFont(f, 40);
    text("Points: "+points, width/2, 380);
    fill(140);
    rect(width/2-15, 480, 350, 100);
    fill(0);
    text("Play again", 480, width/2);
    
  }
  
  if(snake.tryToEat(food)){
    points += food.points;
    food.update(snake);
    snake.elongate();
  }
    
  snake.move(direction);

  
  
}

void keyPressed(){
  if(key == CODED && (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT)){
    //assegna la direzione corrente rispettando il vincolo sulle direzioni opposte
    switch(keyCode){
      case UP:
        if(direction != DOWN){
          direction = UP;
        }
        break;
      case DOWN:
        if(direction != UP){  
          direction = DOWN;
        }
        break;
      case LEFT:
        if(direction != RIGHT){
          direction = LEFT;
        }
        break;
      case RIGHT:
        if(direction != LEFT){
          direction = RIGHT;
        }
        break;       
    }
  }
}

void mouseClicked(){
  if(pmouseX > (width/2-15-175) && pmouseX < (width/2-15+175) && pmouseY > 480-50 && pmouseY < 480+50){
    dead = false;
    points = 0;
    snake = new Snake();
    food.update(snake);
    direction = RIGHT;
    loop();
  
  }
}
