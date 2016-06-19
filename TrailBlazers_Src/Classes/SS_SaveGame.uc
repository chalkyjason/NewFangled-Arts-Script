// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SS_SaveGame extends SequenceAction;
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
	savePCVariables();
}




// Functions
function savePCVariables()
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
			gameState = new class'DH_GameState';
			gameState.currentMapName =rWorld.GetMapName(false);

			// Save the variables

//			gameState.highScore = rGame.highScore; //Set the gameState’s highScore to the PC’s highScore

			gameState.MaxStamina = rGame.MaxStamina;
			gameState.TotalStamina = rGame.TotalStamina;
			gameState.coffeeMugCount = rGame.coffeeMugCount;
			`log(rGame.coffeeMugCount);

//			foreach(gameState.lvlNotBeatGold[i])
	//		{
		//		gameState.lvlNotBeatGold[i] = rGame.lvlNotBeatGold[i];
			//}
/*
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
			*/

			// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "..\\..\\..\\Swingin\\Saves\\SS.bin", true, 0);
		}
	}
}


/*




/** Saves the game. Bind this function to a key (like F5 or F6 or something like that) in DefaultInput.ini */
 function SaveGame() 
{
    /** The string that will hold the absolute path of save location */
    local string SaveLoc;

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
    
    /** Since we extended the SaveGameBase from Object we must use "new" to create a new one */
    SGB = new class'SaveGameBase';
    
    /** Assign the players position to Loc variable inside SaveGameBase (SGB) */
  //  SGB.Loc = SS_Pawn(self.Pawn).Location;

           SGB.currentMapName =rWorld.GetMapName(false);

			// Save the variables

//			gameState.highScore = rGame.highScore; //Set the gameState’s highScore to the PC’s highScore

			 SGB.MaxStamina = rGame.MaxStamina;
		     SGB.TotalStamina = rGame.TotalStamina;
			 SGB.coffeeMugCount = rGame.coffeeMugCount;
	
	
    
    /** Calls the DLLFunction which returns MyDocuments\FolderName\SaveFileName.SaveFileExtension */
    SaveLoc = SGB.SaveGameToMyDocuments(FolderName, SaveFileName, SaveFileExtension);


    
    /** Finally call the Engine Function to save all the SGB variables to the specified location */
    class'Engine'.static.BasicSaveObject(SGB, SaveLoc, true, SGB.SAVE_VERSION);
    
    /** [TESTING ONLY] */
//    WorldInfo.Game.Broadcast(self, "Game Saved.");
 //   WorldInfo.Game.Broadcast(self, SaveLoc);
  //  WorldInfo.Game.Broadcast(self, "Player Position: "$SGB.Loc);
		}
	}

}
*/
defaultproperties
{
	ObjName="SS_SaveGame"
	ObjCategory="SwinginSwiggins Actions"
/*
	FolderName = "Swiggins" //For multiple folders: "My Company Game\\My Game Name\\Save Games". It is IMPORTANT to set double slash!!
    SaveFileName = "SwinginSave" //The file name that will be used in SaveGame and LoadGame.
    SaveFileExtension = ".goo" //File Extension. You can use any extension you want.
    */
}
