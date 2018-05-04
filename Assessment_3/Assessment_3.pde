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
Bullet_Manager BM;
Collision_Detection CD;

boolean[] keyPress = new boolean[256];
int space = 32;
int level = 0;
int timer;
int lives = 3;
int respawn_Timer = 90;
boolean alive = true;
boolean shoot = false;
boolean started = false;
boolean newRound = false;
PImage background;
ArrayList<Bullet> spawnedBullets;


void setup() {
    size(1024, 640);
    frameRate(30);
    background = loadImage("Background.jpg");
    //instantiate the class's
    //ship = new Ship();
    //AM = new Asteroid_Manager(level);
    LM = new Level_Manager();
    BM = new Bullet_Manager();
    //call the ship class's initialize function.
    //ship.InitializeShip();
    CD = new Collision_Detection();
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
  imageMode(CENTER);
  image(background, width/2, height/2);
  AM.UpdateAsteroids();
  spawnedBullets = BM.UpdateBullets();
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
}
 
void keyReleased() 
{
   keyPress[keyCode] = false;
   if(key == ' ')
    {
      shoot = true;
      
    }
}
