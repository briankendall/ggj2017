import java.util.ArrayList;

/*
The Item class provides the foundation for each entity that
can exist in the world
*/
public abstract class Item
{
  //The Item has several general properties
  //Location in the tilemap
  protected int x;
  protected int y;
  //Notes whether object can move
  protected boolean moveable;
  //Notes whether object is visible
  protected boolean visible;
  //Notes direction in which object is facing
  protected int direction;
  
  //Constructor - must be called via super() in subclasses
  /*Parameters:
      (int) locX = x-coordinate in tilemap
      (int) locY = y-coordinate in tilemap
      (boolean) canMove = whether or not item can move
      (boolean) canSee = whether or not item is visible
      (int) dir = direction object faces
    Returns:
      -------
  */
  public Item(int locX, int locY, boolean canMove, boolean canSee, int dir)
  {
    x = locX;
    y = locY;
    moveable = canMove;
    visible = canSee;
    direction = dir;
  }
}