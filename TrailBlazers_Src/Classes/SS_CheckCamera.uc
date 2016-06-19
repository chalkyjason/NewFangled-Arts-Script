class SS_CheckCamera extends SequenceCondition;

    //To states the player can have
enum ScoreCheckOuts
{
	SCO_True,
	SCO_False
};

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
			if(rGame.continueZoom == true)
			{
				OutputLinks[SCO_True].bHasImpulse = true;
			}

			if(rGame.continueZoom == false)
			{
				OutputLinks[SCO_False].bHasImpulse = true;
			}

		}



			
		
		}
	
}

defaultproperties
{

	

	OutputLinks.empty;
	OutputLinks(SCO_True)=(LinkDesc="True")
	OutputLinks(SCO_False)=(LinkDesc="False")
	ObjName="SS_CheckCamera"
	ObjCategory="SwinginSwiggins Conditions"
}
