class Poly extends Obstacle
{
  Polygon poly;
  
  Poly()
  {
    super();
    poly = new Polygon();
  }
  
  void addPoint(int x, int y)
  {
    poly.addPoint(x, y);
  }
  
  void generatePolyWalls()
  {
    for(int i=0; i<poly.npoints; i++)
    {
      if(i == poly.npoints-1)
        walls.add(new Wall(poly.xpoints[i], poly.ypoints[i], poly.xpoints[0], poly.ypoints[0]));
      else
        walls.add(new Wall(poly.xpoints[i], poly.ypoints[i], poly.xpoints[i+1], poly.ypoints[i+1]));
    }
  }
  
  @Override
  boolean isInside(int x, int y)
  {
    return poly.contains(x, y);
  }
}
