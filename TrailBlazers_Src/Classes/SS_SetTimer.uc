// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky, , Brad Fairley, Chris Augilar
// Purpose: Initializing the Game Timer for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SS_SetTimer extends SequenceAction;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var() int KtimerSec;
var() int KtimerMin;
//---------------------------------------------------------------------------------------------------------------\\
// Events
event Activated()
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
			rGame.CountDownTMR.Min = KtimerMin;
			rGame.CountDownTMR.Sec = KtimerSec;
			rGame.TimeStarterMin = KtimerMin;
			rGame.TimeStartedSec = KtimerSec;
			convertTime();
			//savePCVariables();
		}
	}
}

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
				rGame.TimeStarted = rGame.CountDownTMR.Min * 60;
				rGame.TimeStarted = rGame.TimeStarted + rGame.CountDownTMR.Sec;
			}
			if(rGame.CountDownTMR.Min < 1)
			{
				rGame.TimeStarted = rGame.CountDownTMR.Sec;
			}
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
// Functions

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
			gameState.currentMapName =rWorld.GetMapName(false);

			// Save the variables

			gameState.highScore = rGame.highScore; //Set the gameState’s highScore to the PC’s highScore

			gameState.MaxStamina = rGame.MaxStamina;

			// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "GameState.bin", true, 0);
		}
	}
}
*/
//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{
	ObjName="SS_SetTimer"
	ObjCategory="SwinginSwiggins Actions"
	KtimerMin = 1;
    KtimerSec = 2;
}
