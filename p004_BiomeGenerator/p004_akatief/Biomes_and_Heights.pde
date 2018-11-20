
BiomeHeight sea = new BiomeHeight(0.0, color(0, 90, 180));
float seaLevel = 0.55;
float grassLevel = 0.56;
float hillLevel = 0.68;
float mountainLevel = 0.75;
float peakLevel = 0.85;

BiomeHeight[] standard = {new BiomeHeight(peakLevel, color(51, 25, 0)),
  new BiomeHeight(mountainLevel, color(75, 33, 0)), 
  new BiomeHeight(hillLevel, color(120, 90, 0)),
  new BiomeHeight(grassLevel, color(0, 153, 0)), 
  new BiomeHeight(seaLevel, color(190, 190, 0)), 
  sea};
  
BiomeHeight[] mountain = {new BiomeHeight(peakLevel, color(224, 224, 224)),
  new BiomeHeight(mountainLevel, color(75, 33, 0)), 
  new BiomeHeight(hillLevel, color(75, 33, 0)),
  new BiomeHeight(grassLevel, color(0, 102, 0)), 
  new BiomeHeight(seaLevel, color(160, 160, 0)), 
  sea};
  
BiomeHeight[] desert = {new BiomeHeight(peakLevel, color(155, 120, 0)),
  new BiomeHeight(mountainLevel, color(170, 130, 0)),
  new BiomeHeight(hillLevel, color(180, 135, 0)),
  new BiomeHeight(seaLevel, color(200, 160, 0)), 
  sea};
  
BiomeHeight[] arid = {new BiomeHeight(peakLevel, color(80, 60, 0)),
  new BiomeHeight(mountainLevel, color(100, 75, 0)), 
  new BiomeHeight(hillLevel, color(120, 95, 0)),
  new BiomeHeight(grassLevel, color(150, 130, 0)), 
  new BiomeHeight(seaLevel, color(190, 190, 0)), 
  sea};


BiomeHeight[] jungle = {
  new BiomeHeight(peakLevel, color(100, 50, 0)),
  new BiomeHeight(mountainLevel, color(0,100,10)),
  new BiomeHeight(hillLevel, color(120, 95, 0)),
  new BiomeHeight(grassLevel, color(15,131,33)),
  new BiomeHeight(seaLevel, color(185,167,73)),
  sea};

//Biome(BiomeHeight[] h, int ns, float nS, int oct, float fo)

Biome[] biomesList = {new Biome(mountain, 1),
                  new Biome(mountain,0.8),
                  new Biome(standard,0.6),
                  //new Biome(jungle,0.5),
                  //new Biome(standard,0.45),
                  new Biome(standard,0.2),
                  new Biome(arid,0.15),
                  new Biome(arid,0.1),
                  new Biome(desert,0.07),
                  new Biome(desert, 0)};
                   
                   /*
Biome[] biomesList = {new Biome(jungle, 1),
                  new Biome(jungle, 0)};
*/
                  // BiomeHeatMap(Biome[] bm, float nS, int oct, float fo) {
BiomeHeatMap BHeat;// = new BiomeHeatMap(biomesList, noiseScale/5, 10, 0.5);
