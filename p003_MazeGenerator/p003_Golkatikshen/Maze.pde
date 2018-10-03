public class Maze
{
  //type legend
  // 0 = square
  // 1 = tri
  // 2 = hex
  
  int cols;
  int rows;
  int type;
  
  ArrayList<Cell> cells;
  ArrayList<PVector> sol_points;
  
  Maze(int _cols, int _rows, int _type)
  {
    cols = _cols;
    rows = _rows;
    type = _type;
    
    cells = new ArrayList();
    sol_points = new ArrayList();
    
    if(type == 0)
    {
      int psx = (width/2)-(half_square_size*cols)+half_square_size;
      int psy = (height/2)-(half_square_size*rows)+half_square_size;
      
      //Calculation of the cells position for the squared maze
      for(int i=0; i<cols; i++)
        for(int j=0; j<rows; j++)
        {
          cells.add(new C_Square(psx+i*square_size, psy+j*square_size));
          
          if(i==0)
            ((C_Square)cells.get(cells.size()-1)).l_cell = the_void;
          if(j==0)
            ((C_Square)cells.get(cells.size()-1)).u_cell = the_void;
          if(i==cols-1)
            ((C_Square)cells.get(cells.size()-1)).r_cell = the_void;
          if(j==rows-1)
            ((C_Square)cells.get(cells.size()-1)).d_cell = the_void;
        }
        
      //Linking each cell with the neighbours
      for(int i=psx; i<psx+cols*square_size; i+=square_size)
        for(int j=psy; j<psy+rows*square_size; j+=square_size)
        {
          C_Square c = (C_Square)getCellByPosition(i, j);
          if(c.u_cell == null)
            c.u_cell = (C_Square)getCellByPosition(i, j-square_size);
          if(c.d_cell == null)
            c.d_cell = (C_Square)getCellByPosition(i, j+square_size);
          if(c.l_cell == null)
            c.l_cell = (C_Square)getCellByPosition(i-square_size, j);
          if(c.r_cell == null)
            c.r_cell = (C_Square)getCellByPosition(i+square_size, j);
        }
        
      int pix = psx + int(random(0, cols))*square_size;
      int piy = psy + int(random(0, rows))*square_size;
      ((C_Square)getCellByPosition(psx, psy + int(random(0, rows))*square_size)).start = true;
      ((C_Square)getCellByPosition(psx+(cols-1)*square_size, psy + int(random(0, rows))*square_size)).end = true;
      
      //println("X0: "+psx);
      //println("Y0: "+psy);
      squareMazeGeneration(pix, piy);
      //println("Squared maze generation done");
    }
    
    if(type == 1)
    {
      //ignoring rows
      int n_side = cols;
      int maze_side = n_side*tri_size;
      float x = sqrt((2*tri_apothem)*(2*tri_apothem)-(half_tri_size)*(half_tri_size));
      
      int psx = width/2;
      int psy = int((height/2)-(maze_side*sqrt(3)/2-maze_side/(2*sqrt(3)))+(tri_height-tri_apothem)*5);
      
      //Calculation of the cells position for the triangular maze
      for(int i=0; i<n_side; i++)
      {
        for(int j=0; j<2*i+1; j++)
        {
          if(j%2 == 0)
            cells.add(new C_Triangle(psx+half_tri_size*j, psy, false, i, j));
          else
            cells.add(new C_Triangle(psx+half_tri_size*j, int(psy-x), true, i, j));
            
          if(i==n_side-1 && j%2 == 0)
            ((C_Triangle)cells.get(cells.size()-1)).h_cell = the_void;
          if(j==0)
            ((C_Triangle)cells.get(cells.size()-1)).l_cell = the_void;
          if(j==2*i)
            ((C_Triangle)cells.get(cells.size()-1)).r_cell = the_void;
        }
        
        psx -= half_tri_size;
        psy += tri_height;
      }
      
      //Linking each cell with the neighbours
      for(int i=0; i<cells.size(); i++)
      {
        C_Triangle c = (C_Triangle)cells.get(i);
        
        if(c.id_n%2 == 1)
        {
          if(c.h_cell == null)
            c.h_cell = getTCell(c.id_row-1, c.id_n-1);
          if(c.l_cell == null)
            c.l_cell = getTCell(c.id_row, c.id_n-1);
          if(c.r_cell == null)
            c.r_cell = getTCell(c.id_row, c.id_n+1);
        }
        else
        {
          if(c.h_cell == null)
            c.h_cell = getTCell(c.id_row+1, c.id_n+1);
          if(c.l_cell == null)
            c.l_cell = getTCell(c.id_row, c.id_n-1);
          if(c.r_cell == null)
            c.r_cell = getTCell(c.id_row, c.id_n+1);
        }
      }
      
      int i_id_row = int(random(0, n_side));
      int i_id_n = int(random(0, i_id_row));
      getTCell(int(random(0, n_side/2)), 0).start = true;
      int v = int(random(n_side/2+1, n_side));
      getTCell(v, 2*v).end = true;
      
      //println("ID_ROW: "+i_id_row);
      //println("ID_N: "+i_id_n);
      triangleMazeGeneration(i_id_row, i_id_n);
      //println("Triangular maze generation done");
    }
    
    if(type == 2)
    {
      //ignoring rows
      int n_side = cols;
      float x = sqrt((2*hex_apothem)*(2*hex_apothem)-(hex_apothem)*(hex_apothem));
      
      float psx = width/2;
      float psy = height/2;
      int current_row = 0;
      int current_id = 0;
      int ring = 0;
      int ring_v = 0;
      boolean destra = false;
      int mov = 0;
      
      int tot_hex = 1;
      for(int i=1; i<n_side; i++)
        tot_hex += 6*i;
      
      //Calculation of the cells position for the squared maze
      for(int i=0; i<tot_hex; i++)
      {
        cells.add(new C_Hexagon(int(psx), int(psy), current_row, current_id));
        
        if(current_row == -current_id && i == ring_v)
        {
          current_id += 2;
          psx += 2*hex_apothem;
          ring ++;
          ring_v += ring*6;
          mov = 1;
          
          if(ring == n_side)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).ul_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).ur_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).r_cell = the_void;
          }
        }
        else if(current_id == ring*2)
        {
          current_id -= 1;
          current_row += 1;
          psx -= hex_apothem;
          psy += x;
          destra = false;
          mov = 2;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).ur_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).r_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dr_cell = the_void;
          }
        }
        else if(current_id == -ring*2)
        {
          current_id += 1;
          current_row -= 1;
          psx += hex_apothem;
          psy -= x;
          destra = true;
          mov = 4;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).ul_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).l_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dl_cell = the_void;
          }
        }
        else if(!destra && current_id == -current_row)
        {
          current_id -= 1;
          current_row -= 1;
          psx -= hex_apothem;
          psy -= x;
          mov = 3;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).l_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dl_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dr_cell = the_void;
          }
        }
        else if(destra && current_id == current_row)
        {
          current_id += 2;
          psx += 2*hex_apothem;
          mov = 0;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).l_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).ul_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).ur_cell = the_void;
          }
        }
        else if(!destra && current_id == current_row)
        {
          current_id -= 2;
          psx -= 2*hex_apothem;
          mov = 0;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).r_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dr_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dl_cell = the_void;
          }
        }
        else if(mov == 1)
        {
          current_id += 1;
          current_row += 1;
          psx += hex_apothem;
          psy += x;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).ur_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).r_cell = the_void;
          }
        }
        else if(mov == 2)
        {
          current_id -= 1;
          current_row += 1;
          psx -= hex_apothem;
          psy += x;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).r_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dr_cell = the_void;
          }
        }
        else if(mov == 3)
        {
          current_id -= 1;
          current_row -= 1;
          psx -= hex_apothem;
          psy -= x;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).dl_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).l_cell = the_void;
          }
        }
        else if(mov == 4)
        {
          current_id += 1;
          current_row -= 1;
          psx += hex_apothem;
          psy -= x;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).ul_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).l_cell = the_void;
          }
        }
        else if(destra)
        {
          current_id += 2;
          psx += 2*hex_apothem;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).ur_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).ul_cell = the_void;
          }
        }
        else if(!destra)
        {
          current_id -= 2;
          psx -= 2*hex_apothem;
          
          if(ring == n_side-1)
          {
            ((C_Hexagon)cells.get(cells.size()-1)).dr_cell = the_void;
            ((C_Hexagon)cells.get(cells.size()-1)).dl_cell = the_void;
          }
        }
      }
      
      //Linking each cell with the neighbours
      for(int i=0; i<cells.size(); i++)
      {
        C_Hexagon c = (C_Hexagon)cells.get(i);
        
        if(c.ur_cell == null)
          c.ur_cell = getHCell(c.id_row-1, c.id_n+1);
        if(c.ul_cell == null)
          c.ul_cell = getHCell(c.id_row-1, c.id_n-1);
        if(c.l_cell == null)
          c.l_cell = getHCell(c.id_row, c.id_n-2);
        if(c.r_cell == null)
          c.r_cell = getHCell(c.id_row, c.id_n+2);
        if(c.dr_cell == null)
          c.dr_cell = getHCell(c.id_row+1, c.id_n+1);
        if(c.dl_cell == null)
          c.dl_cell = getHCell(c.id_row+1, c.id_n-1);
      }
      
      int i = int(random(0, cells.size()));
      int i_id_row = ((C_Hexagon)cells.get(i)).id_row;
      int i_id_n = ((C_Hexagon)cells.get(i)).id_n;
        
      getHCell(-n_side+1, n_side%2 == 0 ? 1 : 0).start = true;
      getHCell(n_side-1, n_side%2 == 0 ? -1 : 0).end = true;
      
      //println("ID_ROW: "+i_id_row);
      //println("ID_N: "+i_id_n);
      hexagonMazeGeneration(i_id_row, i_id_n);
      //println("Hexagonal maze generation done");
    }
  }
  
  void display()
  {
    for(Cell c: cells)
      c.display();
    
    noFill();
    stroke(200, 0, 0);
    beginShape();
    for(PVector p: sol_points)
      vertex(p.x, p.y);
    endShape();
  }
  
  void squareMazeGeneration(int sx, int sy)
  {
    C_Square c = (C_Square)getCellByPosition(sx, sy);
    c.check = true;
    
    do{
      int r = int(random(0, 4));
      if(r == 0 && c.u_cell.check == false)
      {
        squareMazeGeneration(sx, sy-square_size);
        c.u_border = false;
        ((C_Square)getCellByPosition(sx, sy-square_size)).d_border = false;
      }
      if(r == 1 && c.d_cell.check == false)
      {
        squareMazeGeneration(sx, sy+square_size);
        c.d_border = false;
        ((C_Square)getCellByPosition(sx, sy+square_size)).u_border = false;
      }
      if(r == 2 && c.l_cell.check == false)
      {
        squareMazeGeneration(sx-square_size, sy);
        c.l_border = false;
        ((C_Square)getCellByPosition(sx-square_size, sy)).r_border = false;
      }
      if(r == 3 && c.r_cell.check == false)
      {
        squareMazeGeneration(sx+square_size, sy);
        c.r_border = false;
        ((C_Square)getCellByPosition(sx+square_size, sy)).l_border = false;
      }
    }while(c.d_cell.check == false || c.u_cell.check == false || c.l_cell.check == false || c.r_cell.check == false);      
  }
  
  void triangleMazeGeneration(int id_row, int id_n)
  {
    C_Triangle c = getTCell(id_row, id_n);
    c.check = true;
    
    do{
      int r = int(random(0, 3));
      if(r == 0 && c.h_cell.check == false)
      {
        if(c.upside_down)
        {
          triangleMazeGeneration(c.id_row-1, c.id_n-1);
          getTCell(c.id_row-1, c.id_n-1).h_border = false;
        }
        else
        {
          triangleMazeGeneration(c.id_row+1, c.id_n+1);
          getTCell(c.id_row+1, c.id_n+1).h_border = false;
        }
        c.h_border = false;
      }
      if(r == 1 && c.l_cell.check == false)
      {
        triangleMazeGeneration(c.id_row, c.id_n-1);
        c.l_border = false;
        getTCell(c.id_row, c.id_n-1).r_border = false;
      }
      if(r == 2 && c.r_cell.check == false)
      {
        triangleMazeGeneration(c.id_row, c.id_n+1);
        c.r_border = false;
        getTCell(c.id_row, c.id_n+1).l_border = false;
      }
    }while(c.h_cell.check == false || c.l_cell.check == false || c.r_cell.check == false);      
  }
  
  void hexagonMazeGeneration(int id_row, int id_n)
  {
    C_Hexagon c = getHCell(id_row, id_n);
    c.check = true;
    
    do{
      int r = int(random(0, 6));
      if(r == 0 && c.ur_cell.check == false)
      {
        hexagonMazeGeneration(c.id_row-1, c.id_n+1);
        c.ur_border = false;
        getHCell(c.id_row-1, c.id_n+1).dl_border = false;
      }
      if(r == 1 && c.ul_cell.check == false)
      {
        hexagonMazeGeneration(c.id_row-1, c.id_n-1);
        c.ul_border = false;
        getHCell(c.id_row-1, c.id_n-1).dr_border = false;
      }
      if(r == 2 && c.l_cell.check == false)
      {
        hexagonMazeGeneration(c.id_row, c.id_n-2);
        c.l_border = false;
        getHCell(c.id_row, c.id_n-2).r_border = false;
      }
      if(r == 3 && c.r_cell.check == false)
      {
        hexagonMazeGeneration(c.id_row, c.id_n+2);
        c.r_border = false;
        getHCell(c.id_row, c.id_n+2).l_border = false;
      }
      if(r == 4 && c.dr_cell.check == false)
      {
        hexagonMazeGeneration(c.id_row+1, c.id_n+1);
        c.dr_border = false;
        getHCell(c.id_row+1, c.id_n+1).ul_border = false;
      }
      if(r == 5 && c.dl_cell.check == false)
      {
        hexagonMazeGeneration(c.id_row+1, c.id_n-1);
        c.dl_border = false;
        getHCell(c.id_row+1, c.id_n-1).ur_border = false;
      }
    }while(c.ur_cell.check == false || c.ul_cell.check == false || c.l_cell.check == false || c.r_cell.check == false || c.dr_cell.check == false || c.dl_cell.check == false);      
  }
  
  Cell getCellByPosition(int x, int y)
  {
    for(int i=0; i<cells.size(); i++)
      if(cells.get(i).x == x && cells.get(i).y == y)
        return cells.get(i);
    
    println("Richiesta cella inesistente: ["+x+", "+y+"]");
    return null;
  }
  
  C_Triangle getTCell(int id_row, int id_n)
  {
    for(int i=0; i<cells.size(); i++)
      if(((C_Triangle)(cells.get(i))).id_row == id_row && ((C_Triangle)(cells.get(i))).id_n == id_n)
        return (C_Triangle)cells.get(i);
    
    println("Richiesta cella inesistente: ["+id_row+", "+id_n+"]");
    return null;
  }
  
  C_Hexagon getHCell(int id_row, int id_n)
  {
    for(int i=0; i<cells.size(); i++)
      if(((C_Hexagon)(cells.get(i))).id_row == id_row && ((C_Hexagon)(cells.get(i))).id_n == id_n)
        return (C_Hexagon)cells.get(i);
    
    println("Richiesta cella inesistente: ["+id_row+", "+id_n+"]");
    return null;
  }
  
  boolean solved = false;
  void solveMaze()
  {
    if(!solved)
    {
      solved = true;
      Cell c = null;
      for(int i=0; i<cells.size(); i++)
        if(cells.get(i).start)
          c = cells.get(i);
       
      if(type == 0)
        solveSquareMaze((C_Square)c);
      if(type == 1)
        solveTriangularMaze((C_Triangle)c);
      if(type == 2)
        solveHexagonalMaze((C_Hexagon)c);
      
      if(type != 1)
        println("Solved -> "+sol_points.size()+" steps long solution");
      else
        println("Solved -> "+(sol_points.size()*2-1)+" steps long solution");
    }
  }
  
  boolean solveSquareMaze(C_Square c)
  {
    c.sol_check = true;
    
    if(c.end)
    {
      sol_points.add(new PVector(c.x, c.y));
      return true;
    }
    
    if(!c.u_cell.sol_check && !c.u_border)
      if(solveSquareMaze((C_Square)c.u_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.d_cell.sol_check && !c.d_border) 
      if(solveSquareMaze((C_Square)c.d_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.l_cell.sol_check && !c.l_border)
      if(solveSquareMaze((C_Square)c.l_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.r_cell.sol_check && !c.r_border)
      if(solveSquareMaze((C_Square)c.r_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
      
    return false;
  }
  
  boolean solveTriangularMaze(C_Triangle c)
  {
    c.sol_check = true;
    
    if(c.end)
    {
      sol_points.add(new PVector(c.x, c.y));
      return true;
    }
    
    if(!c.h_cell.sol_check && !c.h_border)
      if(solveTriangularMaze((C_Triangle)c.h_cell))
      {
        if(!c.upside_down)
          sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.l_cell.sol_check && !c.l_border)
      if(solveTriangularMaze((C_Triangle)c.l_cell))
      {
        if(!c.upside_down)
          sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.r_cell.sol_check && !c.r_border)
      if(solveTriangularMaze((C_Triangle)c.r_cell))
      {
        if(!c.upside_down)
          sol_points.add(new PVector(c.x, c.y));
        return true;
      }
      
    return false;
  }
  
  boolean solveHexagonalMaze(C_Hexagon c)
  {
    c.sol_check = true;
    
    if(c.end)
    {
      sol_points.add(new PVector(c.x, c.y));
      return true;
    }
    
    if(!c.ur_cell.sol_check && !c.ur_border)
      if(solveHexagonalMaze((C_Hexagon)c.ur_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.ul_cell.sol_check && !c.ul_border)
      if(solveHexagonalMaze((C_Hexagon)c.ul_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.l_cell.sol_check && !c.l_border)
      if(solveHexagonalMaze((C_Hexagon)c.l_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.r_cell.sol_check && !c.r_border)
      if(solveHexagonalMaze((C_Hexagon)c.r_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.dr_cell.sol_check && !c.dr_border)
      if(solveHexagonalMaze((C_Hexagon)c.dr_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
    if(!c.dl_cell.sol_check && !c.dl_border)
      if(solveHexagonalMaze((C_Hexagon)c.dl_cell))
      {
        sol_points.add(new PVector(c.x, c.y));
        return true;
      }
      
    return false;
  }
}
