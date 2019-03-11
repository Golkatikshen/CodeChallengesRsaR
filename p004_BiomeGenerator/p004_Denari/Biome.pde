public enum biome_t {
  DESERT, PLAIN, MOUNTAIN, FOREST, WATER
};

class Biome{
  
  private biome_t type;
  private boolean nearRiver = false;
  private float altitude;
  
  public Biome(float nn){
    if(nn <= p004_Denari.value[0])
      type = biome_t.WATER;
    else if(nn <= p004_Denari.value[1])
      type = biome_t.PLAIN;
    else if(nn <= p004_Denari.value[2])
      type = biome_t.FOREST;
    else if(nn <= p004_Denari.value[3])
      type = biome_t.DESERT;
    else 
      type = biome_t.MOUNTAIN;
    altitude = nn;
  }
  
  public biome_t getType(){
    return this.type;
  }
  
  public void flowRiver(){
    nearRiver = true;
  }
}
