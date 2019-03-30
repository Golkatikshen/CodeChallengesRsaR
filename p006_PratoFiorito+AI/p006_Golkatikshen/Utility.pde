
float Width = 800;
float Height = 600;
float my_leading;

boolean input_ready;
String input_type = "";
String input = "";
String str_exe;
int millis;


boolean isEven(int v)
{
  if (v % 2 == 0)
    return true;
  else
    return false;
}

int Int(String s)
{
  return Integer.parseInt(s);
}

String StrI(int v)
{
  return String.valueOf(v);
}

String StrD(double v)
{
  return String.valueOf(v);
}


float rele(float v, String mod)
{
  float perc;
  float new_val;

  if (mod.equals("h"))
  {
    perc = v * 100 / Width;
    new_val = perc * width / 100;
  } 
  else
  {
    perc = v * 100 / Height;
    new_val = perc * height / 100;
  }

  return new_val;
}


int textHeight(String str, int specificWidth) 
{
  float leading = my_leading;
  // split by new lines first
  String[] paragraphs = split(str, "\n");
  int numberEmptyLines = 0;
  int numTextLines = 0;
  for (int i=0; i < paragraphs.length; i++) 
  {
    // anything with length 0 ignore and increment empty line count
    if (paragraphs[i].length() == 0) {
      numberEmptyLines++;
    } else
    {      
      numTextLines++;
      // word wrap
      String[] wordsArray = split(paragraphs[i], " ");
      String tempString = "";

      for (int k=0; k < wordsArray.length; k++)
      {
        if (textWidth(tempString + wordsArray[k]) < specificWidth)
          tempString += wordsArray[k] + " ";
        else 
        {
          tempString = wordsArray[k] + " ";
          numTextLines++;
        }
      }
    }
  }

  float totalLines = numTextLines + numberEmptyLines;
  return round(totalLines * leading);
}
