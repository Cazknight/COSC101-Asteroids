class Bullet_Manager
{
  PImage S_Shot = loadImage("SimpleShot.png");
  PImage P_Wave = loadImage("PulseWave.png");
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PVector tempPos;
  Bullet bullet;
  float tempDegrees;
  float tempRot;
  float bulletSpeed = 10;
  int fireMode = 1;
  
  void shotFired(int angle)
  {
    
    tempPos = new PVector(ship.pos.x+1,ship.pos.y);
    tempDegrees = ((ship.rotation*180)/PI)-angle;
    
    tempPos.x = tempPos.x +(cos(radians(tempDegrees))*30);
    tempPos.y = tempPos.y +(sin(radians(tempDegrees))*30);
    
    bullet = new Bullet(tempPos, tempDegrees);
    bullet.rot = ship.rotation;
    bullets.add(bullet);


  }
  
ArrayList UpdateBullets()
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      Bullet tempBullet = bullets.get(i);
      if(tempBullet.bulletType == 1 || tempBullet.bulletType == 3)
      {
        image(S_Shot, tempBullet.pos.x, tempBullet.pos.y);      
        tempBullet.pos.x += cos(radians(tempBullet.deg))*bulletSpeed;
        tempBullet.pos.y += sin(radians(tempBullet.deg))*bulletSpeed;
      }
      else if (tempBullet.bulletType == 2)
      {
        tempBullet.radius = 20;
        tempBullet.pos.x += cos(radians(tempBullet.deg))*bulletSpeed;
        tempBullet.pos.y += sin(radians(tempBullet.deg))*bulletSpeed;
        pushMatrix();
        translate(tempBullet.pos.x, tempBullet.pos.y);
        rotate(tempBullet.rot);      
        image(P_Wave, 0, 0, tempBullet.bWidth, tempBullet.bHeight);
        popMatrix();
        tempBullet.bWidth += .5;
        tempBullet.bHeight += .5;
      }
      
      // Remove bullets when they travel out of play area.
      if(tempBullet.pos.x < - 40 || tempBullet.pos.x > (width  + 40) ||
         tempBullet.pos.y < - 40 || tempBullet.pos.y > (height  + 40))
      {
        BM.bullets.remove(i);   
      }
  }
    return bullets;
  }
  
}
