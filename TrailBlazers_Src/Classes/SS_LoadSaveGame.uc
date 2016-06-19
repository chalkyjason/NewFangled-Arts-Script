// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SS_LoadSaveGame extends SequenceAction;

/*
/** Declare our SaveGameBase. */
var SaveGameBase SGB;

/** Folder name that will be used in SaveGame() and LoadGame(). Defined in DefaultProperties */
var string FolderName; 

/** Save File name. Should be same in SaveGame and LoadGame. Defined in DefaultProperties */
var string SaveFileName;

/** Your custom file extension. Use any extension you want. Eg: ".bin" or ".sav". Defined in DefaultProperties */
var string SaveFileExtension;
*/

event Activated()
{
	loadPCVariables();
}



////////////////////\\\\\\\\\\\\\\\\\\\\
function loadPCVariables()
{
	local SS_Gametype rGame;
	local WorldInfo rWorld;
	local DH_GameState gameState;
//	local int i;
	

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
			gameState =  new class'DH_GameState';
 
			// Load the variables gamestate using BasicLoadObject
			// Version 0: Development

			if(class'Engine'.static.BasicLoadObject(gameState, "..\\..\\..\\Swingin\\Saves\\SS.bin", true, 0)) //Load only if the file actually exists
			{
				//rGame.highScore = gameState.highScore; //Set the PC’s highScore to the value we loaded
				rGame.currentMapName = gameState.currentMapName; 
				rGame.MaxStamina = gameState.MaxStamina;
				rGame.TotalStamina = gameState.MaxStamina;
				rGame.coffeeMugCount = gameState.coffeeMugCount;

//				foreach(gameState.lvlNotBeatGold[i], i)
	//		{
		//		rGame.lvlNotBeatGold[i] = gameState.lvlNotBeatGold[i];
			//}

				/*

				for ( i = 0; i < gameState.levelbeat.Length; i++ )
			{
			  rGame.levelbeat[i] = gameState.levelbeat[i];

			}
			for ( i = 0; i < gameState.lvlNotBeatGold.Length; i++ )
			{
				
		  rGame.lvlNotBeatGold[i] = gameState.lvlNotBeatGold[i];
			}
			for ( i = 0; i < gameState.lvlNotBeatSilver.Length; i++ )
			{
				
             rGame.lvlNotBeatSilver[i] = gameState.lvlNotBeatSilver[i];
			}
		
			for ( i = 0; i < gameState.lvlNotBeatBronze.Length; i++ )
			{
				
			  rGame.lvlNotBeatBronze[i] = gameState.lvlNotBeatBronze[i];
			}
			*/

				
			}
			else
			{

				//Check to see if this works JUNE(2016) 
				rGame.coffeeMugCount = 0;
				`Log("File not found while loading PC’s variables");
			}
		}
	}
}


/*


/** Loads the game. Bind this function to a key (like F9) in DefaultInput.ini */
 function LoadGame(int LoadVersion)
{
    /** Holds the path to load the save game */
    local string LoadLoc;

	 local SS_Gametype rGame;
	local WorldInfo rWorld;
	//local DH_GameState gameState;

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
    SGB = new class'SaveGameBase';
    
    /** Calls the DLLFunction which returns MyDocuments\FolderName\SaveFileName_LoadVersion.SaveFileExtension */
    LoadLoc = SGB.LoadGameFromMyDocuments(FolderName, SaveFileName, SaveFileExtension, string(LoadVersion));
    
    /** If everything goes well and SGB.SAVE_VERSION is correct then load the file */
    if (class'Engine'.static.BasicLoadObject(SGB, LoadLoc, true, SGB.SAVE_VERSION))
    {
        /** Change the players position to whatever is defined in SGB.Loc */
      //  SS_Pawn(self.Pawn).SetLocation(SGB.Loc);

		rGame.currentMapName = SGB.currentMapName; 
				rGame.MaxStamina = SGB.MaxStamina;
				rGame.TotalStamina = SGB.MaxStamina;
				rGame.coffeeMugCount = SGB.coffeeMugCount;
				
    }
		}
	}
}
*/

defaultproperties
{
	ObjName="SS_LoadSaveGame"
	ObjCategory="SwinginSwiggins Actions"

	/*
	FolderName = "Swiggins" //For multiple folders: "My Company Game\\My Game Name\\Save Games". It is IMPORTANT to set double slash!!
    SaveFileName = "SwinginSave" //The file name that will be used in SaveGame and LoadGame.
    SaveFileExtension = ".goo" //File Extension. You can use any extension you want.
    */
}
