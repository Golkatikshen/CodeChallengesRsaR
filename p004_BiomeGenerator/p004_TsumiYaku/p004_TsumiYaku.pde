int nuclei = 10;
int scale = 1;
int cols;
int rows;

Biome[] biomes = new Biome[nuclei];
Coordinate[] pos = new Coordinate[nuclei];
b_type[][] t_map;
float[][] s_map;


void setup() {
  size(600, 600);
  noStroke();
  cols = floor(width/scale);
  rows = floor(height/scale);
  
  t_map = new b_type[cols][rows];
  s_map = new float[cols][rows];
  
  place();
  diffuse();
  colTable();
}

void draw() {
  for(int i = 0; i < cols; i++)
    for(int j = 0; j < rows; j++) {
      fill(colors.get(t_map[i][j]));
      rect(i*scale, j*scale, scale, scale); //<>//
    }
}
