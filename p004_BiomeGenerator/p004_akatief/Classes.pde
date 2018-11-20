
class Biome {
  BiomeHeight[] heights;
  float specificHeat;
  //private float noiseScale, falloff;
  //private int octaves;
  //float[][] greyMap = new float[canvasSizeY][canvasSizeX];
  //private float[][] rescaledBioMap = new float[canvasSizeY][canvasSizeX];
  Biome(BiomeHeight[] h, float sh ) {
    heights = h;
    specificHeat = sh;
    //noiseScale = nS;
    //falloff = fo;
    //octaves = oct;
    //greyMap = generateGreyMap(nS, oct,fo);
  }
}

class BiomeHeatMap {
  Biome[] biomes;
  float[][] heatMap = new float[canvasSizeY][canvasSizeX];
  float[][] rescaledHeatMap = new float[canvasSizeY][canvasSizeX];
  BiomeHeatMap(Biome[] bm, float nS, int oct, float fo) {
    biomes = bm;
    heatMap = generateSigGreyMap(nS, oct, fo);
    
  }
  
  color getColorAtPosition(int x, int y, float altitude) {
    //rescaledHeatMap = rescaleHeatMap(squareDim);
    float heat = heatMap[y][x];
    Biome[] marginBiomes = biomeAtHeat(biomes,heat);
    color c1 = color(0,0,0) ,c2 = color(0,0,0);
    c1 = colorAtAltitude(marginBiomes[0].heights,altitude);
    c2 = colorAtAltitude(marginBiomes[1].heights,altitude);
    color[] colors = {c2,c1};//i coeff sono invertiti rispetto ai colori non chiedere perchè
    float[] coeffs = {abs(marginBiomes[0].specificHeat - heat),abs(marginBiomes[1].specificHeat - heat)};
    color finalColor = colorMean(colors, coeffs);
    return finalColor;
  }
  
  float[][] rescaleHeatMap(int squareDim) {
    if(squareDim == 1) {
      return heatMap;
    }
    if (rescaledHeatMap.length!= canvasSizeX/squareDim) {
      rescaledHeatMap = matrixRescale(greyMap, squareDim);
    }
    return rescaledHeatMap;
  }
}

class BiomeHeight {
  float minHeight;
  //ColorRatio clr;
  color clr;
  BiomeHeight (float h, color c) {
    minHeight = h;
    //clr = new ColorRatio(c);
    clr = c;
  }
  
}
