class Bullet_Manager
{
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PVector tempDir;
  PVector tempPos;
  float tempRot;
  Bullet bullet;
  int shots = 0;
  float bulletRot;
  float tempDegrees;
  
  void shotFired()
  {
    
    tempPos = new PVector(ship.pos.x,ship.pos.y);
    tempDegrees = (ship.rotation*180)/PI;
    
    
    bullet = new Bullet(tempPos, tempDegrees);
    bullets.add(bullet);
    
    println(tempDegrees);


  }
  
ArrayList UpdateBullets()
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      Bullet tempBullet = bullets.get(i);
      float angle = tempBullet.deg;
      
      angle = radians(angle);
      rotate(angle);
      fill(0,255,0);
      rectMode(CENTER);
      rect(tempBullet.pos.x+1,tempBullet.pos.y-25,5,20);
    }
    return bullets;
  }
  
}
