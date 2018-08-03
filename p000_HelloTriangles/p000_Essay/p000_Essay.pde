int[] x = new int[3];
int[] y = new int[3];
boolean prevPos, antiorario;

void setup(){
  for(int i = 0; i<3; i++){
    x[i] = (int)random(1000);
    y[i] = (int)random(500);
  }
  prevPos = false;
  
  if(det(x[0],y[0],x[1],y[1],x[2],y[2])<0)
    antiorario = true;
  else
    antiorario = false;
  
  size(1000, 500);
  background(255);
  stroke(0);
  noFill();
  triangle(x[0],y[0],x[1],y[1],x[2],y[2]);
}

void draw(){
  if(antiorario){
    if(det(x[0],y[0],x[1],y[1],mouseX,mouseY)<0 && det(x[1],y[1],x[2],y[2],mouseX,mouseY)<0 && det(x[2],y[2],x[0],y[0],mouseX,mouseY)<0 && !prevPos){
        fill(random(0,255), random(0,255), random(0,255));
        triangle(x[0],y[0],x[1],y[1],x[2],y[2]);
        prevPos = true;
    }
    else{
      if(!(det(x[0],y[0],x[1],y[1],mouseX,mouseY)<0) || !(det(x[1],y[1],x[2],y[2],mouseX,mouseY)<0) || !(det(x[2],y[2],x[0],y[0],mouseX,mouseY)<0)){
        noFill();
        triangle(x[0],y[0],x[1],y[1],x[2],y[2]);
        prevPos = false;
      }
    }
  }
  else{
    if(det(x[0],y[0],x[1],y[1],mouseX,mouseY)>0 && det(x[1],y[1],x[2],y[2],mouseX,mouseY)>0 && det(x[2],y[2],x[0],y[0],mouseX,mouseY)>0)
      if(!prevPos){
        fill(random(0,255), random(0,255), random(0,255));
        triangle(x[0],y[0],x[1],y[1],x[2],y[2]);
        prevPos = true;
      }
    else{
      noFill();
      triangle(x[0],y[0],x[1],y[1],x[2],y[2]);
      prevPos = false;
    }
  }
}  

int det(int x1, int y1, int x2, int y2, int mx, int my){
  return x1*y2+y1*mx+x2*my-x1*my-y1*x2-y2*mx;
}
