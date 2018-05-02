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

Ship ship;
Asteroid_Manager AM;
Level_Manager LM;

boolean[] keyPress = new boolean[256];
int space = 32;
int level = 0;
int timer;
boolean shoot = false;
boolean started = false;
boolean newRound = false;
PImage background;


void setup() {
    size(1024, 640);
    frameRate(30);
    background = loadImage("Background.jpg");
    //instantiate the class's
    //ship = new Ship();
    //AM = new Asteroid_Manager(level);
    LM = new Level_Manager();
    //call the ship class's initialize function.
    //ship.InitializeShip();
}
 
void draw() 
{
  float random = random(0,20);
  if (random > 5.1534 && random < 5.1745)
  {
    println(random);
  }
  if(!started)
  {
    started = LM.NewGame(started);
    return;
  }
  else if( started && level == 0)
  { 
    level = 1;
    ship = new Ship();
    AM = new Asteroid_Manager(level);
    ship.InitializeShip();
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
}
 
void keyReleased() 
{
   keyPress[keyCode] = false;
   if(key == ' ')
    {
      shoot = true;
      
    }
}