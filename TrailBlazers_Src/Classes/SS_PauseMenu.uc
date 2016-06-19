// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Initializing the Pause Menu for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_PauseMenu extends GFxMoviePlayer;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var GFxObject RootMC;
var GFxClikWidget ResumeButton;
var GFxClikWidget RestartButton;
var GFxClikWidget ExitButton;
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
			RootMC.SetInt("coffee",rGame.coffeeMugCount);
    `log("RootMC = "$RootMC);
           
    AddCaptureKey('XboxTypeS_A');
    AddCaptureKey('XboxTypeS_Start');
    AddCaptureKey('Enter');
	AddCaptureKey('Gamepad_LeftStick_Left');
    AddCaptureKey('Gamepad_LeftStick_Right');
    AddCaptureKey('Gamepad_LeftStick_Up');
    AddCaptureKey('Gamepad_LeftStick_Down');
	AddCaptureKey('XboxTypeS_DPad_Left');
	AddCaptureKey('XboxTypeS_DPad_Right');
	AddCaptureKey('XboxTypeS_DPad_Up');
	AddCaptureKey('XboxTypeS_DPad_Down');

	//RootMC.SetInt("coffee",rGame.coffeeMugCount);

           
    return true;

		}
	}
}
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
        case ('resume'):
            ResumeButton = GFxClikWidget(Widget);
            ResumeButton.AddEventListener('CLIK_press', ResumePressed);
            break;
        case ('restart'):
            RestartButton = GFxClikWidget(Widget);
            RestartButton.AddEventListener('CLIK_press', RestartLevel);
            break;
        case ('exit'):
            ExitButton = GFxClikWidget(Widget);
            ExitButton.AddEventListener('CLIK_press', MainMenu);
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
function ResumePressed(GFxClikWidget.EventData ev)
{
        SS_SF_HUD(GetPC().MyHUD).CompletePauseMenuClose();
}
////////////////////\\\\\\\\\\\\\\\\\\\\   
function RestartLevel(GFxClikWidget.EventData ev)
{
    local string currentMapName;
    local WorldInfo WI;
           
    WI = class'WorldInfo'.static.GetWorldInfo();
    currentMapName = WI.GetMapName(false);
    // currentMapName = WI.Title;
    `log("Maps Name" $ currentMapName);
    switch(currentMapName)
    {	
        case ("SS_Level_1"):
            ConsoleCommand("open SS_Level_1");
            break;
        case ("SS_Level_2"):
            ConsoleCommand("open SS_Level_2");
            break;
		case ("SS_Level_3"):
            ConsoleCommand("open SS_Level_3");
            break;
		case ("SS_Level_4"):
            ConsoleCommand("open SS_Level_4");
            break;
		case ("SS_Level_5"):
            ConsoleCommand("open SS_Level_5");
            break;
		case ("SS_Level_6"):
            ConsoleCommand("open SS_Level_6");
            break;
		case ("SS_Level_7"):
            ConsoleCommand("open SS_Level_7");
            break;
		case ("SS_Level_8"):
            ConsoleCommand("open SS_Level_8");
            break;
		case ("SS_Level_9"):
            ConsoleCommand("open SS_Level_9");
            break;
		case ("SS_Level_10"):
            ConsoleCommand("open SS_Level_10");
            break;
		case ("SS_Level_11"):
            ConsoleCommand("open SS_Level_11");
            break;
		case ("SS_Level_12"):
            ConsoleCommand("open SS_Level_12");
            break;
		case ("SS_Level_13"):
            ConsoleCommand("open SS_Level_13");
            break;
		case ("SS_Level_14"):
            ConsoleCommand("open SS_Level_14");
            break;
		case ("SS_Level_15"):
            ConsoleCommand("open SS_Level_15");
            break;
		case ("SS_Level_16"):
            ConsoleCommand("open SS_Level_16");
            break;
		case ("SS_Level_17"):
            ConsoleCommand("open SS_Level_17");
            break;
		case ("SS_Level_18"):
            ConsoleCommand("open SS_Level_18");
            break;
		case ("SS_Level_19"):
            ConsoleCommand("open SS_Level_19");
            break;
		case ("SS_Level_20"):
            ConsoleCommand("open SS_Level_20");
            break;
		case ("SS_Level_21"):
            ConsoleCommand("open SS_Level_21");
            break;
		case ("SS_Level_22"):
            ConsoleCommand("open SS_Level_22");
            break;
		case ("SS_Level_23"):
            ConsoleCommand("open SS_Level_23");
            break;
		case ("SS_Level_24"):
            ConsoleCommand("open SS_Level_24");
            break;
		case ("SS_Level_25"):
            ConsoleCommand("open SS_Level_25");
            break;
		case ("SS_Level_26"):
            ConsoleCommand("open SS_Level_26");
            break;
		case ("SS_Level_27"):
            ConsoleCommand("open SS_Level_27");
            break;
		case ("SS_Level_28"):
            ConsoleCommand("open SS_Level_28");
            break;
		case ("SS_Level_29"):
            ConsoleCommand("open SS_Level_29");
            break;
		case ("SS_Level_30"):
            ConsoleCommand("open SS_Level_30");
            break;
        default:
			ConsoleCommand("open Swingin_MainMenu");
    }
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function MainMenu(GFxClikWidget.EventData ev)
{
	ConsoleCommand("open Swingin_MainMenu");
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function CloseMovie()
{
	RootMC.GoToAndPlay("close");
}
//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{
	//each widget acted upon in code should be bound to its correct class type
	WidgetBindings.Add((WidgetName="resume", WidgetClass=class'GFxClikWidget'))
	WidgetBindings.Add((WidgetName="restart", WidgetClass=class'GFxClikWidget'))
	WidgetBindings.Add((WidgetName="exit", WidgetClass=class'GFxClikWidget'))
           
	bEnableGammaCorrection=FALSE
	bPauseGameWhileActive=TRUE
	bCaptureInput=true
	
	//bShowHardwareMouseCursor = true;
}
     

