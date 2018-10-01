double RE_START = -2;
double RE_END = 1;
double IM_START = -1;
double IM_END = 1;
//il rapporto migliore è 4:3
double WIDTH = 600;
double HEIGHT = 400;

int deep = 15000;  //40 è la profondità migliore per notare la differenza di iterazione
int zoom = 2;


void setup(){
  size(600, 400);
  colorMode(HSB);
  loadPixels();
  mandelbrotSet();
}

void draw(){}


void mandelbrotSet(){
  int x, y, iteration, value;
  color hue;
  Complex c;
  for(x = 0; x<WIDTH; x++)
    for(y = 0; y<HEIGHT; y++){
      //Convert pixel coordinate to complex number
      c = new Complex(map((float)x, 0, (float)WIDTH, (float)RE_START, (float)RE_END),
                      map((float)y, 0, (float)HEIGHT, (float)IM_START, (float)IM_END));
      iteration = Mandelbrot(c);
      hue = (color)map(iteration, 0, deep, 0, 255);
      if(iteration < deep)
        value = 255;
      else 
        value = 0;
      pixels[x + (y * (int)WIDTH)] = color(hue, 255, value);
      
    }
    updatePixels();
}

void mouseClicked(){
  println("zooming");
  double START, re, im;
  //calcola la parte reale e immaginaria di mouseX/Y
  re = map(mouseX, 0, (float)WIDTH, (float)RE_START, (float)RE_END); //<>//
  im = map(mouseY, 0, (float)HEIGHT, (float)IM_START, (float)IM_END);
  START = re - (RE_END - RE_START) / (2 * zoom);
  RE_END = re + (RE_END - RE_START) / (2 * zoom);
  RE_START = START;
  START = im - (IM_END - IM_START) / (2 * zoom);
  IM_END = im + (IM_END - IM_START) / (2 * zoom);
  IM_START = START; //<>//
  mandelbrotSet();
}

void keyPressed(){
  if(key == 'z'){
    deep += 40;
    println("deep set to: " + deep);
    mandelbrotSet();
  }
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
