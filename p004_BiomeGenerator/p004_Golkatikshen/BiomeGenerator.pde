class BiomeGenerator
{
  ArrayList<Biome> biomes;
  Pixel[][] pixels_data;
  River river;
  Village[] villages;
  int time;
  
  BiomeGenerator(ArrayList<CPolygon> p)
  {
    time = millis();
    
    biomes = new ArrayList();
    for(int i=0; i<p.size(); i++)
      biomes.add(new Biome(p.get(i)));
    
    pixels_data = new Pixel[width][height];
    
    for(int x=0; x<width; x++)
      for(int y=0; y<height; y++)
        for(int i=0; i<biomes.size(); i++)
          if(biomes.get(i).isInside(x, y))
            pixels_data[x][y] = biomes.get(i).getPixelData(x, y);
    
    println("Biomes generated");
    
    
    river = new River();
    for(int x=0; x<width; x++)
      for(int y=0; y<height; y++)
      {
        Pixel pix = pixels_data[x][y];
        if(pix == null)
          continue;
        
        if(pix.h < biomes.get(0).levels[0])
        {
          for(int i=0; i<river.segments.size(); i++)
            if(distanceToSegment(x, y, river.segments.get(i).A.x, river.segments.get(i).A.y, river.segments.get(i).B.x, river.segments.get(i).B.y) < map(pix.h, 0, biomes.get(0).levels[0], 15, 3))
            {
              pixels_data[x][y].c = color(0, 53, 193);
              pixels_data[x][y].h = 0;
              i = river.segments.size();
            }
        }
      }
      
    println("Rivers generated");
    
    
    //0,1,2 | 3,4 | 5
    int r = int(random(0, 6));
    int n_villages;
    if(r < 3)
      n_villages = 2;
    else if(r < 5)
      n_villages = 3;
    else
      n_villages = 4;
      
    villages = new Village[n_villages+2];
    ArrayList<Integer> poll = new ArrayList();
    for(int i=5; i<river.segments.size()-5; i++)
      poll.add(i);
      
    for(int i=0; i<n_villages; i++)
    {
      int id = poll.get(int(random(0, poll.size())));
      villages[i] = new Village(river.segments.get(id).A, id);
    }
    villages[n_villages] = new Village(new PVector(random(50, width-50), random(50, height-50)), -1);
    villages[n_villages+1] = new Village(new PVector(random(50, width-50), random(50, height-50)), -2);
    
    noStroke();
    fill(100);
    for(int x=0; x<width; x++)
      for(int y=0; y<height; y++)
      {
        Pixel pix = pixels_data[x][y];
        if(pix == null)
          continue;
        
        if(pix.h != 0 && pix.h < biomes.get(0).levels[3])
        {
          r = int(random(0, 15));
          if(r != 0)
            continue;
            
          for(int i=0; i<n_villages+2; i++)
            if(dist(pix.x, pix.y, villages[i].pos.x, villages[i].pos.y) < villages[i].radius)
            {
              int w = 2*int(random(1, 3));
              int h = 2*int(random(1, 3));
              float z = random(0.01, 0.02);
              for(int k=x-w/2; k<x+w/2; k++)
                for(int j=y-h/2; j<y+h/2; j++)
                {
                  if(k < 0 || j < 0 || k >= width || j >= height)
                    continue;
                  if(pixels_data[k][j] == null)
                    continue;
                    
                  pixels_data[k][j].c = color(100);
                  pixels_data[k][j].h = pixels_data[k][j].h+z;
                }
            }
        }
      }
    
    println("Villages generated ["+(n_villages+2)+"]");
    
    
    for(int x=0; x<width; x++)
      for(int y=0; y<height; y++)
      {
        Pixel pix = pixels_data[x][y];
        if(pix == null)
          continue;
          
        int n_s = int(pix.h*15);
        for(int i=0; i<n_s; i++)
        {
          if(x+i+1 < width)
          {
            if(pixels_data[x+i+1][y] != null)
            {
              if(pixels_data[x+i+1][y].h < pix.h)
                pixels_data[x+i+1][y].toTheDarkness();
              else
                i = n_s; // break;
            }
          }
        }
      }
      
    println("Shadows generated");
    
    time = millis()-time;
    println("Generation time: "+time+" ms\n");
  }
  
  String getInfoPix(int x, int y)
  {
    return "("+x+","+y+") - H: "+pixels_data[x][y].h+", BY: "+pixels_data[x][y].bt;
  }
  
  void display()
  {
    loadPixels();
    for(int i=0; i<width; i++)
      for(int j=0; j<height; j++)
      {
        if(pixels_data[i][j] != null)
          pixels_data[i][j].display();
      }
    updatePixels();
    
    if(show_voronoi)
    {
      river.display();
      for(Village v: villages)
        v.display();
    }
  }
}
