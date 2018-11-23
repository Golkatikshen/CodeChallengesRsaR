
color[][] generateColorMap(float[][] greyMap, int gmW, int gmH) {
  color[][] colorMap = new color[gmW][gmH];
  
  for (int i = 0; i<gmH; i++) {
    for (int j = 0; j<gmW; j++) {
      //usa come parametro CanvasSizeX/gmW
      //pickBiomesList(MBCollection, j,i,canvasSizeY/gmW);
      //BHeat.rescaleHeatMap(canvasSizeY/gmW);
      
      colorMap[i][j] = BHeat.getColorAtPosition(j*canvasSizeY/gmW,i*canvasSizeX/gmH,greyMap[i][j]);  //biomeFinalColor(thisZone,j,i,canvasSizeY/gmW,greyMap[i][j]);
      
    }
  }

  return colorMap;
}


float[][] generateGreyMap(float noiseScale, int octaves, float falloff) {
  float[][] greyMap = new float[canvasSizeX][canvasSizeY];
  float max = 0, min = 1;
  noiseSeed(seed);
  noiseDetail(octaves, falloff);
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      greyMap[i][j] = noise(i*noiseScale + offsetX, j*noiseScale + offsetY);
      if (greyMap[i][j] > max) {
        max = greyMap[i][j];
      } else if (greyMap[i][j]<min) {
        min = greyMap[i][j];
      }
    }
  }
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      greyMap[i][j] = map(greyMap[i][j], min, max,0.0, 1.0);
    }
  }

  return greyMap;
}

float[][] generateSigGreyMap(float noiseScale, int octaves, float falloff) {
  float[][] greyMap = new float[canvasSizeX][canvasSizeY];
  float max = 0, min = 1;
  noiseSeed(seed);
  noiseDetail(octaves, falloff);
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      greyMap[i][j] = sig(noise(i*noiseScale + offsetX, j*noiseScale + offsetY));
      
      if (greyMap[i][j] > max) {
        max = greyMap[i][j];
      } else if (greyMap[i][j]<min) {
        min = greyMap[i][j];
      }
    }
  }
  for (int i = 0; i<canvasSizeX; i++) {
    for (int j = 0; j<canvasSizeY; j++) {
      
      greyMap[i][j] = norm(greyMap[i][j], min, max);
      if(greyMap[i][j]<0) {
        greyMap[i][j] = abs(greyMap[i][j]);
      }
    }
  }

  return greyMap;
}

float[][] generateCitiesMap(int size, float greyMap[][],float[][] heatMap, float seaLevel) {
  float[][] probabilityMap = new float[size][size];
  float tmpRes;
  for(int i = 0; i<size; i++) {
    for(int j = 0; j<size; j++) {
      if(int(random(5000))==1) {
        tmpRes = 1;
        tmpRes *= ceil(greyMap[i][j] - seaLevel);
        tmpRes *= gauss(greyMap[i][j], 1.2, 0, 6);
        tmpRes *= gauss(heatMap[i][j], 2, -0.5, 4);
        probabilityMap[i][j] = tmpRes;
      }
      else
        probabilityMap[i][j] = 0;
    }  
  }
  return probabilityMap;
}

float[][] generateSpringMap(int size, float greyMap[][],float[][] heatMap, float seaLevel) {
  float[][] probabilityMap = new float[size][size];
  float tmpRes;
  for(int i = 0; i<size; i++) {
    for(int j = 0; j<size; j++) {
      if(int(random(500))==1) {
        tmpRes = 1;
        tmpRes *= ceil(greyMap[i][j] - seaLevel);
        tmpRes *= gauss(greyMap[i][j], 2.5, -1, 4);
        tmpRes *= gauss(heatMap[i][j], 1.2, -1, 6);
        probabilityMap[i][j] = tmpRes;
      }
      else
        probabilityMap[i][j] = 0;
    }  
  }
  return probabilityMap;
}
