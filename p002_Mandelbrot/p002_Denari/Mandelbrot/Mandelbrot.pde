double RE_START = -2;
double RE_END = 1;
double IM_START = -1;
double IM_END = 1;
//il rapporto migliore è 4:3
double WIDTH = 800;
double HEIGHT = 600;

int deep = 40;  //40 è la profondità migliore per notare la differenza di iterazione
int zoom = 2;


void setup(){
  size(800, 600);
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

void mousePressed(){
  double START, END, re, im;
  //calcola la parte reale e immaginaria di mouseX/Y
  re = RE_START + (mouseX / WIDTH) * (RE_END - RE_START); //<>//
  im = IM_START + (mouseY / HEIGHT) * (IM_END - IM_START);
  START = re - (RE_END - RE_START) / (2 * zoom);
  END = re + (RE_END - RE_START) / (2 * zoom);
  RE_START = START;
  RE_END = END;
  START = im - (IM_END - IM_START) / (2 * zoom);
  END = im + (IM_END - IM_START) / (2 * zoom);
  IM_START = START;
  IM_END = END; //<>//
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
