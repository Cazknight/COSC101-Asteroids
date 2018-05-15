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

class Bullet_Manager
{
  PImage S_Shot = loadImage("SimpleShot.png");
  PImage P_Wave = loadImage("PulseWave.png");
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PVector tempPos;
  Bullet bullet;
  float tempDegrees;
  float tempRot;
  float bulletSpeed = 10;
  int fireMode = 1;

  /**************************************************************
* Method: shotFired

* Parameters: int angle - angle of the ship

* Returns: void 

* Desc: Takes the position of the ship and the ships angle, assigns it to
* a temporary variables. Then calls the bullet class and assigns the 
* temporary characteristics to the new bullet. 

***************************************************************/
  void shotFired(int angle)
  {
    
    tempPos = new PVector(ship.pos.x+1,ship.pos.y);
    tempDegrees = ((ship.rotation*180)/PI)-angle;
    
    tempPos.x = tempPos.x +(cos(radians(tempDegrees))*30);
    tempPos.y = tempPos.y +(sin(radians(tempDegrees))*30);
    
    bullet = new Bullet(tempPos, tempDegrees);
    bullet.rot = ship.rotation;
    bullets.add(bullet);

  }
  
  
  /**************************************************************
* Method: UpdateBullets

* Parameters: None

* Returns:  ArrayList - a list of bullets with their position and direction. 

* Desc: Takes each bullet in the array list, and updates their position according to
* their direction. They also destroy the bullets once off screen, so that arraylist
* is not overflooded with data, which may cause a crash. 

***************************************************************/
  ArrayList UpdateBullets()
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      Bullet tempBullet = bullets.get(i);
      if(tempBullet.bulletType == 1 || tempBullet.bulletType == 3)
      {
        image(tempBullet.bulletImg, tempBullet.pos.x, tempBullet.pos.y);      
        tempBullet.pos.x += cos(radians(tempBullet.deg))*bulletSpeed;
        tempBullet.pos.y += sin(radians(tempBullet.deg))*bulletSpeed;
      }
      else if (tempBullet.bulletType == 2)
      {
        tempBullet.radius = 20;
        tempBullet.pos.x += cos(radians(tempBullet.deg))*bulletSpeed;
        tempBullet.pos.y += sin(radians(tempBullet.deg))*bulletSpeed;
        pushMatrix();
        translate(tempBullet.pos.x, tempBullet.pos.y);
        rotate(tempBullet.rot);      
        image(tempBullet.bulletImg, 0, 0, tempBullet.bWidth, tempBullet.bHeight);
        popMatrix();
        tempBullet.bWidth += .5;
        tempBullet.bHeight += .5;
      }   

      if(tempBullet.pos.x > width + 50 | tempBullet.pos.x < -50)
      {
        DestroyBullet(i);
      }
      if(tempBullet.pos.y > height + 50 | tempBullet.pos.y < -50)
      {
        DestroyBullet(i);
      }
    }
    return bullets;
  }
  
  /**************************************************************
* Method: DestroyBullet 

* Parameters: int bulletIndex

* Returns:  void

* Desc: destroys the bullet that is in the array list. 

***************************************************************/
  void DestroyBullet(int bulletIndex)
  {
    if(bullets.size() != 0)
      bullets.remove(bulletIndex);
  }
  
}