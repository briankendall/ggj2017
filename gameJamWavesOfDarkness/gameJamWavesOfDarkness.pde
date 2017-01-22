
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
  Test2 test = new Test2();
  test.printSomething(dataPath(""));
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