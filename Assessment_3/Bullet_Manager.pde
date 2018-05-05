class Bullet_Manager
{
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PVector tempDir;
  PVector tempPos;
  float tempRot;
  Bullet bullet;
  int shots = 0;
  
  void shotFired()
  {
    
    bullet = new Bullet(ship.pos, ship.rotation);
    bullets.add(bullet);
    //println(tempRot);
    //println(radians(55));

  }
  
ArrayList UpdateBullets()
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      Bullet tempBullet = bullets.get(i);
      tempBullet.pos.x += tempBullet.dir.x;
      tempBullet.pos.y += tempBullet.dir.y;
      image(tempBullet.bulletImg, tempBullet.pos.x, tempBullet.pos.y);
      
      if(tempBullet.pos.x > width + 50 | tempBullet.pos.x < -50)
      {
        DestroyBullet(i);
      }
      if(tempBullet.pos.y > height + 50 | tempBullet.pos.y < -50)
      {
        DestroyBullet(i);
      }
      //need to have a circle around the ship, and use the radius of the circle to 
      //find the location of where the bullet is to be drawn
      //using the rotation of the ship as a factor of where on the circles circumference
      //the bullet will be drawn.
      //fill(0,255,0);
      //rect(tempBullet.pos.x,tempBullet.pos.y,5,20);
    }
    return bullets;
  }
  
  void DestroyBullet(int bulletIndex)
  {
    bullets.remove(bulletIndex);
  }
  
}