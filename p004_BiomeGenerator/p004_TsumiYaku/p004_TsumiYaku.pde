int nuclei = 50;
float decay_rate = 0.08;
int scale = 5;
int cols;
int rows;
int rivers = 10;

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
  
  colTable();
  biomePlace();
  biomeDiffuse();
  riverPlace();
}

void draw() {
  colorMap();
}

void biomePlace() { //places the biome nuclei on the map
  for(int i = 0; i < nuclei; i++) {
    biomes[i] = new Biome(random(100));
    Coordinate c = new Coordinate(floor(random(cols)), floor(random(rows)));
    pos[i] = c;
    t_map[c.x][c.y] = biomes[i].type;
    s_map[c.x][c.y] = biomes[i].str;
  } 
}

void biomeDiffuse() { //generates the map expanding from the nuclei
  for(int k = 0; k < nuclei; k++)
    for(int i = -pos[k].x; i < cols - pos[k].x; i++)
      for(int j = -pos[k].y; j < rows - pos[k].y; j++) {
        int distance = abs(i) + abs(j);
        int x = i + pos[k].x;
        int y = j + pos[k].y;
        float str = biomes[k].str/(pow(2, decay_rate*distance));
        if(str > s_map[x][y] || t_map[x][y] == null) {
          t_map[x][y] = biomes[k].type;
          s_map[x][y] = str;
        }
      }
}

void riverPlace() {
  int x, y;
  River riv;
  Coordinate start, end; //<>//
  for(int i = 0; i < rivers; i++) {
    do {
      x = floor(random(cols));
      y = floor(random(rows));
    } while(t_map[x][y] != b_type.MOUNTAIN);
    start = new Coordinate(x, y);
    do {
      x = floor(random(cols));
      y = floor(random(rows));
    } while(t_map[x][y] != b_type.WATER);
    end = new Coordinate(x,y); //<>//
    riv = new River(start, end);
    riv.place();
  }
}

void colorMap() {
  for(int i = 0; i < cols; i++)
    for(int j = 0; j < rows; j++) {
      fill(colors.get(t_map[i][j]));
      rect(i*scale, j*scale, scale, scale);
    } 
}
