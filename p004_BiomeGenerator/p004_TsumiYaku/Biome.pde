public enum b_type {
  DESERT, PLAINS, MOUNTAIN, FOREST, WATER
};

public HashMap<b_type, Integer> colors = new HashMap<b_type, Integer>();

void colTable() { //associates colors to biomes filling the HashMap
  colors.put(b_type.DESERT, #F5DA77);
  colors.put(b_type.MOUNTAIN, #BFBEBD);
  colors.put(b_type.PLAINS, #25E800);
  colors.put(b_type.FOREST, #093601);
  colors.put(b_type.WATER, #02E5D8);
}

class Biome {
  float str;
  b_type type;

  public Biome(float str, b_type type) { //generates specific biome
    this.str = str;
    this.type = type;
  }

  public Biome(float str) { //generates random biome
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
