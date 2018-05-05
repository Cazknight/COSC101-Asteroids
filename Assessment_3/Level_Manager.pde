// Level manager is responsible for displaying
// the title screen and screens between rounds.
// i am undecided if this needs to be a seperate class 
// or just part of the main draw loop.

class Level_Manager
{
  //Constants
  
  //Variables.
  PImage title;
  PImage startButton;
  PImage gameOver;
  PImage enterName;
  PImage highscoreButton;
  PImage highscoreTitle;
  PImage nameScore;
  //Level Manager Constructor
  Level_Manager()
  {
    //loads the title image.
    title = loadImage("Title.png");
    startButton = loadImage("Start.png");
    gameOver = loadImage("GameOver.png");
    enterName = loadImage("Name.png");
    highscoreButton = loadImage("HighscoreButton.png");
    highscoreTitle = loadImage("HighscoreTitle.png");
    nameScore = loadImage("NameScore.png");
  }
  // called at the start of the game.
  boolean NewGame(Asteroid_Manager AM)
  {
    // simply checks if the game has started
    // e.g has the player clicked the start button
    
    //TODO: this needs to be optimized, i think some parts can be removed
    // and it can be cleaned up, some values need to be made into variables.
    boolean buttonClicked = false;
    background(0);
    AM.UpdateAsteroids();
    image(title, width / 2, 130);
    CenteredImageButton(startButton, 200, 50, 0, false);
    
    if(mouseX >= width/2 - 100 && mouseX < width/2 + 100)
    {
      if(mouseY >= height/2 - 25 && mouseY <= height/2 + 25)
      {
        CenteredImageButton(startButton, 200, 50, 0, true);
        if(mouseButton == LEFT)
        {
          buttonClicked = true;
          AM.DestoryAsteroids();
        }
      }
    }
    if(enterKeyActive == true)
      {
        buttonClicked = true;
        AM.DestoryAsteroids();
      }

    return buttonClicked;
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
  
  boolean GameOver(String name, boolean acceptName, StringList Names, IntList Scores)
  {
    if(!acceptName)
    {
      background(0);
      stroke(255);
      fill(255);
      image(gameOver, width / 2, 100);
      image(enterName, width / 2, 200);
      rect((width / 2) - 125, 365, 250, 50, 10);
      textSize(30);
      fill(0);
      text(name.toUpperCase(), (width / 2) - (name.length() * 10), 400);
      
      CenteredImageButton(highscoreButton, 820, 50, 200, false);
      
      if(mouseX >= width/2 - 400 && mouseX < width/2 + 400)
      {
        if(mouseY >= height/2 + 175 && mouseY <= height/2 + 225)
        {
          CenteredImageButton(highscoreButton, 820, 50, 200, true);
          if(mouseButton == LEFT)
          {
          return true;
          }
        }
      }
      if(enterKeyActive == true)
      {
        return true;
      }
      
      return false;
    }
    else
    {
      int i = 0;
      int offset = 0;
      background(0);
      image(highscoreTitle, width  / 2, 50); 
      image(nameScore, width  / 2, 120); 
      
      for(i = 0; i < Names.size(); i++)
      {
        text(Names.get(i).toUpperCase(), 175, 220 + offset);
        text(Scores.get(i), 750, 220 + offset);
        offset += 40;
      }
      return true;
    }
    
    
  }
  
  void CenteredImageButton(PImage buttonImg, float buttonWidth, float buttonHeight, float yOffset, boolean onHover)
  {
    float posX = (width / 2) - (buttonWidth / 2);
    float posY = (height / 2) - (buttonHeight / 2) + yOffset;
    if(!onHover)
    {
      fill(255);
    }
    else
    {
      fill(200);
    }
    stroke(255);
    rect( posX, posY, buttonWidth, buttonHeight, 10);
    image(buttonImg, width / 2 , height / 2 + yOffset);
  }
}
