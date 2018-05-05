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
PImage background;
ArrayList<Bullet> spawnedBullets;

String playerName = "";
StringList Names = new StringList();
IntList Scores = new IntList();
SoundFile music;


void setup() {
    size(1024, 640);
    frameRate(30);
    imageMode(CENTER);
    background = loadImage("Background.jpg");
    AM = new Asteroid_Manager();
    AM.InitializeAsteroids(4);
    LM = new Level_Manager();
    BM = new Bullet_Manager();
    HS = new Highscores(this);
    CD = new Collision_Detection();
    
    if(HS.HighscoreConnect())
    {
      highscoresConnected = true;
    }

    music = new SoundFile(this, "Preparing for War.mp3");
    music.loop();
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
  }
  
  if(lives == 0)
  { 
    if(nameEntered && !gotData)
    {
      HS.UpdateHighscores(playerName, score);
      
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
  
  AM.UpdateAsteroids();
  spawnedBullets = BM.UpdateBullets();
  CD.Update_Missile_Collision();
  
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
    }
  }
  
  if(alive == true)
  {
    ship.UpdateShip(keyPress);
  
    if(shoot == true) 
    {
      BM.shotFired();
      shoot = false;
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
  }
  else
  {
    println("Game Over man, game over");  
  }
}
 
void keyPressed() 
{
  keyPress[keyCode] = true;
  if(key == 'q')
  {
    AM.DestroyAsteroid((int)random(0, AM.asteroids.size()));
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
}
