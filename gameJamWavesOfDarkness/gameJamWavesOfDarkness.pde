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
import processing.sound.*;

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
//For player animation
int renderFrame;
int playerFrame;

//The tileset association (tile ID -> filepath)
HashMap<Integer, String> tileset;

//The items that may appear
HashMap<Integer, Item> itemset;

//Constants for forms of interation
final int LIGHT_NONE = 0;
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
final int PLAYER_INTERACT = 15;
final int TOTAL_INTERACTIONS = 16;
final int TOTAL_LIGHT = 8;
final int TOTAL_SOUND = 7;
final int SOUND_NONE = 16;
final int SOUND_START = 8;
final int SOUND_END = 14;

//Initializes everything
/*Paremeters:
    -------
  Returns:
    (void)
*/

BackgroundRenderer cloudBackground;

SoundFile backgroundAudio;
SoundFile pushAudio;

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

  //tileset.put(0, "sprites/exit-temp.png");
  tileset.put(0, "sprites/TTeam/ExitWell.png");
  itemset.put(0, new ExitItem(tileset.get(0), NOT_MOVEABLE, NO_DIRECTION));
  
  //tileset.put(1, "sprites/instrument-moveable-temp.png");
  tileset.put(1, "sprites/TTeam/AudioCube.png");
  itemset.put(1, new InstrumentItem(tileset.get(1), MOVEABLE, NO_DIRECTION));
  
  //tileset.put(2, "sprites/instrument-static-temp.png");
  tileset.put(2, "sprites/TTeam/AudioCube.png");
  itemset.put(2, new InstrumentItem(tileset.get(2), NOT_MOVEABLE, NO_DIRECTION));
  
  //tileset.put(3, "sprites/light-down-moveable-temp.png");
  tileset.put(3, "sprites/TTeam/LightOrb.png");
  itemset.put(3, new LightItem(tileset.get(3), MOVEABLE, DOWN_DIRECTION));
  
  //tileset.put(4, "sprites/light-down-static-temp.png");
  tileset.put(4, "sprites/TTeam/LightOrb.png");
  itemset.put(4, new LightItem(tileset.get(4), NOT_MOVEABLE, DOWN_DIRECTION));
  
  //tileset.put(5, "sprites/light-left-moveable-temp.png");
  tileset.put(5, "sprites/TTeam/LightOrb.png");
  itemset.put(5, new LightItem(tileset.get(5), MOVEABLE, LEFT_DIRECTION));
  
  //tileset.put(6, "sprites/light-left-static-temp.png");
  tileset.put(6, "sprites/TTeam/LightOrb.png");
  itemset.put(6, new LightItem(tileset.get(6), NOT_MOVEABLE, LEFT_DIRECTION));
  
  //tileset.put(7, "sprites/light-right-moveable-temp.png");
  tileset.put(7, "sprites/TTeam/LightOrb.png");
  itemset.put(7, new LightItem(tileset.get(7), MOVEABLE, RIGHT_DIRECTION));
  
  //tileset.put(8, "sprites/light-right-static-temp.png");
  tileset.put(8, "sprites/TTeam/LightOrb.png");
  itemset.put(8, new LightItem(tileset.get(8), NOT_MOVEABLE, RIGHT_DIRECTION));
  
  //tileset.put(9, "sprites/light-up-moveable-temp.png");
  tileset.put(9, "sprites/TTeam/LightOrb.png");
  itemset.put(9, new LightItem(tileset.get(9), MOVEABLE, UP_DIRECTION));
  
  //tileset.put(10, "sprites/light-up-static-temp.png");
  tileset.put(10, "sprites/TTeam/LightOrb.png");
  itemset.put(10, new LightItem(tileset.get(10), NOT_MOVEABLE, UP_DIRECTION));
  
  //tileset.put(11, "sprites/player-start-temp.png");
  tileset.put(11, "sprites/TTeam/Forward.png");
  itemset.put(11, new PlayerItem(tileset.get(11), MOVEABLE, NO_DIRECTION));
  
  tileset.put(12, "sprites/TTeam/ForwardFlicker1.png");
  itemset.put(12, new PlayerItem(tileset.get(12), MOVEABLE, NO_DIRECTION));
  tileset.put(13, "sprites/TTeam/ForwardFlicker2.png");
  itemset.put(13, new PlayerItem(tileset.get(13), MOVEABLE, NO_DIRECTION));
  tileset.put(14, "sprites/TTeam/ForwardFlicker3.png");
  itemset.put(14, new PlayerItem(tileset.get(14), MOVEABLE, NO_DIRECTION));
  
  if(DEBUG)
  {
    Level testLevel = new Level(fullFilepath(dataPath(""), "example.tmx"));
  }
  curLevel = new Level(fullFilepath(dataPath(""), "example.tmx"));
  curPlayer = curLevel.getPlayer();
  
  getLightManager().setup(curLevel);
  //getLightManager().createLight(6, 7, RIGHT_DIRECTION, LIGHT_RED);
  //getLightManager().createLight(8, 4, DOWN_DIRECTION, LIGHT_BLUE);
  //getLightManager().createLight(14, 10, LEFT_DIRECTION, LIGHT_GREEN);
  
  //This makes the flaming character animation
  renderFrame = 0;
  playerFrame = 0;
  
  backgroundAudio = new SoundFile(this, "sounds/waves_atmosphere_loop.wav");
  backgroundAudio.loop();
  
  pushAudio = new SoundFile(this, "sounds/game_sfx/game_object_push_01.wav");
}

//The loop for screen rendering
/*Parameters:
    -------
  Returns:
    (void)
*/

int time = 0;

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
  renderFrame++;
  if(renderFrame % 3 == 0)
  {
    playerFrame++;
  }
  PImage playerSprite = itemset.get(11 + (playerFrame % 4)).getSprite();
  image(playerSprite, curPlayer.getX() * playerSprite.width, curPlayer.getY() * playerSprite.height);

  popMatrix();
  
  ++time;
  /*
  if (time == 30) {
    getLightManager().createLight(3, 5, RIGHT_DIRECTION, LIGHT_GREEN);
  } else if (time == 60) {
    getLightManager().createLight(8, 4, DOWN_DIRECTION, LIGHT_BLUE);
  } else if (time == 90) {
    getLightManager().createLight(14, 10, LEFT_DIRECTION, LIGHT_GREEN);
  }
  */
  getSparkleRenderer().draw();
  getRippleRenderer().draw();
  getLightManager().draw();
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
      ArrayList<Integer> rippleColors = new ArrayList<Integer>();
      Entity e = entityMap[row][col];
      toRender[row][col] = ((e == null) || (!e.getVisible())) ? null:e.getSprite();
      if(e == null) {continue;}
      //Determine which sparkles/ripples are needed for the entity (and not exposed yet)
      boolean[] trigg = e.getTriggers();
      boolean[] expos = e.getExposures();
      
      for(int thing = 0; thing < trigg.length; thing++)
      {
        if(trigg[thing] && !expos[thing])
        {
          if((thing < TOTAL_LIGHT) && (thing >= LIGHT_NONE))
          {
            if (e.getSparkleId() == 0) {
              int id = getSparkleRenderer().createSparkles(col * toRender[row][col].height,
                                                           row * toRender[row][col].width,
                                                           64, 64,
                                                           colorForLightColor(thing, 255), 1.0);
              e.setSparkleId(id);
            }
          }
          else if (thing >= SOUND_START && thing <= SOUND_END) {
            rippleColors.add(colorForSoundColor(thing, 255));
          }
        }
      }
      
      if (rippleColors.size() > 0 && e.getRippleId() == 0) {
        int id = getRippleRenderer().createRipples(int((col + 0.5) * toRender[row][col].height),
                                                   int((row + 0.5) * toRender[row][col].width),
                                                   100,
                                                   rippleColors);
        e.setRippleId(id);
      }
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
            pushAudio.play();
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
            pushAudio.play();
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
            pushAudio.play();
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
            pushAudio.play();
          }
        }
      }
      break;
    case KeyEvent.VK_SPACE:
      println("Space!");
      break;
    default:
  }
  
  //Update the player position (even if variables didn't change)
  curPlayer.setX(playerPosX);
  curPlayer.setY(playerPosY);
}