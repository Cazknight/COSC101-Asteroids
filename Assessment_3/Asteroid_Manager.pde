class Asteroid_Manager
{
  ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
  int asteroidMultiplier = 3;
  int i;
  
  Asteroid_Manager(int Level)
  {
    InitializeAsteroids(Level);
  }
  
  void InitializeAsteroids(int Level)
  {
    int asteroidQuantity = (Level + asteroidMultiplier) * asteroidMultiplier;
    asteroids.clear();
    
    for(i = 0; i < asteroidQuantity; i++)
    {
      PVector tempPos = new PVector(random(0, width), random(0, height));
      PVector tempDir = new PVector(random(-1, 1), random(-1,1));
      int tempSize = (int)random(0, 2.99);
      Asteroid tempAsteroid = new Asteroid(tempPos, tempDir, tempSize);
      asteroids.add(tempAsteroid);
    }
  }
  
  ArrayList UpdateAsteroids()
  {
    for(i = 0; i < asteroids.size(); i++)
    {
      Asteroid tempAsteroid = asteroids.get(i);

      tempAsteroid.pos.x += tempAsteroid.dir.x * tempAsteroid.speed;
      tempAsteroid.pos.y += tempAsteroid.dir.y * tempAsteroid.speed;
   
      AsteroidScreenWrap(tempAsteroid);

      image(tempAsteroid.currentImg, tempAsteroid.pos.x,tempAsteroid.pos.y);
    }
    // loop through the asteroids and update there positions
    // then draw the asteroids.
    // return an up to date list of all the asteroids.
    return asteroids;
  }
  
  void DestroyAsteroid(int AsteroidIndex)
  {
    
    Asteroid tempAsteroid = asteroids.get(AsteroidIndex);
    
    if(tempAsteroid.size < 4)
    {
      int childrenToSpawn = (int)random(1,5);
      int maxSize = tempAsteroid.size + 1;
      SpawnAsteroids(childrenToSpawn, tempAsteroid, maxSize);
      asteroids.remove(AsteroidIndex);
    }
    else
    {
      asteroids.remove(AsteroidIndex);
    } 
  }
  
  void AsteroidScreenWrap(Asteroid AsteroidToWrap)
  {
      if(AsteroidToWrap.pos.x > width + AsteroidToWrap.currentImg.width)
      {
        AsteroidToWrap.pos.x = -AsteroidToWrap.currentImg.width;
      }
      else if(AsteroidToWrap.pos.x < -AsteroidToWrap.currentImg.width)
      {
        AsteroidToWrap.pos.x = width + AsteroidToWrap.currentImg.width;
      }
    
      if(AsteroidToWrap.pos.y > height + AsteroidToWrap.currentImg.height)
      {
        AsteroidToWrap.pos.y = -AsteroidToWrap.currentImg.height;
      }
      else if(AsteroidToWrap.pos.y < -AsteroidToWrap.currentImg.height)
      {
        AsteroidToWrap.pos.y = height + AsteroidToWrap.currentImg.height;
      }
  }
  
  void SpawnAsteroids(int Quantity, Asteroid ParentAsteroid, int MaxSize)
  {
    
    for(i = 0; i < Quantity; i++)
    {
      PVector tempPos = new PVector(random(ParentAsteroid.pos.x, ParentAsteroid.pos.x + ParentAsteroid.currentImg.width), random(ParentAsteroid.pos.y, ParentAsteroid.pos.y + ParentAsteroid.currentImg.height));
      PVector tempDir = new PVector(random(-1, 1), random(-1,1));
      int tempSize = (int)random(MaxSize, 4);
      Asteroid tempAsteroid = new Asteroid(tempPos,tempDir,tempSize);
      asteroids.add(tempAsteroid);
    }
  }
}