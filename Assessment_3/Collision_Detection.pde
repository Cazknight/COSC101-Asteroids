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

class Collision_Detection
{
  float distance;
  float distanceX;
  float distanceY;
  SoundFile explosion;

  Collision_Detection(processing.core.PApplet _papplet)
  {
    explosion = new SoundFile(_papplet, "explosion.mp3");
  }
  
  
  /**************************************************************
* Method: Update_ship_Collision

* Parameters: None

* Returns:  void

* Desc: Checks if the ship is vulnerable, if it is, this method will
* check if a asteroid's location is in the vicinity of the ship, if it is
* it will update the status of the ship to false. Playing the explosion. 

***************************************************************/
  void Update_Ship_Collision()
  {
    if(ship.invunerable)
    {
      return;
    }
    for (int i = 0; i < AM.asteroids.size(); i++)
    {
      Asteroid tempAsteroid = AM.asteroids.get(i);
      distanceX = ship.pos.x - tempAsteroid.pos.x;
      distanceY = ship.pos.y - tempAsteroid.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      if (distance <= ship.radius + tempAsteroid.radius)
      {
        BM.fireMode = 1;
        alive = false;
        lives--;
        Anim.ExplodeShip(ship.pos);
        explosion.play();
        ship.pos.x = width * 0.5;
        ship.pos.y = height * 0.5;
        ship.velocity.x = 0;
        ship.velocity.y = 0;
      }
    }  
  }
  
  
  /**************************************************************
* Method: Update_Missile_Collision

* Parameters: Animator Anim - takes the class Anim

* Returns: integer score - returns the curent score of the user

* Desc: This method checks the location of the bullet, plus the location of
* an asteroid, if they are in the same vicinity, then asteroid and bullet
* are destroyed, the score is updated. 

***************************************************************/
  int Update_Missile_Collision(Animator Anim)
  {
    for (int i = 0; i < AM.asteroids.size(); i++)
    {
      Asteroid tempAsteroid = AM.asteroids.get(i);
      for (int j = 0; j < BM.bullets.size(); j++)
      {
        Bullet tempBullet = BM.bullets.get(j);
        distanceX = tempBullet.pos.x - tempAsteroid.pos.x;
        distanceY = tempBullet.pos.y - tempAsteroid.pos.y;
        distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
        
        if (distance <= tempBullet.radius + tempAsteroid.radius)
        {
          explosion.play();
          BM.DestroyBullet(j);
          AM.DestroyAsteroid(i);
          Anim.AddExplosionAnimation(tempAsteroid.pos);
          score = tempAsteroid.size * 10;
          return score;
        }
      }
    }  
    
    return 0;
  }
  
  
  /**************************************************************
* Method: Update_Power_Up_Collision

* Parameters: None

* Returns: void 

* Desc: Checks the location of the ship and the location of the powerup
* if collision has occured, it will activate the power up. 

***************************************************************/
  void Update_Power_Up_Collision()
  {
    if(PU.spawned == true && alive == true)
    {
      distanceX = ship.pos.x - PU.pos.x;
      distanceY = ship.pos.y - PU.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      if (distance <= ship.radius + PU.radius)
      {
        if (PU.state == 2)
          BM.fireMode = 2;
        else if (PU.state == 3)
          BM.fireMode = 3;
        PU.Spawn_Power_Up();
      }
    }
  }
  
}