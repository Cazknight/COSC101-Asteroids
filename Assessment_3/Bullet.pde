class Bullet
{
  PVector pos;
  PVector dir;
  float speed;
  float deg;
  float radius;
  PImage bulletImg;

  Bullet(PVector Position,float Degrees)
  {
    radius = 2.5;
    pos = Position;
    speed = 6;
    deg = Degrees;
    bulletImg = loadImage("Bullet.png");
  }
}