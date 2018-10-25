int nuclei = 100;
float biome_decay = 0.1;
float village_decay = 0.5;
int scale = 2;
int cols;
int rows;
int rivers = floor(random(1, 6));
int lakes = floor(random(2, 6));
int villages = floor(random(5, 20));

Biome[] biomes = new Biome[nuclei+lakes];
Coordinate[] pos = new Coordinate[nuclei+lakes];
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
  riverPlace(); //<>//
  villagePlace();
}

void draw() {
  colorMap();
}

void biomePlace() { //places the biome nuclei on the map
  Biome b;
  
  for(int i = 0; i < nuclei; i++) {
    Coordinate c = new Coordinate(floor(random(cols)), floor(random(rows)));
    b = new Biome(c, random(100));
    diffuse(b, biome_decay);
  } 
  for(int i = 0; i < lakes; i++) {
    Coordinate c = new Coordinate(floor(random(cols)), floor(random(rows)));
    b = new Biome(c, random(100), b_type.WATER);
    diffuse(b, biome_decay);
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

void villagePlace() {
  for(int k = 0; k < villages; k++) {
    Coordinate pos = villageRandomPos();
    Biome v = new Biome(pos, 120, b_type.VILLAGE);
    diffuse(v, village_decay);
  }
}

Coordinate villageRandomPos() {  
  int x = -1, y = -1;
  HashMap<b_type, Integer> chanceTable = villageChance();
  int totChance = 0;
  for(int val: chanceTable.values())
    totChance += val;
  
  while(x == -1 && y == -1) {
    float chance = random(1);
    int tx = floor(random(cols));
    int ty = floor(random(rows));
    
    if(chance < (float)chanceTable.get(t_map[tx][ty])/(float)totChance) {
      x = tx;
      y = ty;
    }
  }
  
  return new Coordinate(x, y);
}

HashMap<b_type, Integer> villageChance() {
  HashMap<b_type, Integer> chanceTable = new HashMap<b_type, Integer>();
  
  chanceTable.put(b_type.DESERT, 1);
  chanceTable.put(b_type.MOUNTAIN, 1);
  chanceTable.put(b_type.WATER, 15);
  chanceTable.put(b_type.PLAINS, 3);
  chanceTable.put(b_type.FOREST, 2);
  
  return chanceTable;
}

void colorMap() {
  for(int i = 0; i < cols; i++)
    for(int j = 0; j < rows; j++) {
      fill(colors.get(t_map[i][j]));
      rect(i*scale, j*scale, scale, scale);
    } 
}

void diffuse(Biome b, float decay) {
  t_map[b.pos.x][b.pos.y] = b.type;
  for(int i = -b.pos.x; i < cols - b.pos.x; i++)
      for(int j = -b.pos.y; j < rows - b.pos.y; j++) {
        int distance = abs(i) + abs(j);
        int x = i + b.pos.x;
        int y = j + b.pos.y;
        float str = b.str/(pow(2, decay*distance));
        if(str > s_map[x][y] || t_map[x][y] == null) {
          t_map[x][y] = b.type;
          s_map[x][y] = str;
        }
      }
}
