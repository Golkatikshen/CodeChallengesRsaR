
static enum HEADING {UP, DOWN, RIGHT, LEFT, STOP};

void destroyFoodIn(int x, int y)
{
  for(int i=0; i<food.size(); i++)
    if(food.get(i).cx == x && food.get(i).cy == y)
    {
      food.remove(i);
      i--;
    }
}
