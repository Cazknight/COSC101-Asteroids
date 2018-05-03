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
    
    tempPos = new PVector(ship.pos.x-1,ship.pos.y);
    bullet = new Bullet(tempPos, tempRot);
    bullets.add(bullet);
    println(tempRot);
    println(radians(55));

  }
  
ArrayList UpdateBullets()
  {
    for(int i = 0; i < bullets.size(); i++)
    {
      Bullet tempBullet = bullets.get(i);
      //need to have a circle around the ship, and use the radius of the circle to 
      //find the location of where the bullet is to be drawn
      //using the rotation of the ship as a factor of where on the circles circumference
      //the bullet will be drawn.
      fill(0,255,0);
      rect(tempBullet.pos.x,tempBullet.pos.y,5,20);
    }
    return bullets;
  }
  
}
