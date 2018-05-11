class Collision_Detection
{
  //Variables to determine distance between in game objects.
  float distance;
  float distanceX;
  float distanceY;
  
  void Update_Ship_Collision()
  {
    //Compare position of all spawned asteroids to position of ship based on the distance between them.
    //Circular hit boxes are used to appoximate the shape of the ship and asteroids.
    for (int i = 0; i < AM.asteroids.size(); i++)
    {
      Asteroid tempAsteroid = AM.asteroids.get(i);
      distanceX = ship.pos.x - tempAsteroid.pos.x;
      distanceY = ship.pos.y - tempAsteroid.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      //If distance between ship and asteroid is less than the sum of their respective radius,
      //collision is detected and ship reset, deduct a life and set alive status to false for respawn.
      if (distance <= ship.radius + tempAsteroid.radius)
      {
        BM.fireMode = 1;
        alive = false;
        lives--;
        ship.Reset_Ship();
      }
    }  
  }
  
  void Update_Missile_Collision()
  {
    for (int i = 0; i < AM.asteroids.size(); i++)
    {
      Asteroid tempAsteroid = AM.asteroids.get(i);
      for (int j = 0; j < BM.bullets.size(); j++)
      {
        Bullet tempBullet = BM.bullets.get(j);
        distanceX = tempBullet.pos.x - tempAsteroid.pos.x;
        distanceY = tempBullet.pos.y - tempAsteroid.pos.y;
        distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
        
        if (distance <= tempBullet.radius + tempAsteroid.radius)
        {
          AM.DestroyAsteroid(i);
          BM.bullets.remove(j);
        }
      }
    }  
  }
  
  void Update_Power_Up_Collision()
  {
    if(PU.spawned == true && alive == true)
    {
      distanceX = ship.pos.x - PU.pos.x;
      distanceY = ship.pos.y - PU.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      if (distance <= ship.radius + PU.radius)
      {
        if (PU.state == 2)
          BM.fireMode = 2;
        else if (PU.state == 3)
          BM.fireMode = 3;
        PU.Spawn_Power_Up();
      }
    }
  }
  
}
