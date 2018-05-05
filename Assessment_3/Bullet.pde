class Bullet
{
  PVector pos;
  PVector dir;
  float speed;
  float rot;
  float deg;
  float radius;


  
  Bullet(PVector Position,float Degrees)
  {
    radius = 2.5;
    pos = Position;
    speed = 6;
    deg = Degrees;
    
  }
}
