/* COSC101 - Assesment 3
# Authors - Zach Thompson, Peter Chung and Bart Stolarek
#
# Description
# A modern clone of the old Asteroids Game
#
# Features
#
#
# Comments
# currently no projectiles are flying around
# or are any collisions being detected
# so to test asteroids blowing up you can press 'q', this will pick
# a random asteroid and destroy it, BE CAREFUL not to press q once all the asteroids
# are dead this will cause a null pointer exception and wont be possible 
#vwith collisions implemented.
*/
import processing.sound.*;

Ship ship;
Asteroid_Manager AM;
Level_Manager LM;
Bullet_Manager BM;
Collision_Detection CD;
Highscores HS;
Power_Up PU;

boolean[] keyPress = new boolean[256];
int space = 32;
int level = 0;
int timer;
int lives = 3;
int score = 12000;
int respawn_Timer = 90;
boolean alive = true;
boolean shoot = false;
boolean started = false;
boolean newRound = false;
boolean nameEntered = false;
boolean gotData = false;
boolean highscoresConnected = false;
boolean enterKeyActive = false;
PImage background;
PImage life;
ArrayList<Bullet> spawnedBullets;

String playerName = "";
StringList Names = new StringList();
IntList Scores = new IntList();
SoundFile music;


void setup() {
    size(1024, 640);
    frameRate(30);
    //Processing function that causes the position of images to be at their center.
    imageMode(CENTER);
    background = loadImage("Background.jpg");
    AM = new Asteroid_Manager();
    AM.InitializeAsteroids(4);
    LM = new Level_Manager();
    BM = new Bullet_Manager();
    HS = new Highscores(this);
    CD = new Collision_Detection();
    PU = new Power_Up();
    
 //   if(HS.HighscoreConnect())
    {
      highscoresConnected = true;
    }

    music = new SoundFile(this, "Preparing for War.mp3");
    music.loop();
    music.amp(.5);
}
 
void draw() 
{
  if(!started)
  {
    started = LM.NewGame(AM);
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
  
  if(lives == 0)
  { 
    if(nameEntered && !gotData)
    {
  //   HS.UpdateHighscores(playerName, score);
      
      Names.clear();
      Scores.clear();
      Names = HS.GetNames();
      Scores = HS.GetScores();
      gotData = true;
    }
    nameEntered = LM.GameOver(playerName, nameEntered, Names, Scores);
    return;
  }
  
  background(0);
  image(background, width/2, height/2);
  screen_Info();  
  AM.UpdateAsteroids();
  spawnedBullets = BM.UpdateBullets();
  CD.Update_Missile_Collision();
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
      duration = LM.NewRound(duration); 
    }
    else if(newRound && timer + 5000 < millis())
    {
      level += 1;
      AM.InitializeAsteroids(level);
      newRound = false;
      if(level % 2 == 0)
        PU.spawned = true;
    }
  }
  
  //Activate movement of ship and firing of weapons when alive. 
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
    //Check for ship collision.  
    CD.Update_Ship_Collision();
  }
  //If ship not alive, and more lives exist, decrease respawn timer. 
  else if(alive == false && lives > 0 && respawn_Timer > 0)
  {
    respawn_Timer--;
  }
  //If respawn timer reaches 0, respawn the ship, and reset timer.
  else if(alive == false && lives > 0 && respawn_Timer == 0)
  {
    respawn_Timer = 90;
    alive = true;
  }
  

  

    
}
 
void keyPressed() 
{
  keyPress[keyCode] = true;
  if(key == 'q')
  {
    AM.DestroyAsteroid((int)random(0, AM.asteroids.size()));
  }
  if(key == ENTER)
  {
    enterKeyActive = true;
  }
  if(lives == 0)
  {
    if(playerName.length() < 10 && key != ENTER)
    {
    playerName += key;
    }
    if(key == DELETE | key == BACKSPACE)
    {
      playerName = "";
    }
    
  }
}
 
void keyReleased() 
{
   keyPress[keyCode] = false;
   if(key == ' ')
   {
      shoot = true;
      
   }
   if(key == ENTER)
   {
     enterKeyActive = false;
   }
}

//Display in-game information for player.
void screen_Info()
{
  fill(255);
  textSize(20);
  text("Lives:", 20, 30);
  if(lives > 1) 
  {
    for(int i = 1; i < lives; i++)
    {
      life = loadImage("Ship.png");
      image(life, 65 + i * 25, 25, 20, 20);
    }
  }
  else if(lives == 1)
  { 
    fill(255);
    textSize(20);
    text("0", 80, 30);
  }  
}
