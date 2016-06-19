// Author:  Team TrailBlazers
// Date:    09/2014
// Credit:  Timothy Janssen
// Purpose: Initializing the DH Game State for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SS_Action_SlowMo extends SequenceAction;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var () float slowAmount;
//---------------------------------------------------------------------------------------------------------------\\
// Events
event Activated()
{
	// Local Variables used to gain access to player stamina
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
		if ( rGame != none)
		{
			if ( !rGame.slowMo )
			{
				rGame.slowMo = true;
				rGame.slowPercent = slowAmount;
			}
			else
			{
				rGame.slowMo = false;
			}
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{
	ObjName="Slow Mo";
	ObjCategory="Game";

	slowAmount = 0.5;
}