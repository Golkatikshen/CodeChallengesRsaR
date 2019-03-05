private static final int range = 10;
private static final int Xlength = 500;
PShape dowel;
float Xstart = range * 0.866 * 2;
float Ystart = range * 0.866 * 2;
float[] value = new float[4];
int[] numB = new int[5];
int num = 0;

void setup(){
  size(500, 500);
  dowel = createShape();
  dowel.beginShape();
  float angle = TWO_PI / 6;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx =  cos(a) * range;
    float sy =  sin(a) * range;
    dowel.vertex(sx, sy);
  }
  dowel.endShape(CLOSE);
  readFile();
}

void draw(){
  for(int x=0; x<(Xlength/(range * 3/2))-1; x++)
    for(int y=0; y<(500/(Ystart))-2; y++){
      float nn = noise((float)x/10, (float)y/10);
      setBiome(nn);
      shape(dowel, Xstart + range*3/2*x, 
      Ystart+(range * 0.866 * (x%2)) + (range * 0.866)* 2 * y);
    }
    if(num++ < 70){
      learn();
      resetNumBiome();
    }
    else
      println("done"); //<>//
}

void readFile(){
  String[] lines = loadStrings("data.txt");
  for(int i=0; i<4; i++){
    value[i] = float(lines[i]);
  }
}

void learn(){
  int lowest = numB[0];
  int lowI = 0;
  for(int j=1; j<5; j++)
    if(numB[j] < lowest){
      lowest = numB[j];
      lowI = j;
    }
  switch(lowI){
    case 0:
      value[0] += .02;
      break;
    case 4:
      value[3] -= .02;
      break;
    default:
      value[lowI-1] -= .01;
      value[lowI] += .01;
  }
}

void setBiome(float nn){
  if(nn <= value[0]){
    dowel.setFill(#E5DF23);
    numB[0]++;
  }
  else if(nn > value[0] && nn <= value[1]){
    dowel.setFill(#58D848);
    numB[1]++;
  }
  else if(nn > value[1] && nn <= value[2]){
    dowel.setFill(#1F4817);
    numB[2]++;
  }
  else if(nn > value[2] && nn <= value[3]){
    dowel.setFill(#676C68);
    numB[3]++;
  }
  else if(nn > value[3]){
    dowel.setFill(#1D43B2);
    numB[4]++;
  }
}

void resetNumBiome(){
  for(int i=0; i<numB.length; i++)
    numB[i] = 0;
}
