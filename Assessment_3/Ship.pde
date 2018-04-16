class Ship
{
  PVector pos;
  float thrust = 0.08;
  float drag = 0.99;
  PVector velocity = new PVector(0,0);;
  float rotation = 0.0;
  float angle;
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
        velocity.x += cos(rotation) * thrust;
        velocity.y += sin(rotation) * thrust;
    }

   
    // move the co-ordinates to the ships location
    translate(pos.x, pos.y);
    // rotate the co-ordinates so ship is facing right way.
    rotate(rotation);
    // draw the ship
    stroke(255);
    fill(0);
    triangle(-30, -15, 20, 0, -30, 15);
  }
}