class Collision_Detection
{
  float distance;
  float distanceX;
  float distanceY;
  
  void Update_Ship_Collision()
  {
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
        ship.pos.x = width * 0.5;
        ship.pos.y = height * 0.5;
        ship.velocity.x = 0;
        ship.velocity.y = 0;
        println(lives);
      }
    }  
  }
  
  void Update_Missile_Collision()
  {
    //TODO...
  }
  
}
