public class C_Hexagon extends Cell
{ 
  int id_row;
  int id_n;
  
  boolean ul_border;
  boolean ur_border;
  boolean dl_border;
  boolean dr_border;
  boolean r_border;
  boolean l_border;
  
  Cell ul_cell;
  Cell ur_cell;
  Cell dl_cell;
  Cell dr_cell;
  Cell r_cell;
  Cell l_cell;
  
  C_Hexagon(int _x, int _y, int _id_row, int _id_n)
  {
    super(_x, _y);
    
    id_row = _id_row;
    id_n = _id_n;
    
    ul_border = true;
    ur_border = true;
    dl_border = true;
    dr_border = true;
    r_border = true;
    l_border = true;
    
    ul_cell = null;
    ur_cell = null;
    dl_cell = null;
    dr_cell = null;
    r_cell = null;
    l_cell = null;
  }
  
  @Override
  void display()
  { 
    fill(200);
    stroke(200);
    polygon(x, y, hex_size, 6);
    
    stroke(0);
    if(ul_border && ul_cell != null)
      line(x+cos(PI/2+r60*2)*hex_size, y+sin(PI/2+r60*2)*hex_size, x+cos(PI/2+r60*3)*hex_size, y+sin(PI/2+r60*3)*hex_size);
    if(ur_border && ur_cell != null)
      line(x+cos(PI/2+r60*3)*hex_size, y+sin(PI/2+r60*3)*hex_size, x+cos(PI/2+r60*4)*hex_size, y+sin(PI/2+r60*4)*hex_size);
    if(l_border && l_cell != null)
      line(x+cos(PI/2+r60*2)*hex_size, y+sin(PI/2+r60*2)*hex_size, x+cos(PI/2+r60)*hex_size, y+sin(PI/2+r60)*hex_size);
    if(r_border && r_cell != null)
      line(x+cos(PI/2+r60*4)*hex_size, y+sin(PI/2+r60*4)*hex_size, x+cos(PI/2+r60*5)*hex_size, y+sin(PI/2+r60*5)*hex_size);
    if(dr_border && dr_cell != null)
      line(x+cos(PI/2+r60*5)*hex_size, y+sin(PI/2+r60*5)*hex_size, x+cos(PI/2+r60*6)*hex_size, y+sin(PI/2+r60*6)*hex_size);
    if(dl_border && dl_cell != null)
      line(x+cos(PI/2+r60*6)*hex_size, y+sin(PI/2+r60*6)*hex_size, x+cos(PI/2+r60)*hex_size, y+sin(PI/2+r60)*hex_size);
    
    /*fill(0, 0, 200);
    textSize(10);
    text(id_row+","+id_n, x, y);
    textAlign(CENTER, CENTER);*/
    
    if(start)
      fill(0, 200, 0);
    if(end)
      fill(200, 0, 0);
    
    noStroke();
    if(start || end) 
      ellipse(x, y, half_square_size/2, half_square_size/2);
      
    //if(ur_cell != null || ul_cell != null || l_cell != null || r_cell != null || dr_cell != null || dl_cell != null)
      //end = true;
  }
}
