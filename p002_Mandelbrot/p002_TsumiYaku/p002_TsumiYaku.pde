int maxiter = 1000;
boolean drawn = false;
float x1 = -2;
float x2 = 0.6;
float y1 = -1.5;
float y2 = 1.5;

void setup() {
  size(800, 800);
  background(0);
  colorMode(HSB, 255);
}

void draw() {
  if(drawn == false) {
    drawn = true;
    drawSet();
  }
}

void mouseClicked() {
  float zoom = 1.01;
  float x = map(mouseX, 0, width, x1, x2);
  float y = map(mouseY, 0, width, y2, y1);
  x1 = x1 + abs(x1-x)/zoom;
  x2 = x2 - abs(x2-x)/zoom;
  y1 = y1 + abs(y1-y)/zoom;
  y2 = y2 - abs(y2-y)/zoom;
  drawn = false;
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
        float re = map(i, 0, width, x1, x2);
        float im = map(j, 0, height, y2, y1);
        c.re = re;
        c.im = im;
        if(c.abs() < 2) {
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
