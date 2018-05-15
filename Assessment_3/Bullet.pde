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

class Bullet
{
  PVector pos;
  PVector dir;
  float speed;
  float deg;
  float rot;
  float radius;
  PImage bulletImg;
  float bWidth;
  float bHeight;
  int bulletType = 1;

/**************************************************************
* Constructor: Bullet

* Parameters: PVector Position, float Degrees

* Returns:  

* Desc: sets the characterists of the bullet as well as loading the 
* bullet image. 

***************************************************************/
  Bullet(PVector Position,float Degrees)
  {
    bulletType = BM.fireMode;
    radius = 2.5;
    pos = Position;
    speed = 6;
    deg = Degrees;
    bWidth = 30;
    bHeight = 15;
    if(bulletType == 1 || bulletType == 3)
      bulletImg = loadImage("SimpleShot.png");
    else if(bulletType == 2)
      bulletImg = loadImage("PulseWave.png");
  }
}