
float[][] matrixRescale(float[][] greyMap, int squareDim) {
  if (squareDim == 1) {
    return greyMap;
  }
  float[][] rescaledMatrix = new float[canvasSizeY/squareDim][canvasSizeX/squareDim];
  float tempF;
  int altI, altJ;
  for (int i = 0; i<canvasSizeY/squareDim; i++) {
    for (int j = 0; j<canvasSizeX/squareDim; j++) {
      tempF = i;
      altI = int(map(tempF, 0, canvasSizeY/squareDim, 0, canvasSizeY));
      tempF = j;
      altJ = int(map(tempF, 0, canvasSizeX/squareDim, 0, canvasSizeX));
      rescaledMatrix[i][j] = greyMap[altI][altJ];
    }
  }
  return rescaledMatrix;
}

float[][] islandFilter(float[][] greyMap) {
  int matrixHeight = greyMap.length;
  int matrixWidth = greyMap[0].length;
  float maxRadius = matrixHeight/2;
  //float wRadius = matrixWidth/2;
  for (int i = 0; i<matrixHeight; i++) {
    for (int j = 0; j<matrixWidth; j++) {
      float thisRadius = sqrt(sq(abs(i-matrixHeight/2)) + sq(abs(j-matrixWidth/2)));
      float ratio = thisRadius/maxRadius;
      greyMap[i][j] *= isl(ratio);
    }
  }
  return greyMap;
}

float[][] ridgeFilter(float[][] greyMap) {
  float max = 0, min = 2;
  int oct = 2;
  float fo = 0.5;
  float nS = noiseScale/50;
  float[][] ridgeMap = generateGreyMap(nS, oct, fo);
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      if (ridgeMap[i][j] > max) {
        max = ridgeMap[i][j];
      } else if (ridgeMap[i][j]<min) {
        min = ridgeMap[i][j];
      }
    }
  }
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      ridgeMap[i][j] = norm(ridgeMap[i][j], min, max);
    }
  }
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      ridgeMap[i][j]-=0.5;
      ridgeMap[i][j] = abs(ridgeMap[i][j])*-1 + 0.5;
      ridgeMap[i][j] += greyMap[i][j];
      ridgeMap[i][j] = norm(ridgeMap[i][j],0,1.5);
    }
  }
  return ridgeMap;
}



/*
Biome[] selectBiomes(Biome[] biomes, int x, int y) {
 Biome[] selectedBiomes = new Biome[2];
 float highestVal = 0, secondHighestVal = 0, noiseVal;
 for (int i = 0; i<biomes.length;i++) {
 noiseVal = biomes[i].getNoiseValue(y,x);
 if (noiseVal>highestVal) {
 selectedBiomes[1] = selectedBiomes[0];
 selectedBiomes[0] = biomes[i];
 secondHighestVal = highestVal;
 highestVal = noiseVal;
 }
 else if (noiseVal > secondHighestVal) {
 selectedBiomes[1] = biomes[i];
 secondHighestVal = noiseVal;
 }
 }
 return selectedBiomes;
 }
 */
/*
color biomeFinalColor(Biome[] bList, int x, int y, int squareDim, float altitude) {
 color[] biomeColors = new color[bList.length];
 float[] coeffValues = new float[bList.length];
 for (int b = 0; b<bList.length; b++) {
 biomeColors[b] = colorAtAltitude(bList[b].heights, altitude);
 coeffValues[b] = sig(bList[b].rescaledBiomeMap(squareDim)[y][x]);
 }
 //trova i colori dei due biomi principali in corrispondenza di altitude
 color blended = colorMean(biomeColors, coeffValues);
 return blended;
 }
 */


color colorAtAltitude(BiomeHeight[] bh, float altitude) {
  for (int h = 0; h<bh.length; h++) {
    if (altitude>bh[h].minHeight) {
      //println(bh[h].clr);
      return bh[h].clr;
    }
  }
  //println(bh[bh.length-1].clr);
  return bh[bh.length-1].clr;
}

Biome[] biomeAtHeat(Biome[] biomes, float heat) {//lo 0 è il bioma superiore, l'1 quello inferiore
  Biome[] marginBiomes = new Biome[2];
  for (int h = 1; h<biomes.length; h++) {//comincio da 1 perchè heat non potra mai essere > del primo bioma, che ha heat 1
    if (heat>=biomes[h].specificHeat) {
      marginBiomes[0] = biomes[h-1];
      marginBiomes[1] = biomes[h];
      return marginBiomes;
    }
  }
  marginBiomes[0] = biomes[biomes.length-2];
  marginBiomes[1] = biomes[biomes.length-1];
  return marginBiomes;
}

color colorMean(color[] colors, float[] coeffs) {
  if (colorDistance(colors[0], colors[1])>220) {
    if (coeffs[0]>coeffs[1])
      return colors[0];
    else
      return colors[1];
  }
  float sumR = 0, sumG = 0, sumB = 0;
  float tot = 0;
  for (int i = 0; i<colors.length; i++) {
    coeffs[i] = map(coeffs[i], 0, 1, min(coeffs), max(coeffs));
    sumR += sq(red(colors[i])) * coeffs[i];
    sumG += sq(green(colors[i])) * coeffs[i];
    sumB += sq(blue(colors[i])) * coeffs[i];
    tot += coeffs[i];
  }
  sumR = sqrt(sumR/tot);
  sumG = sqrt(sumG/tot);
  sumB = sqrt(sumB/tot);
  return color(sumR, sumG, sumB);
}

float colorDistance(color c1, color c2) {
  float r1 = sq(red(c1));
  float r2 = sq(red(c2));
  float g1 = sq(green(c1));
  float g2 = sq(green(c2));
  float b1 = sq(blue(c1));
  float b2 = sq(blue(c2));
  float dr = abs(r1-r2), dg = abs(g1-g2), db = abs(b1-b2);
  float dm = (dr+dg+db)/3;
  return sqrt(dm);
}

float sig(float x) {
  return -1/(1 + exp(10*x - 5)) + 1;
}
float sigSmall(float x) {
  return -1/(1 + exp(100*x - 90)) + 1;
}

float gauss(float x) {
  return exp(-1*pow(6*(x-0.5),4));
}

float isl(float x) {
  return 1/(1+exp(20*x - 20));
}
