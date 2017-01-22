/*
The Entity class provides the physical being that exists
in the world in addition to its location, etc.
*/
public class Entity
{
  //The Item of which this Entity is an instantiation
  protected Item blueprint;
  
  //The position in the map
  protected int x;
  protected int y;
  //Notes whether object is visible
  protected boolean visible;
  
  //Requirements for activation
  boolean[] validTriggers;
  //Requirements for revealing
  boolean[] validRevealers;
  
  //Current exposures (for activation/revelation)
  boolean[] curExposure;
  
  //The trigger that this entity emits, if any
  int emit;
  
  //Constructor
  /*Parameters:
      (Item) bp = Blueprint/item of which this entity instantiates
      (int) posX = x-coordinate in map
      (int) posY = y-coordinate in map
    Returns:
      -------
  */
  public Entity(Item bp, int posX, int posY)
  {
    blueprint = bp;
    x = posX;
    y = posY;
    
    //Default to invisible
    visible = false;
    
    //These default to 0's (for no triggers/revealers/exposure)
    validTriggers = new boolean[TOTAL_INTERACTIONS];
    validRevealers = new boolean[TOTAL_INTERACTIONS];
    curExposure = new boolean[TOTAL_INTERACTIONS];
  }
  
  //Accessor methods - BEGIN
  public int getX() {return x;}
  public int getY() {return y;}
  public boolean getVisible() {return visible;}
  public boolean[] getTriggers() {return validTriggers;}
  public boolean[] getRevealers() {return validRevealers;}
  public boolean[] getExposures() {return curExposure;}
  public int getEmit() {return emit;}
  //Special accessor method to get the Sprite from the blueprint
  public PImage getSprite() {return blueprint.getSprite();}
  //Accessor methods - END
  
  //Mutator methods - BEGIN
  public void setX(int newX) {x = newX;}
  public void setY(int newY) {y = newY;}
  public void makeVisible(boolean v) {visible = v;}
  public void addTrigger(int t) {validTriggers[t] = true;}
  public void removeTrigger(int t) {validTriggers[t] = false;}
  public void addRevealer(int t) {validRevealers[t] = true;}
  public void removeRevealer(int t) {validRevealers[t] = false;}
  public void addExposure(int t) {curExposure[t] = true;}
  public void removeExposure(int t) {curExposure[t] = false;}
  public void setEmit(int e) {emit = e;}
  //Mutator methods - END
}