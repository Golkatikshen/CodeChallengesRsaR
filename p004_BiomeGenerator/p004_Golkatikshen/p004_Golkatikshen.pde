//Biome Generator

SuperVoronoi V;
BiomeGenerator BG;
boolean show_voronoi = true;
int seed;

void setup()
{
  size(600, 500);
  strokeWeight(4);
  
  generate();
  
  textSize(15);
}

void draw()
{
  background(200);
  
  BG.display();
  if(show_voronoi)
    V.display();
  
  fill(0);
  text(BG.getInfoPix(mouseX, mouseY), 5, 15);
  text("Seed: "+seed, 5, 30);
}

void keyPressed()
{
  if(key == 'v')
    show_voronoi = !show_voronoi;
    
  if(key == 'r')
    generate();
}

void generate()
{
  seed = int(random(0, 10000));
  noiseSeed(seed);
  randomSeed(seed);
  V = new SuperVoronoi(12);
  BG = new BiomeGenerator(V.polygons);
}

void generate(int seed)
{
  noiseSeed(seed);
  randomSeed(seed);
  V = new SuperVoronoi(12);
  BG = new BiomeGenerator(V.polygons);
}
