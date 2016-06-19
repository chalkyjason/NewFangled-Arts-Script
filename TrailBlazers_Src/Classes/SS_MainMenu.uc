// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Initializing the Main Menu for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_MainMenu extends GFxMoviePlayer;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var GFxObject RootMC;
var GFxClikWidget newGame;
var GFxClikWidget continueGame;
var string loadcurrentMapName;

var GFxObject GoldMedalText, SilverMedalText, BronzeMedalText;
//---------------------------------------------------------------------------------------------------------------\\
// Functions
//GFx framework always runs this function first
function bool Start(optional bool StartPaused = false)
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

	
    super.Start();
    Advance(0);
           
    RootMC = GetVariableObject("_root");
	


	AddCaptureKey('Gamepad_LeftStick_Left');
    AddCaptureKey('Gamepad_LeftStick_Right');
    AddCaptureKey('Gamepad_LeftStick_Up');
    AddCaptureKey('Gamepad_LeftStick_Down');
	AddCaptureKey('XboxTypeS_DPad_Left');
	AddCaptureKey('XboxTypeS_DPad_Right');
	AddCaptureKey('XboxTypeS_DPad_Up');
	AddCaptureKey('XboxTypeS_DPad_Down');

//	loadHighScore();
	
	//RootMC.SetInt("goldmedals", rGame.GoldMetalCount);
	//RootMC.SetInt("silvermedals", rGame.SilverMetalCount);
	//RootMC.SetInt("bronzemedals", rGame.BronzeMetalCount);
	RootMC.SetInt("coffee",rGame.coffeeMugCount);

	


	
	
	
	
	
			
  //  `log("RootMC = "$RootMC);

    
	

	
    AddCaptureKey('XboxTypeS_A');
    AddCaptureKey('XboxTypeS_Start');
    AddCaptureKey('Enter');
           
    return true;
		}
	}
}


/*

function loadHighScore()
{
   local SS_Gametype rGame;
	local WorldInfo rWorld;
	local SS_HighScoreMenu gameState;
	local int i;

	`log("Load high scores");
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
			// Load the variables gamestate using BasicLoadObject
			// Version 0: Development

			if(class'Engine'.static.BasicLoadObject(gameState, "HighScore.bin", true, 0)) //Load only if the file actually exists
			{
			
			 rGame.GoldMetalCount = 	gameState.GoldMetalCount;
			rGame.SilverMetalCount = gameState.SilverMetalCount ;
			rGame.BronzeMetalCount = gameState.BronzeMetalCount ;
			rGame.coffeeMugCount = gameState.coffeeMugCount;

			`log(rGame.coffeeMugCount);
			for ( i = 0; i < rGame.levelbeat.Length; i++ )
			{
			rGame.levelbeat[i] = gameState.levelbeat[i];

			}
		
			for ( i = 0; i < rGame.lvlNotBeatGold.Length; i++)
			{
			rGame.lvlNotBeatGold[i] = gameState.lvlNotBeatGold[i];

			}
			for ( i = 0; i < rGame.lvlNotBeatSilver.Length; i++)
			{
			rGame.lvlNotBeatSilver[i] = gameState.lvlNotBeatSilver[i];

			}
			for ( i = 0; i < rGame.lvlNotBeatBronze.Length; i++)
			{
			rGame.lvlNotBeatBronze[i] = gameState.lvlNotBeatBronze[i];

			}
			}
			

		}

	
	}

}
*/




////////////////////\\\\\\\\\\\\\\\\\\\\
	/* FUNC: WidgetInitialized
** DESC: Callback when a CLIK ewidget with enableInitCallback set to TRUE is initialized.
**              Use only if trying to make calls from code.  fscommands through Kismet are preferred for ease of use.
** ARGS: WidgetName [name of flash instance], WidgetPath [path from root of flash file], Widget [ref to GFxObject]
** RETURN: True if widget was handled, false otherwise
*/
event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{
		
        switch(WidgetName)
        {
				
			
                case ('newGame'):
                        newGame = GFxClikWidget(Widget);
                        newGame.AddEventListener('CLIK_press', StartnewGame);
				
                        break;
                case ('continueGame'):
                        continueGame = GFxClikWidget(Widget);
						continueGame.AddEventListener('CLIK_press', continueOldGame);
                        break;
               
                   
                default:
                        break;
        }
        return true;
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* FUNC: StartGamePressed
** DESC: Executed through StartGameButton event listener, opens game map to play
** ARGS: ev [EventListener event data, sent just like ActionScript via Event Listener]
** RETURN: none
*/
function StartnewGame(GFxClikWidget.EventData ev)
{
    newload();
	ConsoleCommand("open SS_Level_1");
	CloseMovie();
}
////////////////////\\\\\\\\\\\\\\\\\\\\ 
function continueOldGame(GFxClikWidget.EventData ev)
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
			`log("continue");
			continueload();
      
			loadcurrentMapName = rGame.currentMapName;

			switch(loadcurrentMapName)
			{
                case ("ss_level_1"):
                    ConsoleCommand("open SS_Level_1");
					CloseMovie();
                    break;
                case ("ss_level_2"):
                    ConsoleCommand("open SS_Level_2");
					CloseMovie();
                    break;
				case ("ss_level_3"):
                    ConsoleCommand("open SS_Level_3");
					CloseMovie();
                    break;
				case ("ss_level_4"):
                        ConsoleCommand("open SS_Level_4");
						CloseMovie();
                        break;
				case ("ss_level_5"):
                    ConsoleCommand("open SS_Level_5");
					CloseMovie();
                    break;
				case ("ss_level_6"):
                    ConsoleCommand("open SS_Level_6");
					CloseMovie();
                    break;
				case ("ss_level_7"):
                    ConsoleCommand("open SS_Level_7");
					CloseMovie();
                    break;
				case ("ss_level_8"):
                    ConsoleCommand("open SS_Level_8");
					CloseMovie();
                    break;
				case ("ss_level_9"):
                    ConsoleCommand("open SS_Level_9");
					CloseMovie();
                    break;
				case ("ss_level_10"):
                    ConsoleCommand("open SS_Level_10");
					CloseMovie();
                    break;
				case ("ss_level_11"):
                    ConsoleCommand("open SS_Level_11");
					CloseMovie();
                    break;
				case ("ss_level_12"):
                    ConsoleCommand("open SS_Level_12");
					CloseMovie();
                    break;
				case ("ss_level_13"):
                    ConsoleCommand("open SS_Level_13");
					CloseMovie();
                    break;
				case ("SS_Level_14"):
                    ConsoleCommand("open SS_Level_14");
					CloseMovie();
                    break;
				case ("ss_level_15"):
                    ConsoleCommand("open SS_Level_15");
					CloseMovie();
                    break;
				case ("ss_level_16"):
                    ConsoleCommand("open SS_Level_16");
					CloseMovie();
                    break;
				case ("ss_level_17"):
                    ConsoleCommand("open SS_Level_17");
					CloseMovie();
                    break;
				case ("ss_level_18"):
                    ConsoleCommand("open SS_Level_18");
					CloseMovie();
                    break;
				case ("ss_level_19"):
                    ConsoleCommand("open SS_Level_19");
					CloseMovie();
                    break;
				case ("ss_level_20"):
                    ConsoleCommand("open SS_Level_20");
					CloseMovie();
                    break;
				case ("ss_level_21"):
                    ConsoleCommand("open SS_Level_21");
					CloseMovie();
                    break;
				case ("ss_level_22"):
                    ConsoleCommand("open SS_Level_22");
					CloseMovie();
                    break;
				case ("ss_level_23"):
                    ConsoleCommand("open SS_Level_23");
					CloseMovie();
                    break;
				case ("ss_level_24"):
                    ConsoleCommand("open SS_Level_24");
					CloseMovie();
                    break;
				case ("ss_level_25"):
                    ConsoleCommand("open SS_Level_25");
					CloseMovie();
                    break;
				case ("ss_level_26"):
                    ConsoleCommand("open SS_Level_26");
					CloseMovie();
                    break;
				case ("ss_level_27"):
                    ConsoleCommand("open SS_Level_27");
					CloseMovie();
                    break;
				case ("ss_level_28"):
                    ConsoleCommand("open SS_Level_28");
					CloseMovie();
                    break;
				case ("ss_level_29"):
                    ConsoleCommand("open SS_Level_29");
					CloseMovie();
                    break;
				case ("ss_level_30"):
                    ConsoleCommand("open SS_Level_30");
					CloseMovie();
                    break;
                default:
                    ConsoleCommand("open Swingin_MainMenu");
					CloseMovie();
			}	
		}
	}

	CloseMovie();
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function CloseMovie()
{
    RootMC.GoToAndPlay("close");
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function newload()
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
			rGame.currentMapName = "SS_Level_1";
			//rGame.highScore = 1; //Set the PC’s highScore to the value we loaded
			rGame.MaxStamina = 10.f;
			rGame.TotalStamina = 10.f;
			rGame.coffeeMugCount = 0;
			savePCVariables();
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function continueload()
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
			gameState =  new class'DH_GameState';
 
			// Load the variables gamestate using BasicLoadObject
			// Version 0: Development

			if(class'Engine'.static.BasicLoadObject(gameState, "..\\..\\..\\Swingin\\Saves\\SS.bin", true, 0)) //Load only if the file actually exists
			{

//				rGame.highScore = gameState.highScore; //Set the PC’s highScore to the value we loaded
				rGame.currentMapName = gameState.currentMapName; 
				rGame.MaxStamina = gameState.MaxStamina;
				rGame.TotalStamina = rGame.MaxStamina;
				rGame.coffeeMugCount = gameState.coffeeMugCount;
			}
			else
			{
				`Log("File not found while loading PC’s variables");
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function savePCVariables()
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
			//gameState.highScore = rGame.highScore; //Set the gameState’s highScore to the PC’s highScore

			gameState.MaxStamina = rGame.MaxStamina;
			rGame.TotalStamina = rGame.MaxStamina;
			gameState.coffeeMugCount = rGame.coffeeMugCount;

			// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "..\\..\\..\\Swingin\\Saves\\SS.bin", true, 0);
		}
	}
}



//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
	//each widget acted upon in code should be bound to its correct class type
    WidgetBindings.Add((WidgetName="newGame", WidgetClass=class'GFxClikWidget'))
    WidgetBindings.Add((WidgetName="continueGame", WidgetClass=class'GFxClikWidget'))
	

  
    bEnableGammaCorrection=FALSE
    bPauseGameWhileActive=FALSE
    bCaptureInput=true

	  //The path to the swf asset we will create later
        MovieInfo=SwfMovie'SS_MainMenu_HighScore.SS_MainMenu_HighScore'
}
