// Level manager is responsible for displaying
// the title screen and screens between rounds.
// i am undecided if this needs to be a seperate class 
// or just part of the main draw loop.

class Level_Manager
{
  //Constants
  
  //Variables.
  PImage titleImg;
  //Level Manager Constructor
  Level_Manager()
  {
    //loads the title image.
    titleImg = loadImage("Title.png");
  }
  // called at the start of the game.
  boolean NewGame(boolean started)
  {
    // simply checks if the game has started
    // e.g has the player clicked the start button
    
    //TODO: this needs to be optimized, i think some parts can be removed
    // and it can be cleaned up, some values need to be made into variables.
    if(!started)
    {
      background(0);
      stroke(255);
      fill(255);
      image(titleImg, width / 2 - 350, 50);
      rect(width/2 - 100, height/2, 200, 50, 10);
      fill(0);
      textSize(30);
      text("Start Game!",width/2 - 80, height/2 + 35);
      if(mouseX >= width/2 - 100 && mouseX < width/2 + 100)
      {
        if(mouseY >= height/2 && mouseY <= height/2 + 50)
        {
          fill(200);
          rect(width/2 - 100, height/2, 200, 50, 10);
          fill(0);
          textSize(30);
          text("Start Game!",width/2 - 80, height/2 + 35);
          if(mouseButton == LEFT)
          {
            started = true;
          }
        }
      }
    }
    return started;
  }
  
  // shows a newround screen and a countdown.
  int NewRound(int duration)
  {
    //TODO: Text is boring and not centre
    // needs some spicing up.
    background(0);
    stroke(255);
    fill(255);
    textSize(70);
    text("New Round!", 200, 100);
    duration -= millis();
    text(duration / 1000, 300, 300);
    
    return duration;
  }
}