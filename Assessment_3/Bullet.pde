class Bullet
{
  PVector pos;
  PVector dir;
  float speed;
  float rot;
  PImage bulletImg;


  Bullet(PVector Position, float Rotation)
  {
    bulletImg = loadImage("Bullet.png");
    pos = new PVector(Position.x, Position.y);
    speed = 20;
    rot = Rotation + radians(-90);
    
    dir = new PVector(cos(rot) * speed, sin(rot) * speed);
    dir.x += ship.velocity.x;
    dir.y += ship.velocity.y;

  }
}
//{
//  PVector[] shotsFired = {}; 
//  PVector shot;
//  float dir;
  
//  void shotTaken()
//  {
    
    
    
//  }

  
  
  
  
//}

  //public void shotArray()
  //{
  //  for(int i = 0; i < shotsFired.length; i++)
  //  {
  //    fill(0,255,0);
  //    rect(shot.x,shot.y,5,20);
      
  //  }

      
  //}
  
  //public void fireWeapons()
  //{
  //  shot = new PVector (-4,-38,rotation);
  //  translate(shot.x,shot.y);
  //  shotsFired = (PVector[]) append(shotsFired,shot);
    
  //  println(shotsFired);
    
  //  //#Zach Comments
  //  //okay so this does actually work, except it wont work with the values you are using.
  //  //because the position you are referencing is position of the ship prior to the
  //  //translation. once the translate function has been called (line 83) the co-ordinate
  //  //system is actually moved to the ships position.
  //  // therefore the bullets will be offset by pos.x and pos.y. the ships position is 
  //  // actually 0,0 once the translate has occured.
  //  // you can see this in action if you change pos.x and pos.y below to 0
  //  // the bullet will fly around just like the ship.
  //  // also you arent puting the value of pos.x and pos.y into the array, you are
  //  // just referencing them, meaning when you move the ship these values will change
  //  // and affect your bullet.
  //  // you can see this now, if you fly your ship to the top left hand corner and fire a bullet should
  //  // appear, if you then move again the bullet will move with you.
    
  //  // i would also use an PVector ArrayList for this, rather than floats and normal arrays.
  //  // i see you have declared an empty Pvector array above, but didnt use it?
    
  //  // i had very similiar issues to these when i was working with my own implementation.
  //  // i would be creating a seperate class to hold the bullet data and everytime you shoot.
  //  // create a new instance of that class, load it with the data at the time of firing.
    
  //  // hopefully this makes sense... im not a teacher. hit me up if i have explained
  //  // something badly.

    
    
    

    
  //  shoot = false;
    
  //}