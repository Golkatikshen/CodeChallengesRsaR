//Mandelbrot
import java.math.*;

void setup()
{
  size(600, 600);
  
  println("Darker the point, faster it escapes.\n");
  println("Click to center the clicked point");
  println("Scroll the mouse wheel to zoom in/out");
  println("USE K/L TO DECREMENT/INCREMENT THE LEVEL OF DETAIL\n\n");
  
  calculateMandelbrot();
}

void draw()
{
}

double z = 1;
double h = 0;
double v = 0;
int max_i = 100;

void mousePressed()
{
  if(mouseButton == LEFT)
  {
    h = mapD(mouseX, 0, width, -2.5/z+h, 2.5/z+h);
    v = mapD(mouseY, 0, height, -2.5/z+v, 2.5/z+v);
    calculateMandelbrot();
  }
}

void mouseWheel(MouseEvent event) 
{
  float e = event.getCount()*-1;
  if(e == 1)
    z *= 2;
  else
    z /= 2;
  calculateMandelbrot();
  println("Zoom: "+z);
  println("Detail level: "+max_i+"\n");
}


void keyPressed()
{
  if(key == 'k')
  {
    max_i -= 100;
    calculateMandelbrot();
    println("Zoom: "+z);
    println("Detail level: "+max_i+"\n");
  }
  
  if(key == 'l')
  {
    max_i += 100;
    calculateMandelbrot();
    println("Zoom: "+z);
    println("Detail level: "+max_i+"\n");
  }
}


void calculateMandelbrot()
{
  background(0);
  loadPixels();
  for(int x=0; x<width; x++)
  {
    for(int y=0; y<height; y++)
    {
      double px = (double)mapD(x, 0, width, -2.5/z+h, 2.5/z+h);
      double py = (double)mapD(y, 0, height, -2.5/z+v, 2.5/z+v);
      double nx = 0;
      double ny = 0;
      int iteration = 0;
      int max_iteration = max_i;
      
      while(nx*nx + ny*ny < 4 && iteration < max_iteration)
      {
        double xtemp = nx*nx-ny*ny + px;
        ny = 2*nx*ny + py;
        nx = xtemp;
        iteration ++;
      }
      
      iteration = (int)map(iteration, 0, max_i, 0, 255);
      pixels[x+y*width] = color(iteration, iteration, iteration); 
    }
  }
  updatePixels();
}

double mapD(double value, double start1, double stop1, double start2, double stop2) 
{
 
  double outgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  String badness = null;
  
  if (outgoing != outgoing) {
    badness = "NaN (not a number)";
 
  } else if (outgoing == Double.NEGATIVE_INFINITY ||
             outgoing == Double.POSITIVE_INFINITY) {
    badness = "infinity";
  }
  if (badness != null) {
    final String msg =
      String.format("map(%s, %s, %s, %s, %s) called, which returns %s", (value), (start1), (stop1), (start2), (stop2), badness);
    PGraphics.showWarning(msg);
  }
  return outgoing;
}


/*
void calculateMandelbrotBigD()
{
  background(0);
  loadPixels();
  for(int x=0; x<width; x++)
  {
    for(int y=0; y<height; y++)
    {
      BigDecimal px = mapBigD(new BigDecimal(String.valueOf(x)), new BigDecimal(String.valueOf(0)), new BigDecimal(String.valueOf(width)), new BigDecimal(String.valueOf(h)).add(new BigDecimal("-2.5").divide(new BigDecimal(String.valueOf(z)))), new BigDecimal(String.valueOf(h)).add(new BigDecimal("2.5").divide(new BigDecimal(String.valueOf(z)))));
      BigDecimal py = mapBigD(new BigDecimal(String.valueOf(y)), new BigDecimal(String.valueOf(0)), new BigDecimal(String.valueOf(height)), new BigDecimal(String.valueOf(v)).add(new BigDecimal("-2.5").divide(new BigDecimal(String.valueOf(z)))), new BigDecimal(String.valueOf(v)).add(new BigDecimal("2.5").divide(new BigDecimal(String.valueOf(z)))));
      BigDecimal nx = new BigDecimal("0");
      BigDecimal ny = new BigDecimal("0");
      int iteration = 0;
      int max_iteration = max_i;
      
      while(nx.multiply(nx).add(ny.multiply(ny)).compareTo(new BigDecimal("4")) < 0 && iteration < max_iteration)
      {
        BigDecimal xtemp = px.add(nx.multiply(nx).subtract(ny.multiply(ny)));
        ny = py.add(nx.multiply(ny.multiply(new BigDecimal("2"))));
        nx = xtemp;
        iteration ++;
      }
      
      iteration = (int)map(iteration, 0, max_i, 0, 255);
      pixels[x+y*width] = color(iteration, iteration, iteration); 
    }
  }
  updatePixels();
}

BigDecimal mapBigD(BigDecimal value, BigDecimal start1, BigDecimal stop1, BigDecimal start2, BigDecimal stop2) 
{
  //double eoutgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  BigDecimal v1 = stop2.subtract(start2);
  BigDecimal v2 = value.subtract(start1);
  BigDecimal v3 = stop1.subtract(start1);
  BigDecimal outgoing = start2.add(v1.multiply(v2.divide(v3, 10, BigDecimal.ROUND_UP)));
  return outgoing;
}*/
