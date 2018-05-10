class Bullet_Manager
{
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PVector tempPos;
  Bullet bullet;
  float tempDegrees;
  float bulletSpeed = 10;

  
  void shotFired()
  {
    
    tempPos = new PVector(ship.pos.x+1,ship.pos.y);
    tempDegrees = ((ship.rotation*180)/PI)-90;
    
    tempPos.x = tempPos.x +(cos(radians(tempDegrees))*30);
    tempPos.y = tempPos.y +(sin(radians(tempDegrees))*30);
    
    bullet = new Bullet(tempPos, tempDegrees);
    bullets.add(bullet);

  }
  
ArrayList UpdateBullets()
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      Bullet tempBullet = bullets.get(i);
      tempBullet.pos.x = tempBullet.pos.x+ +(cos(radians(tempBullet.deg))*bulletSpeed);
      tempBullet.pos.y = tempBullet.pos.y+ +(sin(radians(tempBullet.deg))*bulletSpeed);
      image(tempBullet.bulletImg, tempBullet.pos.x, tempBullet.pos.y);
      
      if(tempBullet.pos.x > width + 50 | tempBullet.pos.x < -50)
      {
        DestroyBullet(i);
      }
      if(tempBullet.pos.y > height + 50 | tempBullet.pos.y < -50)
      {
        DestroyBullet(i);
      }
    }
    return bullets;
  }
  
  void DestroyBullet(int bulletIndex)
  {
    bullets.remove(bulletIndex);
  }
  
}