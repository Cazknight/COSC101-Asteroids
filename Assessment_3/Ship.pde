class Ship
{
  PVector pos;
  float thrust = 0.15;
  float drag = 0.99;
  PVector velocity = new PVector(0,0);
  float rotation = 0.0;
  float angle;
  PImage shipImage = loadImage("Ship.png");
  PVector[] shotsFired = {}; 
  PVector shot;
  float[] shot_x = new float[0];
  float[] shot_y = new float[0];
  float[] shot_x_dir = new float[0];
  float[] shot_y_dir = new float[0];
  float[] shot_rotation = new float[0];

  
  
  
  public void InitializeShip()
  {
    pos = new PVector(width * 0.5,height * 0.5);
    angle = radians(5.0);
 
  }
  
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

   
    // move the co-ordinates to the ships location
    translate(pos.x, pos.y);
    // rotate the co-ordinates so ship is facing right way.
    rotate(rotation);
    // draw the ship
    shipImage.resize(55,70);
    image(shipImage,-shipImage.width/2,-shipImage.height/2);
  }
  
  public void shotArray()
  {
    for(int i = 0; i < shot_x.length; i++)
    {
      stroke(0,255,0);
      rect(shot_x[i], shot_y[i], 5, 20);
      
      println("x: " + shot_x[i] +" y: " + shot_y[i] + " rotation: " + shot_rotation[i]);
    }
  }
  
  public void fireWeapons()
  {
    //#Zach Comments
    //okay so this does actually work, except it wont work with the values you are using.
    //because the position you are referencing is position of the ship prior to the
    //translation. once the translate function has been called (line 83) the co-ordinate
    //system is actually moved to the ships position.
    // therefore the bullets will be offset by pos.x and pos.y. the ships position is 
    // actually 0,0 once the translate has occured.
    // you can see this in action if you change pos.x and pos.y below to 0
    // the bullet will fly around just like the ship.
    // also you arent puting the value of pos.x and pos.y into the array, you are
    // just referencing them, meaning when you move the ship these values will change
    // and affect your bullet.
    // you can see this now, if you fly your ship to the top left hand corner and fire a bullet should
    // appear, if you then move again the bullet will move with you.
    
    // i would also use an PVector ArrayList for this, rather than floats and normal arrays.
    // i see you have declared an empty Pvector array above, but didnt use it?
    
    // i had very similiar issues to these when i was working with my own implementation.
    // i would be creating a seperate class to hold the bullet data and everytime you shoot.
    // create a new instance of that class, load it with the data at the time of firing.
    
    // hopefully this makes sense... im not a teacher. hit me up if i have explained
    // something badly.
    shot_x = append(shot_x, 0);
    shot_y = append(shot_y, 0);
    
    shot_rotation = append(shot_rotation, rotation);
    
    
    
    println("x: " + shot_x +" y: " + shot_y + " rotation: " + shot_rotation);
    
    shoot = false;
    
  }
      
    
  

}