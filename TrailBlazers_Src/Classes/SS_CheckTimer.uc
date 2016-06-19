class SS_CheckTimer extends SequenceCondition;

var int convert;

// Enums
// To states the player can have
enum ScoreCheckOuts
{
	SCO_Zero,
	SCO_Time
};

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
				convert = (rGame.CountDownTMR.Min * 60 ) + rGame.CountDownTMR.Sec;
			}
			else
			convert = rGame.CountDownTMR.Sec;
		}
	}
}
event Activated()
{

	
	//local SS_Gametype rGame;
	local WorldInfo rWorld;


	
	// Used to gain access to the world info of the game
	rWorld = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorld != none )
	{
	
		convertTime();
	
		if(convert <= 0)

		{
			OutputLinks[SCO_Zero].bHasImpulse = true;			
		}
	
		else 

		OutputLinks[SCO_Time].bHasImpulse = true;
	}
}

			
			


defaultproperties
{
	ObjName="SS_CheckTimer"
	ObjCategory="Game"

	OutputLinks.empty;
	OutputLinks(SCO_Zero)=(LinkDesc="Zero")
	OutputLinks(SCO_Time)=(LinkDesc="Time")
}
