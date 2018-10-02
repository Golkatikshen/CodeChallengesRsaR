public class C_Triangle extends Cell
{
  boolean upside_down;
  int id_row;
  int id_n;
  
  boolean h_border;
  boolean l_border;
  boolean r_border;
  
  Cell h_cell;
  Cell l_cell;
  Cell r_cell;
  
  C_Triangle(int _x, int _y, boolean _usd, int _id_row, int _id_n)
  {
    super(_x, _y);
    
    upside_down = _usd;
    id_row = _id_row;
    id_n = _id_n;
    
    h_border = true;
    r_border = true;
    l_border = true;
    
    h_cell = null;
    r_cell = null;
    l_cell = null;
  }
  
  @Override
  void display()
  { 
    fill(200);
    stroke(200);
    if(!upside_down)
      triangle(x, y-(tri_height-tri_apothem), x-half_tri_size, y+tri_apothem, x+half_tri_size, y+tri_apothem);
    else
      triangle(x, y+(tri_height-tri_apothem), x-half_tri_size, y-tri_apothem, x+half_tri_size, y-tri_apothem);


    stroke(0);
    if(!upside_down)
    {
      if(h_border)
        line(x-half_tri_size, y+tri_apothem, x+half_tri_size, y+tri_apothem);
      if(l_border)
        line(x, y-(tri_height-tri_apothem), x-half_tri_size, y+tri_apothem);
      if(r_border)
        line(x, y-(tri_height-tri_apothem), x+half_tri_size, y+tri_apothem);
    }
    else
    {
      if(h_border)
        line(x-half_tri_size, y-tri_apothem, x+half_tri_size, y-tri_apothem);
      if(l_border)
        line(x, y+(tri_height-tri_apothem), x-half_tri_size, y-tri_apothem);
      if(r_border)
        line(x, y+(tri_height-tri_apothem), x+half_tri_size, y-tri_apothem);
    }
      
      
    if(start)
      fill(0, 200, 0);
    if(end)
      fill(200, 0, 0);
    
    noStroke();
    if(start || end) 
      ellipse(x, y, half_tri_size/3, half_tri_size/3);
  }
}
