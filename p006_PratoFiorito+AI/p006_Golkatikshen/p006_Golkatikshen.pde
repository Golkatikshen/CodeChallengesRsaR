
boolean menu = true;
float size_q = 30;

Button play_button;
Button ai_button;
Button randomize_seed_button;
Button diff_button;
Button n_col_button;
Button n_row_button;
Button exit_button;

int seed = (int)random(1000, 10000); //Il seed funziona ovviamente solo se si clicca la stessa prima casella durante la partita.
int diff = 0;
int n_col = 10;
int n_row = 8;
String infos = "Clicca su Seed per randomizzare.\nClicca su Mode per cambiare il livello di difficoltà.\nScorri la rotellina del mouse su X e Y per cambiare la dimensione della griglia.";

MineSweeper MS;

void setup()
{
  size(800, 600);
  
  play_button = new Button(100, 50, 150, 50, "PLAY", 6, -4, 200, 0, 0);
  ai_button = new Button(100, 125, 150, 50, "AI", 6, -4, 200, 0, 0);
  randomize_seed_button = new Button(300, 50, 150, 50, "Seed: "+String.valueOf(seed), 6, -4, 100, 100, 100);
  diff_button = new Button(300, 125, 150, 50, "Mode: EASY", 6, -4, 100, 100, 100);
  n_col_button = new Button(300, 200, 150, 50, "X: "+n_col, 6, -4, 100, 100, 100);
  n_row_button = new Button(300, 275, 150, 50, "Y: "+n_row, 6, -4, 100, 100, 100);
  exit_button = new Button(700, 550, 150, 50, "EXIT", 6, -4, 100, 100, 200);
}

void draw()
{
  background(0);
  if(menu)
  {
    play_button.display();
    ai_button.display();
    randomize_seed_button.display();
    diff_button.display();
    n_col_button.display();
    n_row_button.display();
    exit_button.display();
    
    textSize(15);
    fill(240);
    textAlign(LEFT);
    text(infos, 220, 340);
    
    strokeWeight(2);
    stroke(20);
    line(200, -1, 200, height+1);
    line(200, 500, width+1, 500);
    noStroke();
  }
  else
    MS.display();
}

void mousePressed()
{
  if(menu)
  {
    if(exit_button.mouseHover())
      exit();
    
    if(ai_button.mouseHover())
      println("Non succede niente di niente sry.");
      
    if(play_button.mouseHover())
    {
      menu = false;
      randomSeed(seed);
      MS = new MineSweeper(n_col, n_row);
      println("Game started - seed: "+seed);
    }
      
    if(randomize_seed_button.mouseHover())
    {
      seed = (int)random(1000, 10000);
      randomize_seed_button.str = "Seed: "+String.valueOf(seed);
    }
    
    if(diff_button.mouseHover())
    {
      diff++;
      diff %= 3;
      if(diff == 0)
        diff_button = new Button(300, 125, 150, 50, "Mode: EASY", 6, -4, 100, 100, 100);;
      if(diff == 1)
        diff_button = new Button(300, 125, 150, 50, "Mode: MEDIUM", 6, -3, 100, 100, 100);;
      if(diff == 2)
        diff_button = new Button(300, 125, 150, 50, "Mode: HARD", 6, -4, 100, 100, 100);;
    }
  }
  else
  {
    if(mouseButton == LEFT)
      MS.click();
    if(mouseButton == RIGHT)
      MS.rightClick();
  }
}

void mouseWheel(MouseEvent event)
{
  int e = event.getCount();
  
  if(menu)
  {
    if(n_col_button.mouseHover())
    {
      n_col+=e;
      if(n_col<1)
        n_col = 1;
      if(n_col>100)
        n_col = 100;
      n_col_button = new Button(300, 200, 150, 50, "X: "+n_col, 6, -4, 100, 100, 100);
    }
    
    if(n_row_button.mouseHover())
    {
      n_row+=e;
      if(n_row<1)
        n_row = 1;
      if(n_row>100)
        n_row = 100;
      n_row_button = new Button(300, 275, 150, 50, "Y: "+n_row, 6, -4, 100, 100, 100);
    }
  }
}

void keyPressed()
{
  if(key == 'b' || key == 'B')
    menu = true;
}
