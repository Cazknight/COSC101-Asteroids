/**************************************************************
* File(s): Assessment_3.pde, Animator.pde, Asteroid.pde, Asteroid_Manager.pde, Bullet.pde, 
*          Bullet_Manager.pde, Collision_Detection.pde, Game_States.pde, Power_Up.pde,
*          Ship.pde, Asteroid_#.png (# representing 0 to 8), Background.jpg, Bullet.png, 
*          Controls.png, Credits.png, CreditScreen.png, Exit.png, GameOver.png,
*          explosion_#.png (# representing 0 to 5), GetReady.png, Heart.png, HighscoreButton.png,
*          HighscoreTitle.png, Name.png, NameScore.png, NewRound.png, PowerUp01.png, PowerUp02.png,
*          PulseWave.png, Ship_0.png, Ship_1.png, ShipExplosion_#.png (# representing 0 to 9),
 *         SimpleShot.png, Start.png, Title.png.
* Authors: Zach Thompson, Peter Chung and Bart Stolarek
* Date: 13/05/2018
* Course: COSC101 - Software Development Studio 1
* 
* Desc: Video game called Asteroids, loosely based on the original Asteroids game developed
* in 1979. User uses a GUI where they provide input to the game via controls, and control a 
* ship thats objective is to destroy all the Asteroids in that round, as well as avoid 
* colliding with any of the Asteroids. The user has 3 lives/chances, with each destruction
* of an asteroid awarding the user with points towards the score. The 10 highest scores
* of all time are displayed for the next user to see
*
* Usage: Make sure to run in the processing environment and press play.
* You will need a working keyboard that is connected to your PC, working arrow keys and spacebar
* on that keyboard. Use those keys to move the ship in the direction you want to, and the spacebar
* to shoot the weapon on the ship.
* 
**************************************************************/

// Level manager is responsible for displaying
// the title screen and screens between rounds.
// i am undecided if this needs to be a seperate class 
// or just part of the main draw loop.

class Game_States
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
  PImage controls;
  PImage getReady;
  PImage newRound;
  PImage heart;
  PImage exitButton;
  PImage creditsButton;
  PImage creditsScreen;
  
  
  /**************************************************************
* Constructor: Game_States

* Parameters: None

* Returns:  

* Desc: loads the images associated with the current state of the game.

***************************************************************/
  
  Game_States()
  {
    //loads the title image.
    title = loadImage("Title.png");
    startButton = loadImage("Start.png");
    gameOver = loadImage("GameOver.png");
    enterName = loadImage("Name.png");
    highscoreButton = loadImage("HighscoreButton.png");
    highscoreTitle = loadImage("HighscoreTitle.png");
    nameScore = loadImage("NameScore.png");
    controls = loadImage("Controls.png");
    getReady = loadImage("GetReady.png");
    newRound = loadImage("NewRound.png");
    heart = loadImage("Heart.png");
    exitButton = loadImage("Exit.png");
    creditsButton = loadImage("Credits.png");
    creditsScreen = loadImage("CreditScreen.png");
  }
  
  /**************************************************************
* Method: NewGame

* Parameters: Asteroid_Manager AM - takes the class Asteroid_Manager

* Returns:  buttonClicked - it as true. 

* Desc: checks if the game has started, and then displays the pregame state.

***************************************************************/
  
  boolean NewGame(Asteroid_Manager AM)
  {

    
    boolean buttonClicked = false;
    background(0);
    AM.UpdateAsteroids();
    image(title, width / 2, 130);
    controls.resize(width/2, height/4);
    image(controls, width / 2, height - 50);
    buttonClicked = OnHoverButton(300, 400, 200, 50, startButton);
    if(OnHoverButton(700, 400, 200, 50, exitButton))
    {
      exit();
    }

    return buttonClicked;
  }
  
  /**************************************************************
* Method: NewRound

* Parameters: integer duration

* Returns:  duration - duration of the interval between rounds

* Desc: shows a newround screen and a countdown

***************************************************************/
  // shows a newround screen and a countdown.
  int NewRound(int duration)
  {
    background(0);
    image(getReady, width / 2, 100);
    image(newRound, width / 2, 200);
    duration -= millis();
    textSize(70);
    fill(255);
    stroke(255);
    textSize(170);
    text(duration / 1000, width / 2 - 30, height / 2 + 30);  
    return duration;
  }
  
  
  /**************************************************************
* Method: GameOver

* Parameters: String name, boolean acceptName, Stringlist Names, IntList Scores - users details

* Returns: buttonClicked 

* Desc: has the user enter their name, and provides a button for the user to click and save
* their name. 

***************************************************************/
  boolean GameOver(String name, boolean acceptName, StringList Names, IntList Scores)
  {
    boolean buttonClicked;
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
      buttonClicked = OnHoverButton(width/2, 550, 850, 50, highscoreButton);
      return buttonClicked;
    }
    else
    {
      int i = 0;
      int offset = 0;
      background(0);
      image(highscoreTitle, width  / 2, 50); 
      image(nameScore, width  / 2, 120); 
      if(highscoresConnected)
      {
        for(i = 0; i < Names.size(); i++)
        {
          text(Names.get(i).toUpperCase(), 175, 200 + offset);
          text(Scores.get(i), 750, 200 + offset);
          offset += 35;
        }
      }
      else
      {
        text("There was an issue getting the Highscores", 200, height/2);
        text("Please try again later", 350, height/2 + 50);
      }
      
      if(OnHoverButton(300, 580, 200, 50, creditsButton))
      {
        credits = true;
      }
      if(OnHoverButton(700, 580, 200, 50, exitButton))
      {
        exit();
      }
      return true;
    }
    
    
  }
  
  
  /**************************************************************
* Method: InGame

* Parameters: integer lives, integer score

* Returns: void 

* Desc: displays the lives of the user left

***************************************************************/
  void InGame(int lives, int score)
  {
    int xOffset = 20;
    for(int i = 0; i < lives; i++)
    {
      image(heart, xOffset, 15);
      xOffset += 40;
    }
    fill(255);
    stroke(255);
    textSize(30);
    text(score, 900, 25);
  }
  
  
  /**************************************************************
* Method: CreditScreen

* Parameters: none

* Returns:  void

* Desc: presents the credit screen, with an exit button. 

***************************************************************/
  void CreditScreen()
  {
    background(0);
    image(creditsScreen, width / 2 , height / 2);
    if(OnHoverButton(width / 2, 580, 200, 50, exitButton))
    {
      exit();
    }
  }


/**************************************************************
* Method: OnHoverButton

* Parameters: float posX, float posY, float buttonWidth, float buttonHeight, PImage buttonImag

* Returns:  boolean onHoverButton

* Desc: Checks the position of the button, and where the user clicked, and then runs the method.
* 

***************************************************************/
  boolean OnHoverButton(float posX, float posY, float buttonWidth, float buttonHeight, PImage buttonImg)
  {
    fill(255);
    stroke(255);
    rect(posX - (buttonWidth / 2), posY - (buttonHeight / 2), buttonWidth, buttonHeight, 10);
    image(buttonImg, posX , posY);
    if(mouseX >=  posX - (buttonWidth / 2) && mouseX < posX + (buttonWidth / 2))
    {
      if(mouseY >= posY - (buttonHeight / 2) && mouseY <= posY + (buttonHeight / 2))
      {
        fill(200);
        rect(posX - (buttonWidth / 2), posY - (buttonHeight / 2), buttonWidth, buttonHeight, 10);
        image(buttonImg, posX , posY);
        if(mouseButton == LEFT)
        {
          AM.DestoryAsteroids();
          return true;
        }
      }
    }
    return false;
  }
}