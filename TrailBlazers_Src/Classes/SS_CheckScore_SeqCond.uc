// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Creating the node to check the player time at the end of the level for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_CheckScore_SeqCond extends SequenceCondition;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
// Vars to check the player score against
var() int Gold;
var() int Silver;
var() int Bronze;

var int convert;
var int totalTime;
var string levelBeatMapName;
//---------------------------------------------------------------------------------------------------------------\\
// Enums
// To states the player can have
enum ScoreCheckOuts
{
	SCO_Gold,
	SCO_Silver,
	SCO_Bronze,
	SCO_Lost
};
//---------------------------------------------------------------------------------------------------------------\\
// Functions
function convertTime()
{
	local SS_Gametype rGame;
	local WorldInfo rWorld;
	
	// Used to gain access to the world info of the game
	rWorld = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorld != none )
	{
		// Used to gain access to the totalStamina variable in the game
		rGame = SS_Gametype (rWorld.Game);
		// Check to make sure we have access to the variable
		if ( rGame != none )
		{
			if(rGame.CountDownTMR.Min >= 1)
			{
				convert = rGame.CountDownTMR.Min * 60;
			}
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
// Events
event Activated()
{
	local SS_Gametype rGame;
	local WorldInfo rWorld;

        //might want to add this to gametype to have it used global
     
	convertTime();
	//savePCVariables();

	// Used to gain access to the world info of the game
	rWorld = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorld != none )
	{
		// Used to gain access to the totalStamina variable in the game
		rGame = SS_Gametype (rWorld.Game);
		
		// Check to make sure we have access to the variable
		if ( rGame != none )
		{
			totalTime = convert + rGame.CountDownTMR.Sec;
			//Test to see if player has reached the score to win or lose

			//Get the name of the map that was just completed
				levelBeatMapName = rWorld.GetMapName(false);

				//check level name that was complete, set the arrays to show what level has been beat
				

				//Need to add rest of levels.
				if(levelBeatMapName == "SS_Level_1")
				{
					rGame.coffeeMugCount = 1;
					
				}

                  if(levelBeatMapName == "SS_Level_2")
				{
					rGame.coffeeMugCount = 2;
					
				}

				  if(levelBeatMapName == "SS_Level_3")
				{
					rGame.coffeeMugCount = 3;
					
				}

				  if(levelBeatMapName == "SS_Level_4")
				{
					rGame.coffeeMugCount = 4;
					
				}

				  if(levelBeatMapName == "SS_Level_5")
				{
					rGame.coffeeMugCount = 5;
					
				}

				  if(levelBeatMapName == "SS_Level_6")
				{
					rGame.coffeeMugCount = 6;
					
				}

				  if(levelBeatMapName == "SS_Level_7")
				{
					rGame.coffeeMugCount = 7;
					
				}

				  if(levelBeatMapName == "SS_Level_8")
				{
					rGame.coffeeMugCount = 8;
					
				}

				  if(levelBeatMapName == "SS_Level_9")
				{
					rGame.coffeeMugCount = 9;
					
				}

				  if(levelBeatMapName == "SS_Level_10")
				{
					rGame.coffeeMugCount = 10;
					
				}

			if(totalTime >= Gold)
			{
				OutputLinks[SCO_Gold].bHasImpulse = true;
				rGame.ClearTimer( 'CheckTimer' );


			}

			if(totalTime >= Silver && totalTime < Gold)

			{
				OutputLinks[SCO_Silver].bHasImpulse = true;
				rGame.ClearTimer( 'CheckTimer' );

			}

			if(totalTime >= Bronze && totalTime < Silver && totalTime < Gold)

			{
				OutputLinks[SCO_Bronze].bHasImpulse = true;
				rGame.ClearTimer( 'CheckTimer' );

			}

				






		/*


				//level 1
				
				//This was changed so it would not allow medals when beating other levels be added because
				//that level was beat, but might use that var for menu system if we want to make it so the player has to
				//beat level to open other. 

				//if( rGame.levelbeat[0] == true && rGame.lvlNotBeatGold[0] != false)


				//Level 1
				if(levelBeatMapName == "SS_Level_1" && rGame.lvlNotBeatGold[0] != false)
				{
					`log(rGame.lvlNotBeatBronze[0]);


					if(rGame.lvlNotBeatSilver[0] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[0] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				// add to the metal count
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				//Set it to false since the level has been beat on gold
				rGame.lvlNotBeatGold.InsertItem(0,false);

				//Save the scores
//				saveHighScore();
				}
                                
                //level 2

				if(levelBeatMapName == "SS_Level_2" && rGame.lvlNotBeatGold[1] != false)
				{
				
					if(rGame.lvlNotBeatSilver[1] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[1] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}

				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(1,false);
				//saveHighScore();
				}

				               //level 3

				if(levelBeatMapName == "SS_Level_3" && rGame.lvlNotBeatGold[2] != false)
				{
				
					
					if(rGame.lvlNotBeatSilver[2] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[2] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}

				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(2,false);
				//saveHighScore();
				}

				               //level 4

				if(levelBeatMapName == "SS_Level_4" && rGame.lvlNotBeatGold[3] != false)
				{
				
					if(rGame.lvlNotBeatSilver[3] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[3] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(3,false);
				//saveHighScore();
				}

				               //level 5

				if(levelBeatMapName == "SS_Level_5" && rGame.lvlNotBeatGold[4] != false)
				{

					if(rGame.lvlNotBeatSilver[4] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[4] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(4,false);
			//	saveHighScore();
				}

				               //level 6

				if(levelBeatMapName == "SS_Level_6" && rGame.lvlNotBeatGold[5] != false)
				{

					if(rGame.lvlNotBeatSilver[5] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[5] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(5,false);
			//	saveHighScore();
				}

				               //level 7

				if(levelBeatMapName == "SS_Level_7" && rGame.lvlNotBeatGold[6] != false)
				{

					if(rGame.lvlNotBeatSilver[6] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[6] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(6,false);
			//	saveHighScore();
				}

				               //level 8

				if(levelBeatMapName == "SS_Level_8" && rGame.lvlNotBeatGold[7] != false)
				{

					if(rGame.lvlNotBeatSilver[7] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[7] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(7,false);
				//saveHighScore();
				}

				               //level 9

				if(levelBeatMapName == "SS_Level_9" && rGame.lvlNotBeatGold[8] != false)
				{

					if(rGame.lvlNotBeatSilver[8] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[8] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
				
				rGame.lvlNotBeatGold.InsertItem(8,false);
				//saveHighScore();
				}

				               //level 10

				if(levelBeatMapName == "SS_Level_10" && rGame.lvlNotBeatGold[9] != false)
				{

					if(rGame.lvlNotBeatSilver[9] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[9] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(9,false);
				//saveHighScore();
				}

				               //level 11

				if(levelBeatMapName == "SS_Level_11" && rGame.lvlNotBeatGold[10] != false)
				{

					if(rGame.lvlNotBeatSilver[10] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[10] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(10,false);
				//saveHighScore();
				}

				               //level 12

				if(levelBeatMapName == "SS_Level_12" && rGame.lvlNotBeatGold[11] != false)
				{
				
					if(rGame.lvlNotBeatSilver[11] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[11] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(11,false);
				//saveHighScore();
				}

				               //level 13

				if(levelBeatMapName == "SS_Level_13" && rGame.lvlNotBeatGold[13] != false)
				{
				
					if(rGame.lvlNotBeatSilver[12] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[12] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(13,false);
				//saveHighScore();
				}

				               //level 14

				if(levelBeatMapName == "SS_Level_14" && rGame.lvlNotBeatGold[13] != false)
				{

					if(rGame.lvlNotBeatSilver[13] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[13] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
	
				rGame.lvlNotBeatGold.InsertItem(13,false);
				//saveHighScore();
				}

				               //level 15

				if(levelBeatMapName == "SS_Level_15" && rGame.lvlNotBeatGold[14] != false)
				{
				
					if(rGame.lvlNotBeatSilver[14] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[14] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(14,false);
				//saveHighScore();
				}


				               //level 16

				if(levelBeatMapName == "SS_Level_16" && rGame.lvlNotBeatGold[15] != false)
				{

					if(rGame.lvlNotBeatSilver[15] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[15] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(15,false);
				//saveHighScore();
				}

				               //level 17

				if(levelBeatMapName == "SS_Level_17" && rGame.lvlNotBeatGold[16] != false)
				{

					if(rGame.lvlNotBeatSilver[16] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[16] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(16,false);
				//saveHighScore();
				}

				               //level 18

				if(levelBeatMapName == "SS_Level_18" && rGame.lvlNotBeatGold[17] != false)
				{
				

					if(rGame.lvlNotBeatSilver[17] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[17] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(17,false);
				//saveHighScore();
				}

				               //level 19

				if(levelBeatMapName == "SS_Level_19" && rGame.lvlNotBeatGold[18] != false)
				{
				

					if(rGame.lvlNotBeatSilver[18] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[18] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(18,false);
				//saveHighScore();
				}

				               //level 20

				if(levelBeatMapName == "SS_Level_20" && rGame.lvlNotBeatGold[19] != false)
				{

					if(rGame.lvlNotBeatSilver[19] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[19] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
	
				rGame.lvlNotBeatGold.InsertItem(19,false);
				//saveHighScore();
				}

				               //level 21

				if(levelBeatMapName == "SS_Level_21" && rGame.lvlNotBeatGold[20] != false)
				{
				

					if(rGame.lvlNotBeatSilver[20] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[20] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(20,false);
				//saveHighScore();
				}

				               //level 22

				if(levelBeatMapName == "SS_Level_22" && rGame.lvlNotBeatGold[21] != false)
				{

					if(rGame.lvlNotBeatSilver[21] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[21] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(21,false);
				//saveHighScore();
				}

				               //level 23

				if(levelBeatMapName == "SS_Level_23" && rGame.lvlNotBeatGold[22] != false)
				{

					if(rGame.lvlNotBeatSilver[22] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[22] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(22,false);
				//saveHighScore();
				}

				               //level 24

				if(levelBeatMapName == "SS_Level_24" && rGame.lvlNotBeatGold[23] != false)
				{
				

					if(rGame.lvlNotBeatSilver[23] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[23] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(23,false);
				//saveHighScore();
				}

				               //level 25

				if(levelBeatMapName == "SS_Level_25" && rGame.lvlNotBeatGold[24] != false)
				{
				

					if(rGame.lvlNotBeatSilver[24] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[24] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(24,false);
				//saveHighScore();
				}

				               //level 26

				if(levelBeatMapName == "SS_Level_26" && rGame.lvlNotBeatGold[25] != false)
				{

					if(rGame.lvlNotBeatSilver[25] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[25] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(25,false);
				//saveHighScore();
				}

				               //level 27

				if(levelBeatMapName == "SS_Level_27" && rGame.lvlNotBeatGold[26] != false)
				{

					if(rGame.lvlNotBeatSilver[26] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[26] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(26,false);
				//saveHighScore();
				}

				               //level 28

				if(levelBeatMapName == "SS_Level_28" && rGame.lvlNotBeatGold[27] != false)
				{
				

					if(rGame.lvlNotBeatSilver[27] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[27] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatGold.InsertItem(27,false);
				//saveHighScore();
				}

				               //level 29

				if(levelBeatMapName == "SS_Level_29" && rGame.lvlNotBeatGold[28] != false)
				{
				

					if(rGame.lvlNotBeatSilver[28] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[28] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;

				rGame.lvlNotBeatGold.InsertItem(28,false);
				//saveHighScore();
				}

				               //level 30

				if(levelBeatMapName == "SS_Level_30" && rGame.lvlNotBeatGold[29] != false)
				{

					if(rGame.lvlNotBeatSilver[29] == false)
					{
						if(rGame.coffeeMugCount > 0)
						{
						 rGame.coffeeMugCount =  rGame.coffeeMugCount- 1;
						}
					}
					if(rGame.lvlNotBeatBronze[29] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}

					}
				
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatGold.InsertItem(29,false);

				//saveHighScore();
				}

			}
			if(totalTime >= Silver && totalTime < Gold)
			{
				OutputLinks[SCO_Silver].bHasImpulse = true;
				rGame.SilverTrue = true;
				rGame.ClearTimer( 'CheckTimer' );


				//level 1
				
				if( levelBeatMapName == "SS_Level_1" && rGame.lvlNotBeatSilver[0] != false)
				{
				// add to the metal count

				if(rGame.lvlNotBeatGold[0] != false)
				{


					if(rGame.lvlNotBeatBronze[0] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}


				rGame.coffeeMugCount = rGame.coffeeMugCount++;
		
				rGame.lvlNotBeatSilver.InsertItem(0,false);
				//saveHighScore();

				}
				}
                                
                //level 2

				if( levelBeatMapName == "SS_Level_2" && rGame.lvlNotBeatSilver[1] != false)
				{


					if(rGame.lvlNotBeatGold[1] != false)
				{


					if(rGame.lvlNotBeatBronze[1] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(1,false);
				//saveHighScore();
				}
				}

				 //level 3

				if( levelBeatMapName == "SS_Level_3" && rGame.lvlNotBeatSilver[2] != false)
				{

				if(rGame.lvlNotBeatGold[2] != false)
				{


					if(rGame.lvlNotBeatBronze[2] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(2,false);
				//saveHighScore();
				}
				}
					
				 //level 4

				if( levelBeatMapName == "SS_Level_4" && rGame.lvlNotBeatSilver[3] != false)
				{
				if(rGame.lvlNotBeatGold[3] != false)
				{


					if(rGame.lvlNotBeatBronze[3] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(3,false);
				//saveHighScore();
				}
				}

				 //level 5

				if( levelBeatMapName == "SS_Level_5" && rGame.lvlNotBeatSilver[4] != false)
				{
				if(rGame.lvlNotBeatGold[4] != false)
				{


					if(rGame.lvlNotBeatBronze[4] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(4,false);
				//saveHighScore();
				}
				}

				 //level 6

				if( levelBeatMapName == "SS_Level_6" && rGame.lvlNotBeatSilver[5] != false)
				{

					if(rGame.lvlNotBeatGold[5] != false)
				{


					if(rGame.lvlNotBeatBronze[5] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(5,false);
				//saveHighScore();
				}
				}

				 //level 7

				if( levelBeatMapName == "SS_Level_7" && rGame.lvlNotBeatSilver[6] != false)
				{

					if(rGame.lvlNotBeatGold[6] != false)
				{


					if(rGame.lvlNotBeatBronze[6] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(6,false);
				//saveHighScore();
				}
				}

				 //level 8

				if( levelBeatMapName == "SS_Level_8" && rGame.lvlNotBeatSilver[7] != false)
				{
				if(rGame.lvlNotBeatGold[7] != false)
				{


					if(rGame.lvlNotBeatBronze[7] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(7,false);
				//saveHighScore();
				}
				}

				 //level 9

				if( levelBeatMapName == "SS_Level_9" && rGame.lvlNotBeatSilver[8] != false)
				{

					if(rGame.lvlNotBeatGold[8] != false)
				{


					if(rGame.lvlNotBeatBronze[8] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(8,false);
				//saveHighScore();

				}
				}

				 //level 10

				if( levelBeatMapName == "SS_Level_10" && rGame.lvlNotBeatSilver[9] != false)
				{

					if(rGame.lvlNotBeatGold[9] != false)
				{


					if(rGame.lvlNotBeatBronze[9] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(9,false);
				//saveHighScore();
				}
				}

				 //level 11

				if( levelBeatMapName == "SS_Level_11" && rGame.lvlNotBeatSilver[10] != false)
				{

					if(rGame.lvlNotBeatGold[10] != false)
				{


					if(rGame.lvlNotBeatBronze[10] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(10,false);
				//saveHighScore();
				}
				}

				 //level 12

				if( levelBeatMapName == "SS_Level_12" && rGame.lvlNotBeatSilver[11] != false)
				{

					if(rGame.lvlNotBeatGold[11] != false)
				{


					if(rGame.lvlNotBeatBronze[11] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(11,false);
				//saveHighScore();
				}
				}

				 //level 13

				if( levelBeatMapName == "SS_Level_13" && rGame.lvlNotBeatSilver[12] != false)
				{
					if(rGame.lvlNotBeatGold[12] != false)
				{


					if(rGame.lvlNotBeatBronze[12] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(12,false);
				//saveHighScore();
				}
				}

				 //level 14

				if( levelBeatMapName == "SS_Level_14" && rGame.lvlNotBeatSilver[13] != false)
				{

					if(rGame.lvlNotBeatGold[13] != false)
				{


					if(rGame.lvlNotBeatBronze[13] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(13,false);
				//saveHighScore();
				}
				}

				 //level 15

				if( levelBeatMapName == "SS_Level_15" && rGame.lvlNotBeatSilver[14] != false)
				{
					if(rGame.lvlNotBeatGold[14] != false)
				{


					if(rGame.lvlNotBeatBronze[14] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(14,false);
				//saveHighScore();
				}
				}

				 //level 16

				if( levelBeatMapName == "SS_Level_16" && rGame.lvlNotBeatSilver[15] != false)
				{

					if(rGame.lvlNotBeatGold[15] != false)
				{


					if(rGame.lvlNotBeatBronze[15] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(15,false);
				//saveHighScore();
				}
				}

				 //level 17

				if( levelBeatMapName == "SS_Level_17" && rGame.lvlNotBeatSilver[16] != false)
				{

					if(rGame.lvlNotBeatGold[16] != false)
				{


					if(rGame.lvlNotBeatBronze[16] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(16,false);
				//saveHighScore();
				}
				}

				 //level 18

				if( levelBeatMapName == "SS_Level_18" && rGame.lvlNotBeatSilver[17] != false)
				{

					if(rGame.lvlNotBeatGold[17] != false)
				{


					if(rGame.lvlNotBeatBronze[17] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(17,false);
				//saveHighScore();
				}
				}

				 //level 19

				if( levelBeatMapName == "SS_Level_19" && rGame.lvlNotBeatSilver[18] != false)
				{

					if(rGame.lvlNotBeatGold[18] != false)
				{


					if(rGame.lvlNotBeatBronze[18] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(18,false);
				//saveHighScore();
				}
				}
				
				 //level 20

				if( levelBeatMapName == "SS_Level_20" && rGame.lvlNotBeatSilver[19] != false)
				{

					if(rGame.lvlNotBeatGold[19] != false)
				{


					if(rGame.lvlNotBeatBronze[19] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(19,false);
				//saveHighScore();
				}
				}

				 //level 21

				if( levelBeatMapName == "SS_Level_21" && rGame.lvlNotBeatSilver[20] != false)
				{

					if(rGame.lvlNotBeatGold[20] != false)
				{


					if(rGame.lvlNotBeatBronze[20] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(20,false);
				//saveHighScore();
				}
				}

				 //level 22

				if( levelBeatMapName == "SS_Level_22" && rGame.lvlNotBeatSilver[21] != false)
				{

					if(rGame.lvlNotBeatGold[21] != false)
				{


					if(rGame.lvlNotBeatBronze[21] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(21,false);
				//saveHighScore();
				}
				}

				 //level 23

				if( levelBeatMapName == "SS_Level_23" && rGame.lvlNotBeatSilver[22] != false)
				{

					if(rGame.lvlNotBeatGold[22] != false)
				{


					if(rGame.lvlNotBeatBronze[22] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(22,false);
				//saveHighScore();
				}
				}

				 //level 24

				if( levelBeatMapName == "SS_Level_24" && rGame.lvlNotBeatSilver[23] != false)
				{

					if(rGame.lvlNotBeatGold[23] != false)
				{


					if(rGame.lvlNotBeatBronze[23] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(23,false);
				//saveHighScore();
				}
				}



				 //level 25

				if( levelBeatMapName == "SS_Level_25" && rGame.lvlNotBeatSilver[24] != false)
				{

					if(rGame.lvlNotBeatGold[24] != false)
				{


					if(rGame.lvlNotBeatBronze[24] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(24,false);
				//saveHighScore();
				}
				}

				 //level 26

				if( levelBeatMapName == "SS_Level_26" && rGame.lvlNotBeatSilver[25] != false)
				{

					if(rGame.lvlNotBeatGold[25] != false)
				{


					if(rGame.lvlNotBeatBronze[25] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(25,false);
				//saveHighScore();
				}
				}

				 //level 27

				if( levelBeatMapName == "SS_Level_27" && rGame.lvlNotBeatSilver[26] != false)
				{

					if(rGame.lvlNotBeatGold[26] != false)
				{


					if(rGame.lvlNotBeatBronze[26] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(26,false);
				//saveHighScore();
				}
				}

				 //level 28

				if( levelBeatMapName == "SS_Level_28" && rGame.lvlNotBeatSilver[27] != false)
				{

					if(rGame.lvlNotBeatGold[27] != false)
				{


					if(rGame.lvlNotBeatBronze[27] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(27,false);
				//saveHighScore();
				}
				}

				 //level 29

				if( levelBeatMapName == "SS_Level_29" && rGame.lvlNotBeatSilver[28] != false)
				{

					if(rGame.lvlNotBeatGold[28] != false)
				{


					if(rGame.lvlNotBeatBronze[28] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(28,false);
				//saveHighScore();
				}
				}

				 //level 30

				if( levelBeatMapName == "SS_Level_30" && rGame.lvlNotBeatSilver[29] != false)
				{

					if(rGame.lvlNotBeatGold[29] != false)
				{


					if(rGame.lvlNotBeatBronze[29] == false )
					{
						if(rGame.coffeeMugCount > 0)
						{
						  rGame.coffeeMugCount =    rGame.coffeeMugCount - 1;
						 
						}
					}
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatSilver.InsertItem(29,false);
				//saveHighScore();
				}
				}


			}




			if(totalTime >= Bronze && totalTime < Silver && totalTime < Gold)
			{
				OutputLinks[SCO_Bronze].bHasImpulse = true;
				rGame.BronzeTrue = true;
				rGame.ClearTimer( 'CheckTimer' );

				//level 1
				
				if( levelBeatMapName == "SS_Level_1" && rGame.lvlNotBeatBronze[0] != false)
				{
					if(rGame.lvlNotBeatGold[0] != false && rGame.lvlNotBeatSilver[0] != false)
					{
				// add to the metal count
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(0,false);
				
				//saveHighScore();
				}
				}
                                
                 //level 2

				if( levelBeatMapName == "SS_Level_2" && rGame.lvlNotBeatBronze[1] != false)
				{
					if(rGame.lvlNotBeatGold[1] != false && rGame.lvlNotBeatSilver[1] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(1,false);
				//saveHighScore();
					}
				}

                //level 3
				if( levelBeatMapName == "SS_Level_3" && rGame.lvlNotBeatBronze[2] != false)
				{

					if(rGame.lvlNotBeatGold[2] != false && rGame.lvlNotBeatSilver[2] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(2,false);
				//saveHighScore();
					}
				}

				 //level 4
				if( levelBeatMapName == "SS_Level_4" && rGame.lvlNotBeatBronze[3] != false)
				{
				if(rGame.lvlNotBeatGold[3] != false && rGame.lvlNotBeatSilver[3] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(3,false);
				//saveHighScore();
					}
				}

				 //level 5
				if( levelBeatMapName == "SS_Level_5" && rGame.lvlNotBeatBronze[4] != false)
				{
				if(rGame.lvlNotBeatGold[4] != false && rGame.lvlNotBeatSilver[4] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(4,false);
				//saveHighScore();
					}
				}

				 //level 6
				if( levelBeatMapName == "SS_Level_6" && rGame.lvlNotBeatBronze[5] != false)
				{
			
					if(rGame.lvlNotBeatGold[5] != false && rGame.lvlNotBeatSilver[5] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(5,false);
				//saveHighScore();
					}
				}

				 //level 7
				if( levelBeatMapName == "SS_Level_7" && rGame.lvlNotBeatBronze[6] != false)
				{
			
					if(rGame.lvlNotBeatGold[6] != false && rGame.lvlNotBeatSilver[6] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(6,false);
				//saveHighScore();
					}
				}

				 //level 8
				if( levelBeatMapName == "SS_Level_8" && rGame.lvlNotBeatBronze[7] != false)
				{
			
					if(rGame.lvlNotBeatGold[7] != false && rGame.lvlNotBeatSilver[7] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(7,false);
				//saveHighScore();
					}
				}

				 //level 9
				if( levelBeatMapName == "SS_Level_9" && rGame.lvlNotBeatBronze[8] != false)
				{
					if(rGame.lvlNotBeatGold[8] != false && rGame.lvlNotBeatSilver[8] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(8,false);
				//saveHighScore();
					}
				}

				 //level 10
				if( levelBeatMapName == "SS_Level_10" && rGame.lvlNotBeatBronze[9] != false)
				{
			
					if(rGame.lvlNotBeatGold[9] != false && rGame.lvlNotBeatSilver[9] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(9,false);
				//saveHighScore();
					}
				}

				 //level 11
				if( levelBeatMapName == "SS_Level_11" && rGame.lvlNotBeatBronze[10] != false)
				{
			if(rGame.lvlNotBeatGold[10] != false && rGame.lvlNotBeatSilver[10] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(10,false);
				//saveHighScore();
					}
				}

				 //level 12
				if( levelBeatMapName == "SS_Level_12" && rGame.lvlNotBeatBronze[11] != false)
				{
					if(rGame.lvlNotBeatGold[11] != false && rGame.lvlNotBeatSilver[11] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(11,false);
				//saveHighScore();
					}
				}

				 //level 13
				if( levelBeatMapName == "SS_Level_13" && rGame.lvlNotBeatBronze[12] != false)
				{
			
					if(rGame.lvlNotBeatGold[12] != false && rGame.lvlNotBeatSilver[12] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(12,false);
				//saveHighScore();
					}
				}

				 //level 14
				if( levelBeatMapName == "SS_Level_14" && rGame.lvlNotBeatBronze[13] != false)
				{
			
					if(rGame.lvlNotBeatGold[13] != false && rGame.lvlNotBeatSilver[13] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(13,false);
				//saveHighScore();
					}
				}
				
				 //level 15
				if( levelBeatMapName == "SS_Level_15" && rGame.lvlNotBeatBronze[14] != false)
				{
			
					if(rGame.lvlNotBeatGold[14] != false && rGame.lvlNotBeatSilver[14] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(14,false);
				//saveHighScore();
					}
				}

				 //level 16
				if( levelBeatMapName == "SS_Level_16" && rGame.lvlNotBeatBronze[15] != false)
				{
					if(rGame.lvlNotBeatGold[15] != false && rGame.lvlNotBeatSilver[15] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(15,false);
				//saveHighScore();
					}
				}

				 //level 17
				if( levelBeatMapName == "SS_Level_17" && rGame.lvlNotBeatBronze[16] != false)
				{
					if(rGame.lvlNotBeatGold[16] != false && rGame.lvlNotBeatSilver[16] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(16,false);
				//saveHighScore();
					}
				}

				 //level 18
				if( levelBeatMapName == "SS_Level_18" && rGame.lvlNotBeatBronze[17] != false)
				{
			
					if(rGame.lvlNotBeatGold[17] != false && rGame.lvlNotBeatSilver[17] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(17,false);
				//saveHighScore();
					}
				}

				 //level 19
				if( levelBeatMapName == "SS_Level_19" && rGame.lvlNotBeatBronze[18] != false)
				{
			
					if(rGame.lvlNotBeatGold[18] != false && rGame.lvlNotBeatSilver[18] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(18,false);
				//saveHighScore();
					}
				}

				 //level 20
				if( levelBeatMapName == "SS_Level_20" && rGame.lvlNotBeatBronze[19] != false)
				{

					if(rGame.lvlNotBeatGold[19] != false && rGame.lvlNotBeatSilver[19] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(19,false);
				//saveHighScore();
					}
				}

				 //level 21
				if( levelBeatMapName == "SS_Level_21" && rGame.lvlNotBeatBronze[20] != false)
				{
			
					if(rGame.lvlNotBeatGold[20] != false && rGame.lvlNotBeatSilver[20] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(20,false);
				//saveHighScore();
					}
				}

				 //level 22
				if( levelBeatMapName == "SS_Level_22" && rGame.lvlNotBeatBronze[21] != false)
				{
					if(rGame.lvlNotBeatGold[21] != false && rGame.lvlNotBeatSilver[21] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(21,false);
				//saveHighScore();
					}
				}

				 //level 23
				if( levelBeatMapName == "SS_Level_23" && rGame.lvlNotBeatBronze[22] != false)
				{
			
					if(rGame.lvlNotBeatGold[22] != false && rGame.lvlNotBeatSilver[22] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(22,false);
				//saveHighScore();
					}
				}

				 //level 24
				if( levelBeatMapName == "SS_Level_24" && rGame.lvlNotBeatBronze[23] != false)
				{
			
					if(rGame.lvlNotBeatGold[23] != false && rGame.lvlNotBeatSilver[23] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(23,false);
				//saveHighScore();
					}
				}

				 //level 25
				if( levelBeatMapName == "SS_Level_25" && rGame.lvlNotBeatBronze[24] != false)
				{
					if(rGame.lvlNotBeatGold[24] != false && rGame.lvlNotBeatSilver[24] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(24,false);
				//saveHighScore();
					}
				}

				 //level 26
				if( levelBeatMapName == "SS_Level_26" && rGame.lvlNotBeatBronze[25] != false)
				{
			
					if(rGame.lvlNotBeatGold[25] != false && rGame.lvlNotBeatSilver[25] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(25,false);
				//saveHighScore();
					}
				}

				 //level 27
				if( levelBeatMapName == "SS_Level_27" && rGame.lvlNotBeatBronze[26] != false)
				{
					if(rGame.lvlNotBeatGold[26] != false && rGame.lvlNotBeatSilver[26] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(26,false);
				//saveHighScore();
					}
				}

				 //level 28
				if( levelBeatMapName == "SS_Level_28" && rGame.lvlNotBeatBronze[27] != false)
				{
			
					if(rGame.lvlNotBeatGold[27] != false && rGame.lvlNotBeatSilver[27] != false)
					{
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(27,false);
				//saveHighScore();
					}
				}

				 //level 29
				if( levelBeatMapName == "SS_Level_29" && rGame.lvlNotBeatBronze[28] != false)
				{
					if(rGame.lvlNotBeatGold[28] != false && rGame.lvlNotBeatSilver[28] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(28,false);
				//saveHighScore();
					}
				}

				 //level 30
				if( levelBeatMapName == "SS_Level_30" && rGame.lvlNotBeatBronze[29] != false)
				{
					if(rGame.lvlNotBeatGold[29] != false && rGame.lvlNotBeatSilver[29] != false)
					{
			
				rGame.coffeeMugCount = rGame.coffeeMugCount++;
			
				rGame.lvlNotBeatBronze.InsertItem(29,false);
				//saveHighScore();
					}
				}



			}

			if(totalTime < Bronze && totalTime < Silver && totalTime < Gold)
			{
				OutputLinks[SCO_Lost].bHasImpulse = true;
				rGame.ClearTimer( 'CheckTimer' );
			}
			// Clears all the arrays at the end of the level
			rGame.isInWorld.Remove ( 0,rGame.isInWorld.Length );
			rGame.spawnLocation.Remove ( 0, rGame.isInWorld.Length );
			rGame.currentSeconds.Remove ( 0, rGame.currentSeconds.Length );
		}

			rGame.coffeeMugCount = (rGame.coffeeMugCount * 3) + (rGame.coffeeMugCount * 2) + rGame.coffeeMugCount ;
	//saveHighScore();
	}
	
	*/

}
////////////////////\\\\\\\\\\\\\\\\\\\\
/**
* This function saves our variables using BasicSaveObject
**/

/*function saveHighScore()
{
   local SS_Gametype rGame;
	local WorldInfo rWorld;
	local SS_HighScoreMenu gameState;
	local int i;
	`log("SavingGame");

	// Used to gain access to the world info of the game
	rWorld = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorld != none )
	{
		// Used to gain access to the totalStamina variable in the game
		rGame = SS_Gametype (rWorld.Game);
		// Check to make sure we have access to the variable
		if ( rGame != none )
		{
			gameState = new class'SS_HighScoreMenu';
			gameState.GoldMetalCount = rGame.coffeeMugCount;
			gameState.SilverMetalCount = rGame.coffeeMugCount;
			gameState.BronzeMetalCount = rGame.coffeeMugCount;
			gameState.coffeeMugCount = rGame.coffeeMugCount;

			for ( i = 0; i < rGame.levelbeat.Length; i++ )
			{
			gameState.levelbeat[i] = rGame.levelbeat[i];

			}
			for ( i = 0; i < rGame.lvlNotBeatGold.Length; i++ )
			{
				
			gameState.lvlNotBeatGold[i] = rGame.lvlNotBeatGold[i];
			}
			for ( i = 0; i < rGame.lvlNotBeatSilver.Length; i++ )
			{
				
			gameState.lvlNotBeatSilver[i] = rGame.lvlNotBeatSilver[i];
			}
		
			for ( i = 0; i < rGame.lvlNotBeatBronze.Length; i++ )
			{
				
			gameState.lvlNotBeatBronze[i] = rGame.lvlNotBeatBronze[i];
			}
				// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "HighScore.bin", true, 0);


		}
	}

}
*/

/*

function savePCVariables()
{
    local SS_Gametype rGame;
	local WorldInfo rWorld;
	local DH_GameState gameState;

	// Used to gain access to the world info of the game
	rWorld = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorld != none )
	{
		// Used to gain access to the totalStamina variable in the game
		rGame = SS_Gametype (rWorld.Game);
		// Check to make sure we have access to the variable
		if ( rGame != none )
		{
			// Our gameState variable
			// Init our gamestate variable - this is important
			gameState = new class'DH_GameState';
			gameState.currentMapName = rWorld.GetMapName(false);
			// Save the variables
			//gameState.highScore = rGame.highScore; //Set the gameState’s highScore to the PC’s highScore
			gameState.MaxStamina = rGame.MaxStamina;
		
			// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "GameState.bin", true, 0);
		}
	}
}
*/
	}
}

//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{
	ObjName="GameScoreCheck"
	ObjCategory="Game"
	OutputLinks.empty;
	OutputLinks(SCO_Gold)=(LinkDesc="Gold")
	OutputLinks(SCO_Silver)=(LinkDesc="Silver")
	OutputLinks(SCO_Bronze)=(LinkDesc="Bronze")
	OutputLinks(SCO_Lost)=(LinkDesc="Lost")

	//Set amount for medals
	Gold = 60;
	Silver = 45 ;
	Bronze = 20;
}
