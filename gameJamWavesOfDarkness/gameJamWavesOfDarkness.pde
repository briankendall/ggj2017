/*gameJamWavesOfDarkness.pde

Produced by: Richard (Rick) G. Freedman
             Brian Kendall
             Patrick (Pat) King
             Allison (Alley) ...

Game produced for GameJam 2017 at the University of 
Massachusetts Amherst site
*/


//Use to toggle debug mode
final boolean DEBUG = true;

//Some variable constants
final int SCREEN_HEIGHT = 1200;
final int SCREEN_WIDTH = 1200;

//Initializes everything
/*Paremeters:
    -------
  Returns:
    (void)
*/
void setup()
{
  //Set the screen size, and note 2D
  size(1200, 1200, P2D);
  
  if(DEBUG)
  {
    Level testLevel = new Level(fullFilepath(dataPath(""), "sewers.tmx"));
  }
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
  
  //Set the pen color fill to white
  fill(255, 255, 255);
  //Set the pen outline color to red
  stroke(255, 0, 0);
  //Draw a line and rectangle
  line(34, 50, 200, 1000);
  rect(800, 300, 100, 358);
  
  //Draw an image from a file (stored in data)
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