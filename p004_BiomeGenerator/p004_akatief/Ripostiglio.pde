/*
Biome[] pickBiomesList(MetaBiome mb, int x, int y, int squareDim) {
  float heat = mb.rescaleHeatMap(squareDim)[y][x];
  return mb.getBiomeList(heat);
}
*/


/*
class MetaBiome {
  Biome[][] biomesLists;
  float[] heats;
  float[][] heatMap = new float[canvasSizeX][canvasSizeY];
  float[][] rescaledHeatMap = new float[canvasSizeX][canvasSizeY];
  MetaBiome(Biome[][]bls, float[] hs, float nS, int oct, float fo) {
    biomesLists = bls;
    heats = hs;
    heatMap = generateGreyMap(nS, oct, fo);
  }
  float[][] rescaleHeatMap(int squareDim) {
    
    if (rescaledHeatMap.length!= canvasSizeX/squareDim) {
      rescaledHeatMap = matrixRescale(greyMap, squareDim);
    }
    return rescaledHeatMap;
  }
  Biome[] getBiomeList(float pointHeat) {
    for (int i = 0; i<heats.length;i++) {
      if (heats[i]<pointHeat) {
        return biomesLists[i];
      }
    }
    return biomesLists[biomesLists.length-1];
  }
}
*/

/*
color colorMean(color c1, color c2, float v1, float v2) {
  float tot = v1+v2;
  float r1= v1/tot, r2 = v2/tot;
  int rm = int(sqrt((sq(red(c1)) + sq(red(c2)))));
  int gm = int(sqrt((sq(green(c1)) + sq(green(c2)))));
  int bm = int(sqrt((sq(blue(c1)) + sq(blue(c2)))));
  return color(rm,gm,bm);
  
}
*/


/*BiomeHeight[] thisBiome = bmp.pickBiome(i,j);
      for (int b = 0; b<thisBiome.length;b++) {
        if(thisBiome[b].minHeight<greyMap[i][j]) {
          colorMap[i][j] = thisBiome[b].clr;
          break;
        }
      }*/

/*      color c1 = 0, c2 = 0;
      Biome[] selectedBiomesList = selectBiomes(biomesList,j,i);
      //BiomeHeight[] selectedBiome = desert;
      for (int b = 0; b<selectedBiomesList[0].heights.length; b++) {
        if (greyMap[i][j]>selectedBiomesList[0].heights[b].minHeight) {
          c1 = selectedBiomesList[0].heights[b].clr;//.ToColor(int(greyMap[i][j]*10));
          break;
        }
      }
      for (int b = 0; b<selectedBiomesList[1].heights.length; b++) {
        if (greyMap[i][j]>selectedBiomesList[1].heights[b].minHeight) {
          c2 = selectedBiomesList[1].heights[b].clr;//.ToColor(int(greyMap[i][j]*10));
          break;
        }
      }
      
      colorMap[i][j] = colorMean(c1,c2,selectedBiomesList[0].getNoiseValue(i*squareDim,j*squareDim) ,selectedBiomesList[1].getNoiseValue(i*squareDim,j*squareDim));
      */
