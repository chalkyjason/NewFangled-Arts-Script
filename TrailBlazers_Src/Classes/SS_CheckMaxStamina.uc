// Author:  Team TrailBlazers
// Date:    06/2016
// Credit:  uJason Chalky
// Purpose: Used to check to see if you need to collect mx stamina or destroy the max stamina to aviod the player from collecting too much.
//---------------------------------------------------------------------------------------------------------------\\
class SS_CheckMaxStamina extends SequenceCondition;
var float CurrentMaxStamina; 
var string CurrentMapName;
var bool destroyLevel7;


// Enums
// To states the player can have
enum LevelNames
{
	SCO_Level7
};

event Activated()
{

	local SS_Gametype rGame;
	local WorldInfo rWorld;
   
	`log("1");
	// Used to gain access to the world info of the game
	rWorld = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorld != none )
	{
		`log("2");
		// Used to gain access to the totalStamina variable in the game
		rGame = SS_Gametype (rWorld.Game);
		
		// Check to make sure we have access to the variable
		if ( rGame != none )
		{


			`log("3");

			getStamina();


			//Get the name of the map that was just completed
				
		CurrentMapName	= rWorld.GetMapName(false);

				//check level name that was complete, set the arrays to show what level has been beat
				//Might use the levelbeat var for menu system later on, do not need to use as of right now
				if(CurrentMapName== "SS_Level_7")
				{

					`log("5");
					if (rGame.MaxStamina >= 10)
					{

						`log("6");

						destroyLevel7 = true;
						`log("Sent Impulse");
						OutputLinks[SCO_Level7].bHasImpulse = true;


					}
				}
		}
	}

}


function getStamina() 
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
			CurrentMaxStamina = rGame.MaxStamina;

			`log ("getting stamina");
		}

	}
	}


defaultproperties
{
	ObjName="SS_CheckMaxStamina"
	ObjCategory="SwinginSwiggins Conditions"

	utputLinks.empty;
	OutputLinks(SCO_Level7)=(LinkDesc="Level7")
	//Need to change to other levels
	OutputLinks(SCO_Silver)=(LinkDesc="Silver")
	OutputLinks(SCO_Bronze)=(LinkDesc="Bronze")

	destroyLevel7 = false;
}
