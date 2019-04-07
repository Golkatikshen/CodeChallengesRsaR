static final int N = 12;
static final int M = 12;

Cell field[][] = new Cell[N][M];
boolean lost = false;
int nMines;

void setup(){
  size(600, 600);
  background(0);

  for(int i = 0; i < N; i++)
    for(int j = 0; j < M; j++){
        field[i][j] = new Cell('n', false, i, j);
    }
    field[3][5].surroundingMines = 1;
}

void draw(){
  for(int i = 0; i < N; i++)
    for(int j = 0; j < M; j++)
      field[i][j].display();
}

void mousePressed(){
  for(int i = 0; i < N; i++)
    for(int j = 0; j < M; j++)
      if(mouseX>field[i][j].x && mouseX<field[i][j].x+Cell.dim && mouseY>field[i][j].y && mouseY<field[i][j].y+Cell.dim)
        selectCell(i, j);
}

void selectCell(int x, int y){
  if(field[x][y].type != 'p'){
    if(field[x][y].mine)
      field[x][y].type = 'm'; 
    else
      field[x][y].type = 'p';
  }

  if(x+1 < N && field[x+1][y].type == 'n' && !field[x+1][y].mine && field[x+1][y].surroundingMines == 0)
    selectCell(x+1, y);
  if(x-1 >= 0 && field[x-1][y].type == 'n' && !field[x-1][y].mine && field[x-1][y].surroundingMines == 0)
    selectCell(x-1, y);
  if(x+1 < N && y+1 < M && field[x+1][y+1].type == 'n' && !field[x+1][y+1].mine && field[x+1][y+1].surroundingMines == 0)
    selectCell(x+1, y+1);
  if(x+1 < N && y-1 >= 0 && field[x+1][y-1].type == 'n' && !field[x+1][y-1].mine && field[x+1][y-1].surroundingMines == 0)
    selectCell(x+1, y-1);
  if(y+1 < M && field[x][y+1].type == 'n' && !field[x][y+1].mine && field[x][y+1].surroundingMines == 0)
    selectCell(x, y+1);
  if(y-1 >= 0 && field[x][y-1].type == 'n' && !field[x][y-1].mine && field[x][y-1].surroundingMines == 0)
    selectCell(x, y-1);
  if(x-1 >= 0 && y+1 < M && field[x-1][y+1].type == 'n' && !field[x-1][y+1].mine && field[x-1][y+1].surroundingMines == 0)
    selectCell(x-1, y+1);
  if(x-1 >= 0 && y-1 >= 0 && field[x-1][y-1].type == 'n' && !field[x-1][y-1].mine && field[x-1][y-1].surroundingMines == 0)
    selectCell(x-1, y-1);
}
