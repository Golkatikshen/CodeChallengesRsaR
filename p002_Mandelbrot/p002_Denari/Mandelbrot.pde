double RE_START = -2;
double RE_END = 1;
double IM_START = -1;
double IM_END = 1;
double WIDTH = 800;
double HEIGHT = 600;
int deep = 100;


void setup(){
  size(800, 600);
  background(0);
  colorMode(HSB);
}

void draw(){
  int x, y, iteration, value;
  color hue;
  Complex c;
  for(x = 0; x<WIDTH; x++)
    for(y = 0; y<HEIGHT; y++){
      //Convert pixel coordinate to complex number
      c = new Complex(RE_START + (x / WIDTH) * (RE_END - RE_START),
                      IM_START + (y / HEIGHT) * (IM_END - IM_START));
      iteration = Mandelbrot(c);
      hue = 255 - iteration * 255 / deep;
      if(iteration < deep)
        value = 255;
      else 
        value = 0;
      stroke(hue, 255, value);
      point(x, y);
    }
    return;
}

int Mandelbrot(Complex c){
  Complex z = new Complex(0,0);
  int n = 0;
  while(z.abs() <= 2 & n < deep){
    z = z.times(z).plus(c);
    n++;
  }
  return n;
}
