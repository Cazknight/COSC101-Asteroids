class Collision_Detection
{
  float distance;
  float distanceX;
  float distanceY;
  SoundFile explosion;
  
  Collision_Detection(processing.core.PApplet _papplet)
  {
    explosion = new SoundFile(_papplet, "explosion.mp3");
  }
  
  void Update_Ship_Collision()
  {
    if(ship.invunerable)
    {
      return;
    }
    for (int i = 0; i < AM.asteroids.size(); i++)
    {

      
      Asteroid tempAsteroid = AM.asteroids.get(i);
      distanceX = ship.pos.x - tempAsteroid.pos.x;
      distanceY = ship.pos.y - tempAsteroid.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      if (distance <= ship.radius + tempAsteroid.radius)
      {
        alive = false;
        lives--;
        Anim.ExplodeShip(ship.pos);
        explosion.play();
        ship.pos.x = width * 0.5;
        ship.pos.y = height * 0.5;
        ship.velocity.x = 0;
        ship.velocity.y = 0;

      }
    }  
  }
  
  int Update_Missile_Collision(Animator Anim)
  {
    int score;
    
    if(BM.bullets.size() == 0 | AM.asteroids.size() == 0)
    {
      return 0;
    }
    
    for(int i = 0; i < AM.asteroids.size(); i++)
    {
      
      for(int ii = 0; ii < BM.bullets.size(); ii++)
      {
        Asteroid tempAsteroid = AM.asteroids.get(i);
        Bullet tempBullet = BM.bullets.get(ii);
        
        if(dist(tempAsteroid.pos.x, tempAsteroid.pos.y, tempBullet.pos.x, tempBullet.pos.y) <= tempAsteroid.radius + 16.0) //<>//
        {
          explosion.play();
          BM.DestroyBullet(ii);
          AM.DestroyAsteroid(i);
          Anim.AddExplosionAnimation(tempAsteroid.pos);
          score = tempAsteroid.size * 10;
          return score;
        }
      }
    }
    return 0;
  }
  
}