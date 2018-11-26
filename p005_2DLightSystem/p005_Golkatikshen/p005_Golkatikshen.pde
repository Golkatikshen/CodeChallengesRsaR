
LightSystem LS;
String mode;
boolean debug_mode;

void setup()
{
  size(800, 600);
  textSize(15);
  LS = new LightSystem();
  mode = "LIGHT";
  debug_mode = false;
}

void draw()
{
  background(0);
  
  LS.update();
  LS.display();
  
  fill(0, 255, 0);
  text("FPS: "+frameRate, 15, 28);
  text("x: "+mouseX+", y:"+mouseY, 15, 44);
  text("Mode: "+mode, 15, 60);
}

void mousePressed()
{
  switch(mode)
  {
    case "LINE":
      LS.lineCreation();
      break;
      
    case "RECT":
      LS.rectCreation();
      break;
      
    case "CIRCLE":
      LS.circleCreation();
      break;
      
    case "POLY":
      if(mouseButton == LEFT)
        LS.polyCreation(false);
      else
        LS.polyCreation(true);
      break;
  }
}

void keyPressed()
{  
  switch(key)
  { 
    case 'x':
    case 'X':
      mode = "LIGHT";
      break;
      
    case 'd':
    case 'D':
      debug_mode = !debug_mode;
      break;
      
    case 'l':
    case 'L':
      mode = "LINE";
      break;
      
    case 'r':
    case 'R':
      mode = "RECT";
      break;
      
    case 'c':
    case 'C':
      mode = "CIRCLE";
      break;
      
    case 'p':
    case 'P':
      mode = "POLY";
      break;
      
    case 127:
      LS.deleteObstacle();
      break;
  }  
}
