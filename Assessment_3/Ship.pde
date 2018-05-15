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

 


class Ship
{
  //Constants
  
  //Variables
  PVector pos;
  float thrust = 0.15;
  float drag = 0.99;
  PVector velocity = new PVector(0,0);
  float rotation = 0.0;
  float angle;
  float radius = 28.75;
  boolean invunerable = false;
  
  
  /**************************************************************
* Method: InitializeShip

* Parameters: None

* Returns:  void

* Desc: spawns the ship

***************************************************************/
  public void InitializeShip()
  {
    pos = new PVector(width * 0.5,height * 0.5);
    angle = radians(5.0);
 
  }
  
  
  /**************************************************************
* Method: 

* Parameters: boolean array list Input

* Returns:  void

* Desc: updates the position of the ship relative to the users input via
* the keyboard. 

***************************************************************/
  public void UpdateShip(boolean[] Input)
  {
   
    // apply a drag, essentially just reducing our velocity by 0.01%;
    velocity.x *= drag;
    velocity.y *= drag;
    
    // add our velocity to the current position.
    pos.x += velocity.x;
    pos.y += velocity.y;


    
    // wrap the screen, if we go off one side, re-appear on the other.
    if(pos.x > width + 30)
    {
        pos.x = -30;
    }
    else if(pos.x < -30)
    {
        pos.x = width + 30;
    }
    
    if(pos.y > height + 30)
    {
        pos.y = -30;
    }
    else if(pos.y < -30)
    {
        pos.y = height + 30;
    }
   
    // apply rotation or thrust based on user input.
    if(Input[LEFT])
    {
        rotation -= angle;
    }
    
    if(Input[RIGHT])
    {
        rotation += angle;

    }
    
    if(Input[UP]) 
    {
        velocity.x += sin(rotation) * thrust;
        velocity.y -= cos(rotation) * thrust;
    }
    if(Input[DOWN])
    {
        velocity.x -= sin(rotation) * thrust;
        velocity.y += cos(rotation) * thrust;
    }

   
    // move the whole co-ordinate system to the ships location
    pushMatrix();
    translate(pos.x, pos.y);
    // rotate the co-ordinates so ship is facing right way.
    rotate(rotation);
    // draw the ship
    Anim.DrawShip(invunerable);
    popMatrix();
  }
}