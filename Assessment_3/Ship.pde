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
    }
  }
  
  public void fireWeapons()
  {
    shot_x = append(shot_x, pos.x);
    shot_y = append(shot_y, pos.y);
    shot_rotation = append(shot_rotation, rotation);
    
    
    
    println("x: " + shot_x +" y: " + shot_y + " rotation: " + shot_rotation);
    
    shoot = false;
    
    

    
    
  }
      
    
  

}
