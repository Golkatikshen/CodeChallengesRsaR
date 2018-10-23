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
        float str = biomes[k].str/(pow(2, Biome.scale*distance));
        if(str > s_map[x][y] || t_map[x][y] == null) {
          t_map[x][y] = biomes[k].type;
          s_map[x][y] = str;
        }
      }
}
