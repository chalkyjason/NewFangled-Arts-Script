// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Initializing the ScaleForm HUD for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_SF_Hud extends MobileHUD;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
//Reference the actual SWF container
var SS_Gfx_Hud HudMovie;
//var SS_Gfx_LevelIntro LevelIntroMovie;
var SS_PlayerController PO;
var GFxMoviePlayer PauseMenuMovie;
//---------------------------------------------------------------------------------------------------------------\\
// Events
singular event Destroyed ()
{
    // if there is no flash file to play for the HUD
    if (HudMovie != none)
    {
        //get rid of the memory usage of HudMovie
        HudMovie.Close(true);
        HudMovie = none;
    }  
}
//---------------------------------------------------------------------------------------------------------------\\
// Functions
//Called after game loaded - initialize
simulated function PostBeginPlay()
{
    super.PostBeginPlay();
           
    //create a STGFxHUD for HudMovie
    HudMovie = new class'SS_Gfx_Hud';
    //play the HUD movie for the player
    HudMovie.PlayerOwner = PO;
    //used so you can pause the game
    HudMovie.SetTimingMode(TM_Real);
    //Call HudMovie's initialize function
    HudMovie.Init2(HudMovie.PlayerOwner);


}
//---------------------------------------------------------------------------------------------------------------\\
//Called every tick the HUD should be updated
event PostRender()
{
        HudMovie.TickHUD();
}
//---------------------------------------------------------------------------------------------------------------\\
exec function ShowMenu()
{
    // if using GFx HUD, use GFx pause menu
    TogglePauseMenu();
}
 ////////////////////\\\\\\\\\\\\\\\\\\\\
/*
* Toggle the Pause Menu on or off.
*
*/
function TogglePauseMenu()
{
	if ( PauseMenuMovie != none && PauseMenuMovie.bMovieIsOpen )
    { 
		PauseMenuMovie.Close();
    }
    else
	{
		PlayerOwner.SetPause(True);
 
		if (PauseMenuMovie == None)
		{
			PauseMenuMovie = new class'SS_PauseMenu';
			PauseMenuMovie.MovieInfo = SwfMovie'SS_Pause.SS_Pause';
			PauseMenuMovie.bEnableGammaCorrection = FALSE;
			PauseMenuMovie.LocalPlayerOwnerIndex = class'Engine'.static.GetEngine().GamePlayers.Find(LocalPlayer(PlayerOwner.Player));
			PauseMenuMovie.SetTimingMode(TM_Real);
		}
 
		//SetVisible(false);
		PauseMenuMovie.Start();
		//PauseMenuMovie.PlayOpenAnimation();
		PauseMenuMovie.AddFocusIgnoreKey('Escape');
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\ 
//UnPause and close Pause HUD SWF
function CompletePauseMenuClose()
{
	PlayerOwner.SetPause(False);
	PauseMenuMovie.Close(false);
}
//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{

}

