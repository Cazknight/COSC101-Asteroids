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

// Manages asteroid swarms
// responsible for creating, updating and destroying asteroids.

class Asteroid_Manager
{
  //constants
  float ASTEROIDSIZE = 8.99;
  int SMALLESTASTEROIDINDEX = 6;
  //Variables.
  ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
  int asteroidMultiplier = 3;
  int i;
  
  /**************************************************************
* Method: InitializeAsteroids

* Parameters: int Level

* Returns: Void

* Desc: Initialize an Asteroid field base on the level. Includes Algorithm that 
* increases the amount of Asteroids spawned when a new level is started. Loads
* random digits in a scope to have Asteroids initialize in different places. 

***************************************************************/
  //initializes an asteroid field base on level.
  void InitializeAsteroids(int Level)
  {

    int asteroidQuantity = (Level + asteroidMultiplier) * asteroidMultiplier;
    //make sure the array is clear prior to creating a new asteroid field.
    asteroids.clear();
    
    //loop and create a new asteroid every iteration.
    for(i = 0; i < asteroidQuantity; i++)
    {
      //create some random variables for the asteroids.
      PVector tempPos = new PVector(random(0, width), random(0, height));


      if (tempPos.x > 312 && tempPos.x < 712)
        tempPos.x += 200;
      if (tempPos.y > 180 && tempPos.y < 560)
        tempPos.y += 300;
      
      PVector tempDir = new PVector(random(-1, 1), random(-1,1));
      if(tempDir.x < 0.3 && tempDir.x > -0.3)
      {
        tempDir.x = random(0.4, 1);
      }
      
      if(tempDir.y < 0.3 && tempDir.y > -0.3)
      {
        tempDir.y = random(-0.4, -1);
      }
      int tempSize = (int)random(0, ASTEROIDSIZE);
      //create the new asteroid and store it in a tempAsteroid variable.
      Asteroid tempAsteroid = new Asteroid(tempPos, tempDir, tempSize);
      // load the asteroid into the list.
      asteroids.add(tempAsteroid);
    }
  }
  
  
  /**************************************************************
* Method: UpdateAsteroids

* Parameters: None

* Returns: Void  

* Desc: Updates the position of the Asteroids so that the asteroid moves

***************************************************************/

  void UpdateAsteroids()
  {
    //loop through the current asteroids.
    for(i = 0; i < asteroids.size(); i++)
    {
      // get the current iterations asteroid.
      Asteroid tempAsteroid = asteroids.get(i);
      
      //update its position, based on the unique direction and speed
      // of the asteroid.
      tempAsteroid.pos.x += tempAsteroid.dir.x * tempAsteroid.speed;
      tempAsteroid.pos.y += tempAsteroid.dir.y * tempAsteroid.speed;
      // check if we need to teleport it to the other side of the screen.
      AsteroidScreenWrap(tempAsteroid);
      // finally draw the asteroid.
      image(tempAsteroid.currentImg, tempAsteroid.pos.x,tempAsteroid.pos.y);
    }
  }
  
  
  /**************************************************************
* Method: DestroyAsteroids 

* Parameters: int AsteroidIndex

* Returns:  void

* Desc: Called when a collision is detected, it takes the asteroid
* and checks if it was one of the larger asteroids, if it is
* then smaller asteroids will spawn (random amount), otherwise
* it is removed from the draw list. 

***************************************************************/
 
  void DestroyAsteroid(int AsteroidIndex)
  {

    Asteroid tempAsteroid = asteroids.get(AsteroidIndex);

    if(tempAsteroid.maxSize <= SMALLESTASTEROIDINDEX)
    { 
      
      int childrenToSpawn = (int)random(1,5);
      
      SpawnAsteroids(childrenToSpawn, tempAsteroid);
      
      asteroids.remove(AsteroidIndex);
    }
    else
    {

      asteroids.remove(AsteroidIndex);
    } 
  }
  
  
  /**************************************************************
* Method: AsteroidScreenWrap

* Parameters: Asteroid AsteroidToWrap - takes the class/object Asteroid

* Returns:  void

* Desc: if the asteroid travels to far off screen, it will be redrawn on
* on the opposite side of the screen. 

***************************************************************/

  void AsteroidScreenWrap(Asteroid AsteroidToWrap)
  {
      if(AsteroidToWrap.pos.x > width + AsteroidToWrap.currentImg.width)
      {
        AsteroidToWrap.pos.x = -AsteroidToWrap.currentImg.width;
      }
      else if(AsteroidToWrap.pos.x < -AsteroidToWrap.currentImg.width)
      {
        AsteroidToWrap.pos.x = width + AsteroidToWrap.currentImg.width;
      }
    
      if(AsteroidToWrap.pos.y > height + AsteroidToWrap.currentImg.height)
      {
        AsteroidToWrap.pos.y = -AsteroidToWrap.currentImg.height;
      }
      else if(AsteroidToWrap.pos.y < -AsteroidToWrap.currentImg.height)
      {
        AsteroidToWrap.pos.y = height + AsteroidToWrap.currentImg.height;
      }
  }
  
  
  /**************************************************************
* Method: SpawnAsteroids

* Parameters: int Quantity, Asteroid ParentAsteroid - takes quantity and large asteroid

* Returns:  void

* Desc: Spawns new asteroids when a larger asteroid is destroyed. Takes in how many
* are to be spawned as well, it will loop through and spawn a asteroid for each
* interval of the quantity. Spawns random characteristics for the new asteroids. 

***************************************************************/
  // spawn new asteroids, this is used when destroying large asteroids
  // and we want to spawn some smaller ones in its place.
  // takes in how many you want to spawn and the asteroid thats being destroyed.
  void SpawnAsteroids(int Quantity, Asteroid ParentAsteroid)
  {
    //loop through the quantity and create some baby asteroids.
    for(i = 0; i < Quantity; i++)
    {
      //some random characteristics for the new asteroids.
      PVector tempPos = new PVector(random(ParentAsteroid.pos.x - ParentAsteroid.radius, 
                                    ParentAsteroid.pos.x + ParentAsteroid.radius), 
                                    random(ParentAsteroid.pos.y - ParentAsteroid.radius, 
                                    ParentAsteroid.pos.y + ParentAsteroid.radius));
      PVector tempDir = new PVector(random(-1, 1), random(-1,1));
      if(tempDir.x < 0.3 && tempDir.x > -0.3)
      {
        tempDir.x = random(0.4, 1);
      }
      
      if(tempDir.y < 0.3 && tempDir.y > -0.3)
      {
        tempDir.y = random(-0.4, -1);
      }
      // make sure the asteroids are always smaller than the one dieing.
      int tempSize = (int)random(ParentAsteroid.maxSize, ASTEROIDSIZE);
      //make the new asteroid.
      Asteroid tempAsteroid = new Asteroid(tempPos,tempDir,tempSize);
      // add it to the draw list.
      asteroids.add(tempAsteroid);
    }
  }
  
  
  /**************************************************************
* Method: DestroyAsteroids

* Parameters: None

* Returns: void 

* Desc: destroys the asteroid. 

***************************************************************/
  void DestoryAsteroids()
  {
    asteroids.clear();
  }
}