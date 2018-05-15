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

// the asteroid base class.
//the class that holds the data for each asteroid.
// one of these will be created for each asteroid
// and will hold unique data.

class Asteroid
{
  //CONSTANTS
  int IMGQTY = 9;
  
  //Variables.
  PVector pos;
  PVector dir;
  PImage[] asteroidImgs = new PImage[IMGQTY];
  PImage currentImg;
  float collisionRadius;
  float asteroidCentre;
  float speed;
  int size;
  int maxSize;
  float radius;
  int i;
  
  
  /**************************************************************
* Constructor: Asteroid

* Parameters: PVector Position, PVector Direction, int Size - takes the location, 
* direction and size of an asteroid. 

* Returns:  

* Desc: Sets the variables and parameters needed for an Asteroid class, in order
* to manipulate it accordingly in the game. 

***************************************************************/

  Asteroid(PVector Position, PVector Direction, int Size)
  {
    // set asteroid characteristics.
    pos = Position;
    dir = Direction;
    size = Size;
    speed = random(2,5);
    //load the asteroid images
    for(i = 0; i < asteroidImgs.length; i++)
    {
      asteroidImgs[i] = loadImage("Asteroid_" + i + ".png");
    }
    
    //sets the image to use based on the inputed "size" varable.
    currentImg = asteroidImgs[size];
    
    // depending on the size, set the maxSize of the
    // asteroid to be spawned when this one dies.
    // TODO: possible change name of maxSize, could be a bit confusing.
    if(size <= 2)
    {
      maxSize = 3;
    }
    else if(size > 2 && size <= 5)
    {
      maxSize = 6;
    }
    else
    {
      maxSize = 7;
    }
    
    if(size < 3)
      radius = 28.0; //32
    else if(size >=3 && size < 6)
      radius = 20.0; //24
    else
      radius = 16.0; // 18
    
  }
}