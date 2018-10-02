final int dim = 700;
float toll=50; //Recursion's depth allowed
color col;
PVector upBound = new PVector(2, 2); //maximum x and y
PVector lowBound = new PVector(-2, -2); //minimum x and y
float radius = 2; //distance from the center to the bounds
PVector center = new PVector(0,0);

void setup()
{
  size(700, 700); //700 pixelx700 pixel
  println("+ : increase details (zooming in gets increasingly slower as the details icrease)");
  println("- : decrease details");
  println("m : set details to maximum");
  println("n : set details to minimum (your RAM thanks you)");
  println("Point and Click an area to zoom");
  colorMode(HSB, 255);
  loadPixels();
  mandelbrotSet();
}

void draw(){
  //println(mouseX+","+mouseY);
}

void mandelbrotSet()
{
  float x, y;
  for(int i=0; i<pixels.length; i++)
  {
    x = map(getX(i), 0, dim, lowBound.x, upBound.x);
    y = map(getY(i), -dim, 0, lowBound.y, upBound.y);
    if(convergent(x, y))
      pixels[i] = color(0, 0, 0);
    else
      pixels[i] = col;
  }
  updatePixels();
}

int getX(int i)
{
  if(i<dim)
    return i;
  return i-((i/dim)*dim);
}

int getY(int i){
  return -i/dim; //The sign is inverted because the y in Processing increases going down instead of going up
}

boolean convergent(float re, float im){
  return mandelbrot(0.0, 0.0, re, im, toll, 0);
}

boolean mandelbrot(float z_re, float z_im, float c_re, float c_im, float toll, int recDepth)
{
  float f_re, f_im, magnitude;
  //z^2
  f_re = z_re*z_re - z_im*z_im;
  f_im = 2*z_re*z_im;
  //+c
  f_re += c_re;
  f_im += c_im;
  //Check if convergent
  magnitude = sqrt(f_re*f_re + f_im*f_im);
  if(magnitude > 2)
    return false;
  if(recDepth<toll)
  {
    col = color(map(recDepth, 0, toll, 0, 255), 255, 200);
    //col = color(recDepth/2, recDepth*2, recDepth);
    return mandelbrot(f_re, f_im, c_re, c_im, toll, recDepth+1); 
  }
  return true;
}

void mouseClicked()
{
  println("Zooming in...");
  center = new PVector(map(mouseX, 0, dim, lowBound.x, upBound.x), map(-mouseY, -dim, 0, lowBound.y, upBound.y)); //<>//
  radius *= 0.5;
  upBound = new PVector(center.x+radius, center.y+radius);
  lowBound = new PVector(center.x-radius, center.y-radius);
  mandelbrotSet();
  println("Zoomed in.");
}

void keyPressed()
{
  if(key=='+' && toll<5500)
  {
    println("Incresing details...");
    toll+=500;
    mandelbrotSet();
    println("Details increased.");
  }
  else if(key=='-' && toll>50)
  {
    println("Decreasing details...");
    toll-=500;
    mandelbrotSet();
    println("Details decreased.");
  }
  else if(key=='m' && toll<5500)
  {
    println("Setting details to maximum (zooming in will get slow as fuck)...");
    toll=5555;
    mandelbrotSet();
    println("Details set to maximum.");
  }
  else if(key=='n' && toll>50)
  {
    println("Setting details to minimum (your RAM thanks you)...");
    toll=50;
    mandelbrotSet();
    println("Details set to minimum.");
  }
}
