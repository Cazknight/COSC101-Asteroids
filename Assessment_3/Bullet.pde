class Bullet
{
  PVector pos;
  PVector dir;
  float speed;
  float rot;
  float deg;
  float radius;
  float bWidth;
  float bHeight;
  int bulletType = 1;

  
  Bullet(PVector Position,float Degrees)
  {
    bulletType = BM.fireMode;
    radius = 2.5;
    pos = Position;
    speed = 6;
    deg = Degrees;
    bWidth = 30;
    bHeight = 15;
    
  }
}

 
