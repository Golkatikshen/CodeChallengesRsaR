int maxiter = 40;
boolean drawn = false;
float x1 = -2;
float x2 = 2;
float y1 = -2;
float y2 = 2;

void setup() {
  fullScreen();
  background(255,0,0);
  colorMode(HSB, 255);
}

void draw() {
  if(drawn == false) {
    drawn = true;
    drawSet();
  }
}

void drawSet() {
  int iter;
  int hue;
  int val;
  color col;
  Complex c = new Complex(0, 0);
  
  loadPixels();
  
  for(int i = 0; i < width; i++) {
    for(int j = 0; j < height; j++) {
        c.re = map(i, 0, width, x1, x2);
        c.im = map(j, 0, height, y2, y1);
        if(c.abs() <= 2) {
           iter = mandelbrot(c);
           hue = floor(255 - 255 * iter / maxiter);
           if(iter < maxiter) {
             val = 255;
           }
           else {
             val = 0;
           }           
           col = color(hue, 255, val);
           pixels[j*width+i] = col;
        }
    }
  }
  updatePixels();
}

int mandelbrot(Complex c) {
  int i;
  double mod = 0;
  Complex z = new Complex(0, 0);
  for (i = 0; i < maxiter && mod <= 2; i++) {
    z = z.times(z).plus(c);
    mod = z.abs();
  }
  return i;
}
