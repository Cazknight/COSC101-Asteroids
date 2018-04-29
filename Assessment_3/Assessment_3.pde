Ship ship;
Asteroid_Manager AM;

boolean[] keyPress = new boolean[256];
int space = 32;
boolean shoot = false;
ArrayList<Asteroid> spawnedAsteroids;


void setup() {
    size(800, 800);
    frameRate(30);
    //instantiate the class's
    ship = new Ship();
    AM = new Asteroid_Manager(1);

    //call the ship class's initialize function.
    ship.InitializeShip();
}
 
void draw() 
{
  background(0);
  spawnedAsteroids = AM.UpdateAsteroids();
  
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
}
 
void keyReleased() 
{
   keyPress[keyCode] = false;
   if(key == ' ')
    {
      shoot = true;
    }
}
