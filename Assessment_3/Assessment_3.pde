import processing.sound.*;


Ship ship;
Asteroid_Manager AM;
Level_Manager LM;
Highscores HS;

boolean[] keyPress = new boolean[256];
int space = 32;
int level = 0;
int timer;
boolean shoot = false;
boolean started = false;
boolean newRound = false;
boolean nameEntered = false;
boolean gotData = false;
boolean highscoresConnected = false;
PImage background;
int score = 12000;
int lives = 0;
String playerName = "";
StringList Names = new StringList();
IntList Scores = new IntList();
SoundFile music;

void setup() {
    size(1024, 640);
    frameRate(30);
    background = loadImage("Background.jpg");

    AM = new Asteroid_Manager();
    AM.InitializeAsteroids(4);
    LM = new Level_Manager();
    HS = new Highscores(this);
    
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
  else if(started && level == 0)
  { 
    level = 1;
    ship = new Ship();
    AM.InitializeAsteroids(level);
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
  image(background,0,0);
  AM.UpdateAsteroids();
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
  
  ship.UpdateShip(keyPress);
  ship.shotArray();

  if(shoot == true) 
  {
   ship.fireWeapons();
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