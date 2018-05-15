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

import processing.sound.*;

//load classes
Ship ship;
Asteroid_Manager AM;
Game_States GS;
Bullet_Manager BM;
Collision_Detection CD;
Highscores HS;
Animator Anim;
Power_Up PU;

//initialise variables
boolean[] keyPress = new boolean[256];
int space = 32;
int level = 0;
int timer;
int lives = 3;
int score = 0;
int respawn_Timer = 90;
int invul_Timer = 60;
boolean alive = true;
boolean shoot = false;
boolean started = false;
boolean newRound = false;
boolean nameEntered = false;
boolean gotData = false;
boolean credits = false;
boolean highscoresConnected = false;
boolean enterKeyActive = false;
PImage background;
ArrayList<Bullet> spawnedBullets;
PFont font;
String playerName = "";
StringList Names = new StringList();
IntList Scores = new IntList();
SoundFile music;
SoundFile shootSound;


/**************************************************************
* Method: setup

* Parameters: None

* Returns: void

* Desc: as the description suggests, this method sets up the game, 
* loading only once all the parameters, variables and classes. 

***************************************************************/

void setup() {
    size(1024, 640);
    frameRate(30);
    imageMode(CENTER);
    font = loadFont("BlackHoleBB-70.vlw");
    textFont(font, 70);
    background = loadImage("Background.jpg");
    //initialize classes
    AM = new Asteroid_Manager();
    AM.InitializeAsteroids(6);
    GS = new Game_States();
    BM = new Bullet_Manager();
    HS = new Highscores(this);
    CD = new Collision_Detection(this);
    PU = new Power_Up();
    Anim = new Animator();
    
    if(HS.HighscoreConnect())
    {
      highscoresConnected = true;
    }
    
    //play sounds
    music = new SoundFile(this, "Preparing for War.mp3");
    shootSound = new SoundFile(this, "shoot.mp3");
    music.loop();
}
 
/**************************************************************
* Method: draw 

* Parameters: None

* Returns: void 

* Desc: This method repeatedly loads/refreshes the screen with the paramaters
* and objects at a frame rate of about 30+ frames per second, to give the
* user a illusion of motion. 

***************************************************************/ 
void draw() 
{
  background(0);
  image(background, width/2, height/2);
  
  //starts the pre-game state, the play state, and gameover state
  if(!started)
  {
    started = GS.NewGame(AM);
    return;
  }
  else if( started && level == 0)
  { 
    level = 1;
    AM.InitializeAsteroids(level);
    ship = new Ship();
    ship.InitializeShip();
    PU.Spawn_Power_Up();
  }
  else
  {
    GS.InGame(lives, score);
  }
  
  if(lives == 0 && !credits)
  { 
    if(nameEntered && !gotData)
    {
      
      
      Names.clear();
      Scores.clear();
      if(highscoresConnected)
      {
        HS.UpdateHighscores(playerName, score);
        Names = HS.GetNames();
        Scores = HS.GetScores();
      }
      gotData = true;
    }
    nameEntered = GS.GameOver(playerName, nameEntered, Names, Scores);
    return;
  }
  
  if(credits)
  {
    GS.CreditScreen();
    return;
  }
  
  
  AM.UpdateAsteroids();
  spawnedBullets = BM.UpdateBullets();
  score += CD.Update_Missile_Collision(Anim);
  Anim.UpdateAnimations();
  CD.Update_Power_Up_Collision();
  PU.Update_Power_Up();
  
  if(AM.asteroids.size() == 0)
  {
    if(!newRound)
    {
      timer = millis();
      newRound = true;
    }
    else if(newRound && timer + 5000 > millis())
    {
      int duration = timer + 6000;
      duration = GS.NewRound(duration);
    }
    else if(newRound && timer + 5000 < millis())
    {
      level += 1;
      AM.InitializeAsteroids(level);
      ship.invunerable = true;
      newRound = false;
      if(level % 2 == 0)
        PU.spawned = true;
    }
  }
  
  //checks if the ship is alive and updates, plus shots fired
  if(alive == true)
  {
    ship.UpdateShip(keyPress);
  
    if(shoot == true) 
    {
      if(BM.fireMode == 1 || BM.fireMode == 2)
      {
        BM.shotFired(90);
        shoot = false;
      }
      else if(BM.fireMode == 3)
      {
        BM.shotFired(85);
        BM.shotFired(95);
        shoot = false;
      }
    }
    CD.Update_Ship_Collision();
  }
  else if(alive == false && lives > 0 && respawn_Timer > 0)
  {
    respawn_Timer--;
  }
  else if(alive == false && lives > 0 && respawn_Timer == 0)
  {
    respawn_Timer = 90;
    alive = true;
    ship.invunerable = true;
  }

  if(ship.invunerable && invul_Timer > 0)
  {
    invul_Timer--;
  }
  else
  {
    ship.invunerable = false;
    invul_Timer = 60;
  }

}
 
 
 /**************************************************************
* Method: keyPressed 

* Parameters: key is pressed

* Returns: void 

* Desc: Method that changes several booleans to true when a certain
* key is pressed, also removes text input the user as placed. 

***************************************************************/ 
void keyPressed() 
{
  keyPress[keyCode] = true;
  if(lives == 0)
  {
    if(playerName.length() < 10 && key != CODED && key != ENTER 
        && key != TAB && key != ' ')
    {
    playerName += key;
    }
    if(key == DELETE | key == BACKSPACE)
    {
      playerName = "";
    }
  }
}
 
 /**************************************************************
* Method: keyReleased 

* Parameters: key is released

* Returns: void 

* Desc: When the key spacebar is released it activates the weapons once
* also when enter key is released, boolean is changes to false. 

***************************************************************/ 
void keyReleased() 
{
   keyPress[keyCode] = false;
   if(key == ' ' && alive == true)
   {
      if(!newRound)
      {
        shoot = true;
        shootSound.play();
      }
      
   }
   if(key == ENTER)
   {
     enterKeyActive = false;
   }
}