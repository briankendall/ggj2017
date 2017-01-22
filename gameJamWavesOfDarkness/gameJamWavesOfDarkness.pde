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
  
  //Set the pen color fill to white
  fill(255, 255, 255);
  //Set the pen outline color to red
  stroke(255, 0, 0);
  //Draw a line and rectangle
  line(34, 50, 200, 1000);
  rect(800, 300, 100, 358);
  
  //Draw an image from a file (stored in data)
  PImage myImg = loadImage("musicNote.png");
  image(myImg, 60, 90);
  image(myImg, 90, 150, 2 * myImg.width, 3 * myImg.height);
  //Tint future drawn images
  tint(255, 0, 0);
  image(myImg, 60, 200);
  //Remove the tint
  noTint();
  image(myImg, 60, 250);
  
}