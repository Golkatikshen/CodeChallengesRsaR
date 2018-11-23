
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
      ridgeMap[i][j] = norm(ridgeMap[i][j], 0, 1.5);
    }
  }
  return ridgeMap;
}

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

River digRiver(float greyMap[][], float seaLevel, int springX, int springY) {
  ArrayList<Point> points = new ArrayList<Point>();
  float altitude = greyMap[springY][springX], prevAlt;
  int size = greyMap.length;
  int outfall = 0;
  int gradX = 0, gradY = 0;
  while(altitude>seaLevel && outfall != 1 ) {
    prevAlt = altitude;
    for(int i = springY-1; i<springY+2;i++) {
      for(int j = springX-1; j<springX+2;j++) {
        if(i<size && j<size && i>=0 && j>=0 && i!=springY && j!=springX) {
          if(greyMap[i][j]<altitude) {
            altitude = greyMap[i][j];
            gradX = j;
            gradY = i;
          }
        }
      }
    }
    springX = gradX;
    springY = gradY;
    if(prevAlt==altitude)
      break;
    points.add(new Point(gradX, gradY));
    if(altitude<seaLevel)
      outfall = 1;
  }
  if(outfall == 1) {
    return new River(points.toArray(new Point[0]));  
  }
  else {
    Point[] tmpPunti = new Point[0];
    return new River(tmpPunti);
  }
  
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

String randomName(String[] prefixes, String[] suffixes) {
  String pre = prefixes[int(random(prefixes.length))];
  String suf = suffixes[int(random(suffixes.length))];
  return pre+suf;
}

float sig(float x) {
  return -1/(1 + exp(10*x - 5)) + 1;
}
float sigSmall(float x) {
  return -1/(1 + exp(100*x - 90)) + 1;
}

float gauss(float x, float a, float o, float p) {
  return exp(-1*pow(a*(x+o), p));
}

float isl(float x) {
  return 1/(1+exp(20*x - 20));
}
