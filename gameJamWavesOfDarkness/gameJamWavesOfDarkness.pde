/*gameJamWavesOfDarkness.pde

Produced by: Richard (Rick) G. Freedman
             Allison (Alley) Herrera
             Brian Kendall
             Patrick (Pat) King

Game produced for GameJam 2017 at the University of 
Massachusetts Amherst site
*/

import java.util.HashMap;
import java.awt.event.KeyEvent;

//Use to toggle debug mode
final boolean DEBUG = false;

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
//The player character
Entity curPlayer = null;

//The tileset association (tile ID -> filepath)
HashMap<Integer, String> tileset;

//The items that may appear
HashMap<Integer, Item> itemset;

//Constants for forms of interation
final int PLAYER_INTERACT = 14;
final int LIGHT_RED = 0;
final int LIGHT_GREEN = 2;
final int LIGHT_BLUE = 4;
final int LIGHT_YELLOW = 1;
final int LIGHT_CYAN = 3;
final int LIGHT_MAGENTA = 5;
final int LIGHT_WHITE = 6;
final int SOUND_RED = 7;
final int SOUND_ORANGE = 8;
final int SOUND_YELLOW = 9;
final int SOUND_GREEN = 10;
final int SOUND_CYAN = 11;
final int SOUND_BLUE = 12;
final int SOUND_PURPLE = 13;
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
  //getSparkleRenderer().createSparkles(100, 100, 64, 64, color(255, 0, 0), 1.0);
  
  getRippleRenderer().setup();
  //getRippleRenderer().createRipples(300, 300, 100, new color[]{color(0,255,0), color(0, 0, 255)});
  
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
  curPlayer = curLevel.getPlayer();
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
  
  //Render the current player (top-most layer)
  PImage playerSprite = curPlayer.getSprite();
  image(playerSprite, curPlayer.getX() * playerSprite.width, curPlayer.getY() * playerSprite.height);

  popMatrix();
  
  getSparkleRenderer().draw();
  getRippleRenderer().draw();
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
      /*for()
      {
        getSparkleRenderer().createSparkles(100, 100, 64, 64, color(255, 0, 0), 1.0);
      }*/
    }
  }
  
  return toRender;
}

//Processes keyboard input to move the character around
/*Parameters:
    -------
  Returns:
    (void)
*/
void keyPressed()
{
  //Get the player position and try candidate location from arrow key
  int playerPosX = curPlayer.getX();
  int playerPosY = curPlayer.getY();
  
  switch(keyCode)
  {
    case KeyEvent.VK_UP:
      //Make sure the location exists
      if(playerPosY > 0)
      {
        //If nothing is in the level at all, then move
        if((curLevel.getEntityMap())[playerPosY - 1][playerPosX] == null)
        {
          playerPosY--;
        }
        //Otherwise, make sure the location is valid (moveable object, not visible, etc.)
        else
        {
          Entity temp = (curLevel.getEntityMap())[playerPosY - 1][playerPosX];
          Entity beyondTemp = (playerPosY < 2) ? null:(curLevel.getEntityMap())[playerPosY - 2][playerPosX];
          if(!temp.getVisible())
          {
            playerPosY--;
          }
          //Moveable needs to make sure it is in bounds and not pushing against another visible entity
          else if(temp.getBlueprint().getMoveable() && (temp.getY() > 0) && ((beyondTemp == null) /*|| !beyondTemp.getVisible()*/))
          {
            playerPosY--;
            //Move the object as well
            (curLevel.getEntityMap())[temp.getY()][temp.getX()] = null;
            (curLevel.getEntityMap())[temp.getY() - 1][temp.getX()] = temp;
            temp.setY(temp.getY() - 1);
          }
        }
      }
      break;
    case KeyEvent.VK_DOWN:
      //Make sure the location exists
      if(playerPosY < (curLevel.getLevelHeight() - 1))
      {
        //If nothing is in the level at all, then move
        if((curLevel.getEntityMap())[playerPosY + 1][playerPosX] == null)
        {
          playerPosY++;
        }
        //Otherwise, make sure the location is valid (moveable object, not visible, etc.)
        else
        {
          Entity temp = (curLevel.getEntityMap())[playerPosY + 1][playerPosX];
          Entity beyondTemp = (playerPosY >= (curLevel.getLevelHeight() - 2)) ? null:(curLevel.getEntityMap())[playerPosY + 2][playerPosX];
          if(!temp.getVisible())
          {
            playerPosY++;
          }
          //Moveable needs to make sure it is in bounds and not pushing against another visible entity
          else if(temp.getBlueprint().getMoveable() && (temp.getY() < (curLevel.getLevelHeight() - 1)) && ((beyondTemp == null) /*|| !beyondTemp.getVisible()*/))
          {
            playerPosY++;
            //Move the object as well
            (curLevel.getEntityMap())[temp.getY()][temp.getX()] = null;
            (curLevel.getEntityMap())[temp.getY() + 1][temp.getX()] = temp;
            temp.setY(temp.getY() + 1);
          }
        }
      }
      break;
    case KeyEvent.VK_LEFT:
      //Make sure the location exists
      if(playerPosX > 0)
      {
        //If nothing is in the level at all, then move
        if((curLevel.getEntityMap())[playerPosY][playerPosX - 1] == null)
        {
          playerPosX--;
        }
        //Otherwise, make sure the location is valid (moveable object, not visible, etc.)
        else
        {
          Entity temp = (curLevel.getEntityMap())[playerPosY][playerPosX - 1];
          Entity beyondTemp = (playerPosX < 2) ? null:(curLevel.getEntityMap())[playerPosY][playerPosX - 2];
          if(!temp.getVisible())
          {
            playerPosX--;
          }
          //Moveable needs to make sure it is in bounds and not pushing against another visible entity
          else if(temp.getBlueprint().getMoveable() && (temp.getX() > 0) && ((beyondTemp == null) /*|| !beyondTemp.getVisible()*/))
          {
            playerPosX--;
            //Move the object as well
            (curLevel.getEntityMap())[temp.getY()][temp.getX()] = null;
            (curLevel.getEntityMap())[temp.getY()][temp.getX() - 1] = temp;
            temp.setX(temp.getX() - 1);
          }
        }
      }
      break;
    case KeyEvent.VK_RIGHT:
      //Make sure the location exists
      if(playerPosX < (curLevel.getLevelWidth() - 1))
      {
        //If nothing is in the level at all, then move
        if((curLevel.getEntityMap())[playerPosY][playerPosX + 1] == null)
        {
          playerPosX++;
        }
        //Otherwise, make sure the location is valid (moveable object, not visible, etc.)
        else
        {
          Entity temp = (curLevel.getEntityMap())[playerPosY][playerPosX + 1];
          Entity beyondTemp = (playerPosX >= (curLevel.getLevelWidth() - 2)) ? null:(curLevel.getEntityMap())[playerPosY][playerPosX + 2];
          if(!temp.getVisible())
          {
            playerPosX++;
          }
          //Moveable needs to make sure it is in bounds and not pushing against another visible entity
          else if(temp.getBlueprint().getMoveable() && (temp.getY() < (curLevel.getLevelWidth() - 1)) && ((beyondTemp == null)/* || !beyondTemp.getVisible()*/))
          {
            playerPosX++;
            //Move the object as well
            (curLevel.getEntityMap())[temp.getY()][temp.getX()] = null;
            (curLevel.getEntityMap())[temp.getY()][temp.getX() + 1] = temp;
            temp.setX(temp.getX() + 1);
          }
        }
      }
      break;
    default:
  }
  
  //Update the player position (even if variables didn't change)
  curPlayer.setX(playerPosX);
  curPlayer.setY(playerPosY);
}