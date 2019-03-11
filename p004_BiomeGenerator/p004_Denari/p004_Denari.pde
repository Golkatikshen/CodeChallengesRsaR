import java.util.LinkedList;

private static final int range = 20;
PShape dowel;
float Xstart = range * 0.866 * 2;
float Ystart = range * 0.866 * 2;
static float[] value = {0.2, 0.4, 0.6, 0.8};
int[] numB = new int[5];
int num = 0;
int rivers = 0;
int Xmax;
int Ymax;
ArrayList<Biome> biomes = new ArrayList<Biome>();
LinkedList<Biome> startRiver = new LinkedList<Biome>();

void setup(){
  size(1000, 1000);
  Xmax = (width/(range * 3/2))-1;
  Ymax = (int)(height/(Ystart))-2;
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
}

void draw(){
  Biome biome;
  for(int x=0; x<Xmax; x++)
    for(int y=0; y<Ymax; y++){
      float nx = (float)x/((width/(range * 3/2))-1);
      float ny = (float)y/((height/(Ystart))-2);
      float nn = noise(nx*3, ny*3);
      biome = setBiome(nn);
      shape(dowel, Xstart + range*3/2*x, 
      Ystart+(range * 0.866 * (x%2)) + (range * 0.866)* 2 * y);
      if(biomes.size() < Xmax * Ymax)
        biomes.add(biome);
      else if(biomes.get(x * Ymax + y).getType() != biome.getType())
        biomes.set(x * Ymax + y, biome); //<>//
      if(random(100) <= 1)
        startRiver.add(biome);
      }
      if(num++ < 70){
        //Wait();
        learn();
        resetNumBiome();
        startRiver.clear();
    }
    else{
      flowRivers();
      noLoop();
    }
}
/*// If you want to see a slow learning
void Wait(){
  long mil = millis();
  while(millis() - mil < 100);
}*/


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

Biome setBiome(float nn){
  if(nn <= value[0]){
    dowel.setFill(#1D43B2);
    numB[0]++; 
  }
  else if(nn <= value[1]){
    dowel.setFill(#58D848);
    numB[1]++;
         }
  else if(nn <= value[2]){
    dowel.setFill(#1F4817);
    numB[2]++;
  }
  else if(nn <= value[3]){
    dowel.setFill(#E5DF23);
    numB[3]++;
  }
  else {
    dowel.setFill(#676C68);
    numB[4]++;
  }
  return new Biome(nn);
}

void resetNumBiome(){
  for(int i=0; i<numB.length; i++)
    numB[i] = 0;
}

void flowRivers(){
  int x, y, ind;
  for(int i = 0; i < startRiver.size(); i++){
    ind = biomes.indexOf(startRiver.get(i));
    x = ind/Xmax;
    y = ind%Xmax;
    biomes.get(ind).flowRiver();
  }
}
