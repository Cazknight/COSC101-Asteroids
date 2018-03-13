float posX, posY; //<>//
float thrust = 0.08;
float drag = 0.99;
float velocityX = 0;
float velocityY = 0;
float rotation = 0.0;
float angle;
boolean[] keyIsPressed = new boolean[256];
 
void setup() {
    size(600, 600);
    frameRate(30);
    
    posX = width * 0.5;
    posY = height * 0.5;
    angle = radians(5.0);
}
 
void draw() {
    // apply a drag, essentially just reducing our velocity by 0.01%;
    velocityX *= drag;
    velocityY *= drag;
    
    // add our velocity to the current position.
    posX += velocityX;
    posY += velocityY;
    
    // wrap the screen, if we go off one side, re-appear on the other.
    if(posX > width + 30)
    {
        posX = -30;
    }
    else if(posX < -30)
    {
        posX = width + 30;
    }
    
    if(posY > height + 30)
    {
        posY = -30;
    }
    else if(posY < -30)
    {
        posY = height + 30;
    }
   
    // apply rotation or thrust based on user input.
    if(keyIsPressed[LEFT])
    {
        rotation -= angle;
    }
    if(keyIsPressed[RIGHT])
    {
        rotation += angle;
    }
    if(keyIsPressed[UP]) 
    {
        velocityX += cos(rotation) * thrust;
        velocityY += sin(rotation) * thrust;
    }
    if(keyIsPressed[DOWN]) 
    {
        velocityX -= cos(rotation) * thrust;
        velocityY -= sin(rotation) * thrust;
    }
    // clear the screen.
    background(255);
    // move the co-ordinates to the ships location
    translate(posX, posY);
    // rotate the co-ordinates so ship is facing right way.
    rotate(rotation);
    // draw the ship
    triangle(-30, -20, 20, 0, -30, 20);
 
}
 
void keyPressed() 
{
    keyIsPressed[keyCode] = true;
}
 
void keyReleased() 
{
    keyIsPressed[keyCode] = false;
}