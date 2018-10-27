enum BTYPE 
{
  MOUNTAINS, FLAT, DESERT, LAKE;
  
  public static BTYPE fromID(int id) 
  {
      switch(id)
      {
        case 0:
          return MOUNTAINS;
        case 1:
          return FLAT;
        case 2:
          return DESERT;
        case 3:
          return LAKE;
      }
      return null;
  }
};

class Biome
{
  CPolygon polygon;
  BTYPE btype;
  
  float m_noise_detail = 0.01;
  float[] levels = new float[5];
  
  float m_from = 0.5;
  float m_to;

  Biome(CPolygon _polygon)
  {
    polygon = _polygon;
    btype = BTYPE.fromID(int(random(0, 4)));
    
    if(btype == BTYPE.MOUNTAINS)
      m_to = 1;
    if(btype == BTYPE.FLAT)
      m_to = 0.3;
    if(btype == BTYPE.DESERT)
      m_to = 0.2;
    if(btype == BTYPE.LAKE)
      m_to = 0.1;
      
    levels[0] = 0.29; //snow
    levels[1] = 0.27; //mountain high
    levels[2] = 0.25; //mountain med
    levels[3] = 0.22; //mountain low
    levels[4] = 0.12; //flat
  }
  
  boolean isInside(int x, int y)
  {
    return polygon.isInside(x, y);
  }
  
  Pixel getPixelData(int x, int y)
  {
    float dc = dist(polygon.center.x, polygon.center.y, x, y);
    float dl = 100000;
    float cvdl;
    for(int i=0; i<polygon.getNPoints(); i++)
    {
      if(i == polygon.getNPoints()-1)
        cvdl = distanceToLine(x, y, polygon.getXPoint(i), polygon.getYPoint(i), polygon.getXPoint(0), polygon.getYPoint(0));
      else
        cvdl = distanceToLine(x, y, polygon.getXPoint(i), polygon.getYPoint(i), polygon.getXPoint(i+1), polygon.getYPoint(i+1));
      
      if(cvdl < dl)
        dl = cvdl;
    }
      
    if(btype == BTYPE.MOUNTAINS)
    { 
      noiseDetail(5, 0.4);
      float n = noise(x*m_noise_detail, y*m_noise_detail);
      float m = map(dl, 0, dc+dl, m_from, m_to);
      n = n*m;
      
      color c;
      if(n>levels[0])
        c = color(map(n, 0.85, 1, 240, 155));
      else if(n>levels[1])
        c = color(67, 28, 4);
      else if(n>levels[2])
        c = color(73, 30, 5);
      else if(n>levels[3])
        c = color(88, 37, 6);
      else if(n>levels[4])
      {
        c = color(0, map(n, 0, 1, 100, 255), 0);
        noiseDetail(4, 0.4);
        n = noise(x*m_noise_detail, y*m_noise_detail);
        n = n*m;
      }
      else
      {
        c = color(0, 53, 193);
        n = 0;
      }
        
      return new Pixel(x, y, n, c, m, n, BTYPE.MOUNTAINS);
    } 

    if(btype == BTYPE.FLAT)
    {
      noiseDetail(5, 0.4);
      float n = noise(x*m_noise_detail, y*m_noise_detail);
      float m = map(dl, 0, dc+dl, m_from, m_to);
      n = n*m;
      
      color c;
      if(n>levels[0])
        c = color(map(n, 0.85, 1, 240, 155));
      else if(n>levels[1])
        c = color(67, 28, 4);
      else if(n>levels[2])
        c = color(73, 30, 5);
      else if(n>levels[3])
        c = color(88, 37, 6);
      else if(n>levels[4])
      {
        c = color(0, map(n, 0, 1, 100, 255), 0);
        noiseDetail(4, 0.4);
        n = noise(x*m_noise_detail, y*m_noise_detail);
        n = n*m;
      }
      else
      {
        c = color(0, 53, 193);
        n = 0;
      }
        
      return new Pixel(x, y, n, c, m, n, BTYPE.FLAT);
    }
    
    if(btype == BTYPE.DESERT)
    {
      noiseDetail(5, 0.4);
      float n = noise(x*m_noise_detail, y*m_noise_detail);
      float m = map(dl, 0, dc+dl, m_from, m_to);
      n = n*m;
      
      color c;
      if(n>levels[0])
        c = color(map(n, 0.85, 1, 240, 155));
      else if(n>levels[1])
        c = color(67, 28, 4);
      else if(n>levels[2])
        c = color(73, 30, 5);
      else if(n>levels[3])
        c = color(88, 37, 6);
      else if(n>levels[4])
      {
        c = color(0, map(n, 0, 1, 100, 255), 0);
        noiseDetail(4, 0.4);
        n = noise(x*m_noise_detail, y*m_noise_detail);
        n = n*m;
      }
      else
      {
        c = color(map(n, 0, 1, 150, 255), map(n, 0, 1, 150, 255), 0);
        noiseDetail(3, 0.4);
        n = noise(x*m_noise_detail, y*m_noise_detail);
        n = n*m;
      }
        
      return new Pixel(x, y, n, c, m, n, BTYPE.DESERT);
    }
    
    if(btype == BTYPE.LAKE)
    {
      noiseDetail(5, 0.4);
      float n = noise(x*m_noise_detail, y*m_noise_detail);
      float m = map(dl, 0, dc+dl, m_from, m_to);
      n = n*m;
      
      color c;
      if(n>levels[0])
        c = color(map(n, 0.85, 1, 240, 155));
      else if(n>levels[1])
        c = color(67, 28, 4);
      else if(n>levels[2])
        c = color(73, 30, 5);
      else if(n>levels[3])
        c = color(88, 37, 6);
      else if(n>levels[4])
      {
        c = color(0, map(n, 0, 1, 100, 255), 0);
        noiseDetail(4, 0.4);
        n = noise(x*m_noise_detail, y*m_noise_detail);
        n = n*m;
      }
      else
      {
        c = color(0, 53, 193);
        n = 0;
      }
        
      return new Pixel(x, y, n, c, m, n, BTYPE.LAKE);
    }
    
    return null;
  }
  
  color getBiomeColor()
  {
    switch(btype)
    {
      case MOUNTAINS:
        return color(70, 30, 5);
      case FLAT:
        return color(53, 191, 23);
      case DESERT:
        return color(255, 233, 64);
    }
    
    return color(0);
  }
}
