/*gameJamWavesOfDarkness.pde

Produced by: Richard (Rick) G. Freedman
             Allison (Alley) Herrera
             Brian Kendall
             Patrick (Pat) King

Game produced for GameJam 2017 at the University of 
Massachusetts Amherst site
*/

import java.util.HashMap;

//Use to toggle debug mode
final boolean DEBUG = true;

//Some variable constants
final int SCREEN_HEIGHT = 1200;
final int SCREEN_WIDTH = 1200;

//Special constant for no tile to draw
final int NO_TILE = -1;

//Special constants for direction and mobility
final boolean MOVEABLE = true;
final boolean NOT_MOVEABLE = false;
final int NO_DIRECTION = -1;
final int UP_DIRECTION = 0;
final int RIGHT_DIRECTION = 1;
final int DOWN_DIRECTION = 2;
final int LEFT_DIRECTION = 3;

//The current level being played
Level curLevel = null;

//The tileset association (tile ID -> filepath)
HashMap<Integer, String> tileset;

//The items that may appear
HashMap<Integer, Item> itemset;

//Constants for forms of interation
final int PLAYER_INTERACT = 0;
final int LIGHT_RED = 1;
final int LIGHT_GREEN = 2;
final int LIGHT_BLUE = 3;
final int LIGHT_YELLOW = 4;
final int LIGHT_CYAN = 5;
final int LIGHT_MAGENTA = 6;
final int LIGHT_WHITE = 7;
final int SOUND_RED = 8;
final int SOUND_ORANGE = 9;
final int SOUND_YELLOW = 10;
final int SOUND_GREEN = 11;
final int SOUND_CYAN = 12;
final int SOUND_BLUE = 13;
final int SOUND_PURPLE = 14;
final int TOTAL_INTERACTIONS = 15;

//Initializes everything
/*Paremeters:
    -------
  Returns:
    (void)
*/

BackgroundRenderer cloudBackground;

void setup()
{
  //Set the screen size, and note 2D
  size(1024, 768, P2D);
  cloudBackground = new BackgroundRenderer();
  cloudBackground.setup();
  getSparkleRenderer().setup();
  getSparkleRenderer().createSparkles(100, 100, 64, 64, color(255, 0, 0), 1.0);
  
  //Fill in the tileset
  tileset = new HashMap();
  itemset = new HashMap();

  tileset.put(0, "sprites/exit-temp.png");
  itemset.put(0, new ExitItem(tileset.get(0), NOT_MOVEABLE, NO_DIRECTION));
  
  tileset.put(1, "sprites/instrument-moveable-temp.png");
  itemset.put(1, new InstrumentItem(tileset.get(1), MOVEABLE, NO_DIRECTION));
  
  tileset.put(2, "sprites/instrument-static-temp.png");
  itemset.put(2, new InstrumentItem(tileset.get(2), NOT_MOVEABLE, NO_DIRECTION));
  
  tileset.put(3, "sprites/light-down-moveable-temp.png");
  itemset.put(3, new LightItem(tileset.get(3), MOVEABLE, DOWN_DIRECTION));
  
  tileset.put(4, "sprites/light-down-static-temp.png");
  itemset.put(4, new LightItem(tileset.get(4), NOT_MOVEABLE, DOWN_DIRECTION));
  
  tileset.put(5, "sprites/light-left-moveable-temp.png");
  itemset.put(5, new LightItem(tileset.get(5), MOVEABLE, LEFT_DIRECTION));
  
  tileset.put(6, "sprites/light-left-static-temp.png");
  itemset.put(6, new LightItem(tileset.get(6), NOT_MOVEABLE, LEFT_DIRECTION));
  
  tileset.put(7, "sprites/light-right-moveable-temp.png");
  itemset.put(7, new LightItem(tileset.get(7), MOVEABLE, RIGHT_DIRECTION));
  
  tileset.put(8, "sprites/light-right-static-temp.png");
  itemset.put(8, new LightItem(tileset.get(8), NOT_MOVEABLE, RIGHT_DIRECTION));
  
  tileset.put(9, "sprites/light-up-moveable-temp.png");
  itemset.put(9, new LightItem(tileset.get(9), MOVEABLE, UP_DIRECTION));
  
  tileset.put(10, "sprites/light-up-static-temp.png");
  itemset.put(10, new LightItem(tileset.get(10), NOT_MOVEABLE, UP_DIRECTION));
  
  tileset.put(11, "sprites/player-start-temp.png");
  itemset.put(11, new PlayerItem(tileset.get(11), MOVEABLE, NO_DIRECTION));
  
  if(DEBUG)
  {
    Level testLevel = new Level(fullFilepath(dataPath(""), "example.tmx"));
  }
  curLevel = new Level(fullFilepath(dataPath(""), "example.tmx"));
}

//The loop for screen rendering
/*Parameters:
    -------
  Returns:
    (void)
*/

void draw()
{
  //Clear the screen
  clear();
  //Set the background color (black)
  background(0, 0, 0);
  cloudBackground.draw();
  
  //background(0, 0, 0);
  //background(255,255,255);
  
  //Render the current level
  pushMatrix();
  
  PImage[][] levelImg = getSpriteLayout(curLevel.getEntityMap());
  
  for(int row = 0; row < levelImg.length; row++)
  {
    for(int col = 0; col < levelImg[row].length; col++)
    {
      if(levelImg[row][col] != null)
      {
        if(DEBUG)
        {
          //print("Drawing image at [" + row + ", " + col + "]\n");
        }
        image(levelImg[row][col], col * levelImg[row][col].width, row * levelImg[row][col].height);
      }
    }
  }
  
  popMatrix();
  
  getSparkleRenderer().draw();
}

//Convenient function for getting a full filepath name
//  independent of Operating System
/*Parameters:
    (String) prefixPath = prefix for filepath
    (String) suffixPath = suffix for filepath
  Returns:
    (String) = full filepath joining prefix and suffix
*/
public String fullFilepath(String prefixPath, String suffixPath)
{
  File file1 = new File(prefixPath);
  File file2 = new File(file1, suffixPath);
  return file2.getPath();
}

//Obtain the sprite to display for each item in the level
/*Parameters:
    (Entity[][]) entityMap = map of entities to display
  Returns:
    (PImage[][]) = map of images to display, null if nothing 
*/
public PImage[][] getSpriteLayout(Entity[][] entityMap)
{
  PImage[][] toRender = new PImage[entityMap.length][entityMap[0].length];
  
  for(int row = 0; row < entityMap.length; row++)
  {
    for(int col = 0; col < entityMap[row].length; col++)
    {
      toRender[row][col] = ((entityMap[row][col] == null) || (!entityMap[row][col].getVisible())) ? null:entityMap[row][col].getSprite();
    }
  }
  
  return toRender;
}