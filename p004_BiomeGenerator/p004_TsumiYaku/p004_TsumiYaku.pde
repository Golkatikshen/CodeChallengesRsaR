int nuclei = 50;
int scale = 10;
int cols;
int rows;

Biome[] biomes = new Biome[nuclei];
Coordinate[] pos = new Coordinate[nuclei];
b_type[][] t_map;
float[][] s_map;


void setup() {
  size(800,800);
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
      rect(i*scale, j*scale, scale, scale);
    }
}

void place() { //places the biome nuclei on the map
  for(int i = 0; i < nuclei; i++) {
    biomes[i] = new Biome(random(100));
    Coordinate c = new Coordinate(floor(random(cols)), floor(random(rows)));
    pos[i] = c;
    t_map[c.x][c.y] = biomes[i].type;
    s_map[c.x][c.y] = biomes[i].str;
  } 
}

void diffuse() { //generates the map expanding from the nuclei
  for(int k = 0; k < nuclei; k++)
    for(int i = -pos[k].x; i < cols - pos[k].x; i++)
      for(int j = -pos[k].y; j < rows - pos[k].y; j++) {
        int distance = abs(i) + abs(j);
        int x = i + pos[k].x;
        int y = j + pos[k].y;
        float str = biomes[k].str/(Biome.scale*distance);
        if(str > s_map[x][y]) {
          t_map[x][y] = biomes[k].type;
          s_map[x][y] = str;
        }
      }
}

void colTable() {
  colors.put(b_type.DESERT, #F5DA77);
  colors.put(b_type.MOUNTAIN, #BFBEBD);
  colors.put(b_type.PLAINS, #25E800);
  colors.put(b_type.FOREST, #093601);
}
