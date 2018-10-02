public class C_Square extends Cell
{ 
  boolean u_border;
  boolean d_border;
  boolean r_border;
  boolean l_border;
  
  Cell u_cell;
  Cell d_cell;
  Cell r_cell;
  Cell l_cell;
  
  C_Square(int _x, int _y)
  {
    super(_x, _y);
    
    u_border = true;
    d_border = true;
    r_border = true;
    l_border = true;
    
    u_cell = null;
    d_cell = null;
    r_cell = null;
    l_cell = null;
  }
  
  @Override
  void display()
  { 
    fill(200);
    noStroke();
    rect(x, y, square_size, square_size);
    
    stroke(0);
    if(u_border)
      line(x-half_square_size, y-half_square_size, x+half_square_size, y-half_square_size);
    if(d_border)
      line(x-half_square_size, y+half_square_size, x+half_square_size, y+half_square_size);
    if(r_border)
      line(x+half_square_size, y-half_square_size, x+half_square_size, y+half_square_size);
    if(l_border)
      line(x-half_square_size, y-half_square_size, x-half_square_size, y+half_square_size);
      
      
    if(start)
      fill(0, 200, 0);
    if(end)
      fill(200, 0, 0);
    
    noStroke();
    if(start || end) 
      ellipse(x, y, half_square_size/2, half_square_size/2);
  }
}
