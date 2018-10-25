int nuclei = 100;
float biome_decay = 0.1;
float village_decay = 0.5;
int scale = 2;
int cols;
int rows;
int rivers = floor(random(1, 10));
int lakes = floor(random(2, 10));
int villages = 20; //floor(random(5, 20));
float chanceRatio = 0.88;

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
  HashMap<b_type, Integer> chanceTable = villageChanceTable();
  int totChance = 0;
  for(int val: chanceTable.values())
    totChance += val;
  
  while(x == -1 && y == -1) {
    float c = random(2);
    int tx = floor(random(cols));
    int ty = floor(random(rows));
    float chance = (2*(float)chanceTable.get(t_map[tx][ty])/(float)totChance 
        + 8*(1 - pow(((float)closestWater(new Coordinate(tx, ty))/(float)max(cols, rows)), 2)))/10;
    //float chance = 1 - (float)closestWater(new Coordinate(tx, ty))/(float)max(cols, rows);
    //if(chance > 0.847)
    //  println(chance);
    
    if(chance > chanceRatio) {
      x = tx;
      y = ty;
    }
  }
  
  return new Coordinate(x, y);
}

HashMap<b_type, Integer> villageChanceTable() {
  HashMap<b_type, Integer> chanceTable = new HashMap<b_type, Integer>();
  
  chanceTable.put(b_type.DESERT, 1);
  chanceTable.put(b_type.MOUNTAIN, 1);
  chanceTable.put(b_type.WATER, 0);
  chanceTable.put(b_type.PLAINS, 5);
  chanceTable.put(b_type.VILLAGE, 0);
  chanceTable.put(b_type.FOREST, 3);
  
  return chanceTable;
}

int closestWater(Coordinate c) {
   for(int k = 0; k < max(cols, rows); k++) 
    for(int i = -k; i <= k; i++)
      for(int j = -k; j <= k; j++) {
        if(abs(i)+abs(j) == k)
          if(c.x + i >= 0 && c.x + i < cols && c.y + j >= 0 && c.y + j < rows)
            if(t_map[c.x+i][c.y+j] == b_type.WATER)
              return k;
      }
    return max(cols, rows);
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
