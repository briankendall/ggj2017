import java.util.ArrayList;

/*
The Item class provides the foundation for each entity that
can exist in the world
*/
public abstract class Item
{
  //The Item has several general properties
  //Notes whether object can move
  protected boolean moveable;
  //Notes direction in which object is facing
  protected int direction;
  //The Sprite assocaited with this item
  protected PImage sprite;
  
  //Constructor - must be called via super() in subclasses
  /*Parameters:
      (String) imageDirectory = path to image file
      (boolean) canMove = whether or not item can move
      (int) dir = direction object faces
    Returns:
      -------
  */
  public Item(String imageDirectory, boolean canMove, int dir)
  {
    sprite = loadImage(imageDirectory);
    moveable = canMove;
    direction = dir;
  }
  
  //When the item is activated, it alters the map from its 
  //  position
  /*Parameters:
      (Entity[][]) map = map of entities and their layout
      (int) x = x-position of this activated item
      (int) y = y-position of this activated item
  */
  public abstract void activate(Entity[][] map, int x, int y);
  
  //Accessor Methods - BEGIN
  public boolean getMoveable() {return moveable;}
  public int getDirection() {return direction;}
  public PImage getSprite() {return sprite;}
  //Accessor Methods - END
  
  //Mutator Methods - BEGIN
  public void setMoveable(boolean m) {moveable = m;}
  public void setDirection(int d) {direction = d;}
  //The sprite cannot be changed
  //Mutator Methods - END
}

//Concrete classes from Item

//The Exit Item triggers the completion of the level
public class ExitItem extends Item
{
  //Constructor - must be called via super() in subclasses
  /*Parameters:
      (String) imageDirectory = path to image file
      (boolean) canMove = whether or not item can move
      (int) dir = direction object faces
    Returns:
      -------
  */
  public ExitItem(String imageDirectory, boolean canMove, int dir)
  {
    super(imageDirectory, canMove, dir);
  }
  
  //When the item is activated, it alters the map from its 
  //  position
  /*Parameters:
      (Entity[][]) map = map of entities and their layout
      (int) x = x-position of this activated item
      (int) y = y-position of this activated item
  */
  public void activate(Entity[][] map, int x, int y)
  {
    //The door signals the end of the level when activated
  }
}

//The Instrument Item triggers sound across the level
public class InstrumentItem extends Item
{
  //Constructor - must be called via super() in subclasses
  /*Parameters:
      (String) imageDirectory = path to image file
      (boolean) canMove = whether or not item can move
      (int) dir = direction object faces
    Returns:
      -------
  */
  public InstrumentItem(String imageDirectory, boolean canMove, int dir)
  {
    super(imageDirectory, canMove, dir);
  }
  
  //When the item is activated, it alters the map from its 
  //  position
  /*Parameters:
      (Entity[][]) map = map of entities and their layout
      (int) x = x-position of this activated item
      (int) y = y-position of this activated item
  */
  public void activate(Entity[][] map, int x, int y)
  {
    //The instrument releases an omni-directional soundwave
    //NOTE: This entity can access its emission type using map[x][y].getEmit()
    int entityEmit = map[x][y].getEmit();
    //Propogate and play sound
  }
}

//The Light Item triggers light in one direction on the level
public class LightItem extends Item
{
  //Constructor - must be called via super() in subclasses
  /*Parameters:
      (String) imageDirectory = path to image file
      (boolean) canMove = whether or not item can move
      (int) dir = direction object faces
    Returns:
      -------
  */
  public LightItem(String imageDirectory, boolean canMove, int dir)
  {
    super(imageDirectory, canMove, dir);
  }
  
  //When the item is activated, it alters the map from its 
  //  position
  /*Parameters:
      (Entity[][]) map = map of entities and their layout
      (int) x = x-position of this activated item
      (int) y = y-position of this activated item
  */
  public void activate(Entity[][] map, int x, int y)
  {
    //The light releases a one-directional light beam
    //NOTE: This entity can access its emission type using map[x][y].getEmit()
    int entityEmit = map[x][y].getEmit();
    //Project and illuminate
  }
}

//The Player Item navigates the level
public class PlayerItem extends Item
{
  //Constructor - must be called via super() in subclasses
  /*Parameters:
      (String) imageDirectory = path to image file
      (boolean) canMove = whether or not item can move
      (int) dir = direction object faces
    Returns:
      -------
  */
  public PlayerItem(String imageDirectory, boolean canMove, int dir)
  {
    super(imageDirectory, canMove, dir);
  }
  
  //When the item is activated, it alters the map from its 
  //  position
  /*Parameters:
      (Entity[][]) map = map of entities and their layout
      (int) x = x-position of this activated item
      (int) y = y-position of this activated item
  */
  public void activate(Entity[][] map, int x, int y)
  {
    //The player does nothing if activated (shouldn't happen anyway)
  }
}