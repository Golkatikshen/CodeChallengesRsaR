int canvasSizeX = 600, canvasSizeY = canvasSizeX, seed = 86599;
int squareDim = canvasSizeX/5;
int offsetX = 0, offsetY = 0;
float noiseScale = 0.015f;  

float[][] greyMap;
float[][] riverSpawnMap;
void setup() {
  size(600, 600);
  setupRefresh();
}

void draw() {
  //drawGreyMap(greyMap);
  //drawMap(greyMap);
  
  if (squareDim>1) {
    renderMap(greyMap, squareDim);
    squareDim/=1.3;
  }
  else {
    drawMap(greyMap);
    noLoop();
    //saveFrame("Image-##.png");
    //println("Image Saved");
  }
  
}

void keyPressed() {
  if (key == 'r') {
    setupRefresh();
    loop();
  }
}

void setupRefresh() {
  seed+=random(-100,100);
  println(seed);
  noiseSeed(seed);
  BHeat = new BiomeHeatMap(biomesList, noiseScale/5, 10, 0.5);
  squareDim = canvasSizeX/8;
  greyMap = generateGreyMap(noiseScale,5,0.5);
  greyMap = ridgeFilter(greyMap);
  greyMap = islandFilter(greyMap);
  //greyMap = generateRiverGreyMap(noiseScale,15,0.5);
}


void renderMap(float[][] greyMap, int squareDim) {
  float[][] rescaledMatrix;
  color[][] rescaledColorMap;
  rescaledMatrix = matrixRescale(greyMap, squareDim);
  rescaledColorMap = generateColorMap(rescaledMatrix, canvasSizeY/squareDim, canvasSizeX/squareDim);
  for (int i = 0; i<canvasSizeY/squareDim; i++) {
    for (int j = 0; j<canvasSizeX/squareDim; j++) {
      stroke(color(1, 1, 1), 0);
      fill(rescaledColorMap[i][j]);
      rect(i*squareDim, j*squareDim, squareDim, squareDim);
    }
  }
}

void drawMap(float[][] greyMap) {

  color[][] colorMap = generateColorMap(greyMap, canvasSizeX, canvasSizeY);

  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      //color clr = color(greyMap[i][j]*255);
      color clr = colorMap[i][j];
      stroke(clr);
      rect(i, j,1,1);
    }
  }
}

void drawGreyMap(float[][] greyMap) {

  //color[][] colorMap = generateColorMap(greyMap, canvasSizeX, canvasSizeY);

  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      //color clr = color(greyMap[i][j]*255);
      color clr = color((1-greyMap[i][j])*255);
      stroke(clr);
      point(i, j);
    }
  }
}
