import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class p004_TsumiYaku extends PApplet {

public void setup() {

}

public void draw() {

}
public enum b_type {
  DESERT, PLAINS, MOUNTAIN, FOREST 
};

class Biome {
  private final float scale = 1.5f;
  float str;
  b_type type;
  
  
  
}
class Coordinate {
  int x;
  int y;
  
  public Coordinate(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "p004_TsumiYaku" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
