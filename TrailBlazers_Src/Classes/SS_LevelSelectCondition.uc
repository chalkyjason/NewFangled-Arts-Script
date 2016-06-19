class SS_LevelSelectCondition extends SequenceCondition;

var() int DeveloperSetCoffeeMugCount;

enum ScoreCheckOuts
{
	SCO_True
};

event Activated()
{

 // Set coffeemugcount to the in var and set output.

	local SS_Gametype rGame;
	local WorldInfo rWorld;

        //might want to add this to gametype to have it used global
     
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
			

				
			//Neeed to change to greater or equal
				if(rGame.coffeeMugCount >= DeveloperSetCoffeeMugCount)
				{

					OutputLinks[SCO_True].bHasImpulse = true;
				}
				
		}
	}


}

defaultproperties
{
	ObjName="SS_LevelSelectCondition"
	ObjCategory="SwinginSwiggins Conditions"
	OutputLinks.empty;
	OutputLinks(SCO_True)=(LinkDesc="True")
	

}
