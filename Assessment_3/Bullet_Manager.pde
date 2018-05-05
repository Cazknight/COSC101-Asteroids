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
      fill(0,255,0);
      ellipse(tempBullet.pos.x,tempBullet.pos.y,tempBullet.radius*2,tempBullet.radius*2);
      tempBullet.pos.x = tempBullet.pos.x+ +(cos(radians(tempBullet.deg))*bulletSpeed);
      tempBullet.pos.y = tempBullet.pos.y+ +(sin(radians(tempBullet.deg))*bulletSpeed);
    }
    return bullets;
  }
  
}
