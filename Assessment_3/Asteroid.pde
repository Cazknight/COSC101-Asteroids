class Asteroid{
  PVector pos;
  PVector dir;
  PImage[] asteroidImgs = new PImage[5];
  PImage currentImg;
  float collisionRadius;
  float asteroidCentre;
  float speed;
  int size;
  int i;
  
  Asteroid(PVector Position, PVector Direction, int Size)
  {
    pos = Position;
    dir = Direction;
    size = Size;
    speed = random(2,5);
    for(i = 0; i < asteroidImgs.length; i++)
    {
      asteroidImgs[i] = loadImage("Asteroid_" + i + ".png");
    }
    currentImg = asteroidImgs[size];
  }
}