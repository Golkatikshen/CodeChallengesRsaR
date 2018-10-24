int nuclei = 50;
float decay_rate = 0.08;
int scale = 5;
int cols;
int rows;

Biome[] biomes = new Biome[nuclei];
Coordinate[] pos = new Coordinate[nuclei];
b_type[][] t_map;
float[][] s_map;
River riv;

void setup() {
  size(600, 600);
  noStroke();
  cols = floor(width/scale);
  rows = floor(height/scale);
  
  t_map = new b_type[cols][rows];
  s_map = new float[cols][rows];
  
  colTable();
  place();
  riv = new River(new Coordinate(0,0), new Coordinate(cols-1, rows-1));
}

void draw() {
  diffuse();
  for(int i = 0; i < cols; i++)
    for(int j = 0; j < rows; j++) {
      fill(colors.get(t_map[i][j]));
      rect(i*scale, j*scale, scale, scale); //<>//
    }
  riv.riverDraw();
}
