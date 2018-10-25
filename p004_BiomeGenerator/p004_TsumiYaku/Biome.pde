public enum b_type {
  DESERT, PLAINS, MOUNTAIN, FOREST, WATER, VILLAGE
};

public HashMap<b_type, Integer> colors = new HashMap<b_type, Integer>();

void colTable() { //associates colors to biomes filling the HashMap
  colors.put(b_type.DESERT, #F5DA77);
  colors.put(b_type.MOUNTAIN, #BFBEBD);
  colors.put(b_type.PLAINS, #25E800);
  colors.put(b_type.FOREST, #093601);
  colors.put(b_type.WATER, #02E5D8);
  colors.put(b_type.VILLAGE, #FF0900);
}

class Biome {
  float str;
  b_type type;
  Coordinate pos;

  public Biome(Coordinate c, float str, b_type type) { //generates specific biome
    pos = c;
    this.str = str;
    this.type = type;
  }

  public Biome(Coordinate c, float str) { //generates random biome
    pos = c;
    this.str = str;
    float chance = random(100);
    int num = b_type.FOREST.ordinal()+1;
    for(int i = 100/num, j = 0; i <= 100; i += 100/num, j++) {
      if (chance <= i) {
        type =  b_type.values()[j];
        break;
      }
    }
  }
  
  
}
