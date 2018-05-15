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

class Animator
{
  int frame = 0;
  IntList explosionStates;
  PImage[] explosionAnim = new PImage[6];
  PImage[] shipImages = new PImage[2];
  PImage[] shipExplosion = new PImage[10];
  PImage currentShipImage;
  PVector shipExplosionPos;
  int shipExplosionState = 0;
  boolean shipExploding = false;
  ArrayList<PVector> explosionLocations;
 
  
  /**************************************************************
* Constructor: Animator

* Parameters: None

* Returns:  

* Desc: This constructor loads the images of explosions, and assigns
* them to a variable, as well as in to a array list. 

***************************************************************/
  
  Animator()
  {
    for(int i = 0; i < explosionAnim.length; i++)
    {
      explosionAnim[i] = loadImage("explosion_" + i + ".png");
    }
    for(int i = 0; i < shipImages.length; i++)
    {
      shipImages[i] = loadImage("Ship_" + i + ".png");
    }
    for(int i = 0; i < shipExplosion.length; i++)
    {
      shipExplosion[i] = loadImage("ShipExplosion_" + i + ".png");
    }
    currentShipImage = shipImages[0];
    explosionLocations = new ArrayList<PVector>();
    explosionStates = new IntList();
  }
  
  
  /**************************************************************
* Method: UpdateAnimations

* Parameters: None

* Returns:  void

* Desc: Checks if the ships boolean of exploding is true, if it is the
* explosion images will run through in order in the position of the ship.
* Once the state reaches the end the explosion images disappear. 

***************************************************************/
  void UpdateAnimations()
  { 
    frame += 1;
    if(frame > frameRate)
    {
      frame = 0;
    }
    if(shipExploding)
    {
      if(shipExplosionState > 9)
      {
        shipExplosionState = 0;
        shipExploding = false;
      }
      
      if(frame % 2 == 0)
      {
        image(shipExplosion[shipExplosionState], shipExplosionPos.x, shipExplosionPos.y);
        shipExplosionState += 1;
      }
    }
    for(int i = 0; i < explosionStates.size(); i++)
    {
      if(explosionStates.get(i) / 3 > 5)
      {
        explosionStates.remove(i);
        explosionLocations.remove(i);
      }
    }
    
    for(int i = 0; i < explosionLocations.size(); i++)
    {
      int imageState = explosionStates.get(i) / 3;
      PImage displayedImage = explosionAnim[imageState];
      PVector tempLocation = explosionLocations.get(i);
      image(displayedImage, tempLocation.x, tempLocation.y);
      explosionStates.set(i, explosionStates.get(i) + 1);
    }
  }
  
/**************************************************************
* Method: ExplodeShip

* Parameters: PVector Location - takes the location of the ship

* Returns: void 

* Desc: assigns the location of the ship to a variable so that it can
* be called for the explosion images, shipExploding boolean is set
* to true. 

***************************************************************/
  void ExplodeShip(PVector Location)
  {
    shipExplosionPos = new PVector(Location.x, Location.y);
    shipExploding = true;
  }
  
/**************************************************************
* Method: AddExplosionAnimation

* Parameters: PVector Location

* Returns:  void

* Desc: takes the location of the object, and adds to a temporary
* location variable, it then adds on a start variable to the state of 
* the explosion and will run through the explosion images. 

***************************************************************/
  void AddExplosionAnimation(PVector Location)
  {
    PVector tempLocation = new PVector(Location.x, Location.y);
    explosionLocations.add(tempLocation);
    explosionStates.append(0);
  }
  
  
  /**************************************************************
* Method: DrawShip

* Parameters: boolean invunerable - takes the vulnerability of the ship

* Returns:  void

* Desc: if the ship is invunerable, it will change the ship to a more transparent
* image, giving the user some time to establish where they are. 

***************************************************************/
  void DrawShip(boolean invunerable)
  {
    boolean toggleShip = false;
    if(invunerable)
    {
      
      if( frame % 8 == 0)
      {
        
        toggleShip = true;
      }
      else
      {
        toggleShip = false;
      }
      
    }
    else
    {
      currentShipImage = shipImages[0];
    }
    
    if(toggleShip)
    {
      if(currentShipImage == shipImages[0])
      {
        currentShipImage = shipImages[1];
      }
      else
      {
        currentShipImage = shipImages[0];
      }
    }

    
    currentShipImage.resize(55,70);
    image(currentShipImage, 0, 0);
  }
}