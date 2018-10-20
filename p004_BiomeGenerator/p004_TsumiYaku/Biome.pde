public enum b_type {
  DESERT, PLAINS, MOUNTAIN, FOREST
};

public HashMap<b_type, Integer> colors = new HashMap<b_type, Integer>();

class Biome {
  static final float scale = 0.4;
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
