/**************************************************************
* File(s): Assessment_3.pde, Animator.pde, Asteroid.pde, Asteroid_Manager.pde, Bullet.pde, 
*          Bullet_Manager.pde, Collision_Detection.pde, Game_States.pde, Power_Up.pde,
*          Ship.pde, Asteroid_#.png (# representing 0 to 8), Background.jpg, Bullet.png, 
*          Controls.png, Credits.png, CreditScreen.png, Exit.png, GameOver.png,
*          explosion_#.png (# representing 0 to 5), GetReady.png, Heart.png, HighscoreButton.png,
*          HighscoreTitle.png, Name.png, NameScore.png, NewRound.png, PowerUp01.png, PowerUp02.png,
*          PulseWave.png, Ship_0.png, Ship_1.png, ShipExplosion_#.png (# representing 0 to 9),
 *         SimpleShot.png, Start.png, Title.png.
* Authors: Zach Thompson, Peter Chung and Bart Stolarek
* Date: 13/05/2018
* Course: COSC101 - Software Development Studio 1
* 
* Desc: Video game called Asteroids, loosely based on the original Asteroids game developed
* in 1979. User uses a GUI where they provide input to the game via controls, and control a 
* ship thats objective is to destroy all the Asteroids in that round, as well as avoid 
* colliding with any of the Asteroids. The user has 3 lives/chances, with each destruction
* of an asteroid awarding the user with points towards the score. The 10 highest scores
* of all time are displayed for the next user to see
*
* Usage: Make sure to run in the processing environment and press play.
* You will need a working keyboard that is connected to your PC, working arrow keys and spacebar
* on that keyboard. Use those keys to move the ship in the direction you want to, and the spacebar
* to shoot the weapon on the ship.
* 
**************************************************************/

import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;


class Highscores
{
  
 String user = "sql12236006";
 String pass = "GewbCLRZnV";
 String db = "sql12236006";
 String host = "sql12.freemysqlhosting.net";
 
 MySQL dbConnection;
 
 /**************************************************************
* Constructor: Highscores

* Parameters: processing.core.PApplet _papplet

* Returns:  a new MySQL

* Desc: creates a connection to MySQL to have a database of highscorers.

***************************************************************/
 
 Highscores(processing.core.PApplet _papplet)
 {
   dbConnection = new MySQL(_papplet, host, db, user, pass);
 }
 
 /**************************************************************
* Method: HighscoreConnect

* Parameters: None

* Returns:  returns boolean

* Desc: checks for connection between MySQL and the game. 

***************************************************************/
 
 boolean HighscoreConnect()
 {
   if(dbConnection.connect())
   {
     return true;
   }
   else
   {
     return false;
   }
 }
 
 
 /**************************************************************
* Method: GetNames

* Parameters: None

* Returns: StringList Names - list of names

* Desc: Pulls the names of all highscorers, by order
* of score. 

***************************************************************/
 StringList GetNames()
 {
   int counter = 0;
   StringList Names = new StringList();
   dbConnection.query("SELECT * FROM `Highscores` ORDER BY `Score` DESC");
   while(dbConnection.next() && counter < 10)
   {
     Names.append(dbConnection.getString("Name"));
     counter += 1;
   }
   return Names;
 }
 
 
 /**************************************************************
* Method: GetScores

* Parameters: None

* Returns:  IntList - list of scores

* Desc: Pulls the score of all highscorer, by order of score

***************************************************************/
 IntList GetScores()
 {
   int counter = 0;
   IntList Scores = new IntList();
   dbConnection.query("SELECT * FROM `Highscores` ORDER BY `Score` DESC");
   while(dbConnection.next() && counter < 10)
   {
     Scores.append(dbConnection.getInt("Score"));
     counter += 1;
   }
   return Scores;
 }
 
 /**************************************************************
* Method: UpdateHighscores

* Parameters: String newName, integer newScore

* Returns:  void

* Desc: updates the highscore list with the current score of the user. 

***************************************************************/
 void UpdateHighscores(String newName, int newScore)
 {
   dbConnection.query("INSERT INTO `Highscores`(`Name`, `Score`) VALUES ('%s',%d)", newName, newScore);
 }

}