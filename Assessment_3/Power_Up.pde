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



class Power_Up
{
  PVector pos = new PVector(0,0);
  boolean spawned;
  PImage p_up2 = loadImage("PowerUp01.png");
  PImage p_up3 = loadImage("PowerUp02.png");
  float radius = 15;
  int state;
  
  /**************************************************************
* Method: Spawn_Power_up

* Parameters: None

* Returns: void 

* Desc: spawns a power up at a random location, and sets characteristics

***************************************************************/
  void Spawn_Power_Up()
  { 
    pos.x = 1455;
    pos.y = random(200, 460);
    state = 2;
    spawned = false;    
  }
  
  
  /**************************************************************
* Method: Update_Power_Up

* Parameters: None

* Returns:  void

* Desc: updates the location of the power, and its state so that every
* time the a new draw method is run, the position is updated, providing
* the illusion of movement. 

***************************************************************/
  void Update_Power_Up()
  { 
    if(spawned == true)
    {
      pos.x -= 1.5;
      pos.y = 30*sin(pos.x/55)*5*cos(pos.x/78)*2*sin(pos.x/129) + height/2;
      if(pos.x < -40)
      {
        PU.Spawn_Power_Up();
      }
      if (pos.x % 150 == 0)
      {
        if(state == 2)
          state = 3;
        else if (state == 3)
          state = 2;
      }
      if (state == 2)
        image(p_up2, pos.x, pos.y, 25, 25);
      else if (state == 3)
        image(p_up3, pos.x, pos.y, 25, 25);
    }
  }
  
}