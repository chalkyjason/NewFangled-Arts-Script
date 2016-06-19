// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Brad Fairley, Jason Chalky
// Purpose: Initializing the Game Info for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_GameInfo extends GameInfo;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var SS_HUD hudWORLD;
var SS_PlayerController playerControllerWORLD;
var SS_Pawn playerpawnWORLD;
//---------------------------------------------------------------------------------------------------------------\\


defaultproperties
{

   PlayerControllerClass = class'SS_PlayerController'
   DefaultPawnClass = class'SS_Pawn'
   HUDType = class'SS_SF_Hud'
   bDelayedStart=false
  
}
//---------------------------------------------------------------------------------------------------------------\\
// Events
// For packaging/frontend
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return class'SS_GameInfo';
}

// After game start
event PostLogin( PlayerController NewPlayer )
{
    super.PostLogin(NewPlayer);

    
	`log("Yay! : === Your Custom GameInfo Class is Working ===");
}