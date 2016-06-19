// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Brad Fairley, Chris Augilar
// Purpose: Initializing the Player Inputs for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Input extends PlayerInput within SS_PlayerController
    config(Input);
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var bool bMyButton, bMyButtonPressed, bMyButtonHeld, bMyButtonWasHeld, bMyButtonReleased, bMyButtonDoubletapped, bOld_MyButton;
var float LastPressedMyButtonTime;
var bool RunningState;
var bool SprintingState;
var bool drainStamina;


// Stored mouse position. Set to private write as we don't want other classes to modify it, but still allow other classes to access it.
var  IntPoint MousePosition; 
//---------------------------------------------------------------------------------------------------------------\\
// Functions
function MyButtonActions(float DeltaTime)
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
		if ( rGame != none )
		{
			bMyButtonPressed = bMyButton && !bOld_MyButton;
			bMyButtonDoubletapped = false;

			if (bMyButtonPressed)
			{
				if (WorldInfo.TimeSeconds - LastPressedMyButtonTime < DoubleClickTime)
					bMyButtonDoubletapped = true;
				else
					LastPressedMyButtonTime = WorldInfo.TimeSeconds;
			}
 
			bMyButtonWasHeld = bMyButtonHeld;
			if (bMyButton && bOld_MyButton && (WorldInfo.TimeSeconds - LastPressedMyButtonTime >= DoubleClickTime))
				bMyButtonHeld = true;
			else
				bMyButtonHeld = false;
 
			bMyButtonReleased = !bMyButton && bOld_MyButton;
 
			if (bMyButtonDoubletapped)
			{
				drainStamina = true;
				SprintCheck();
				Sprint();
			}
			else if (bMyButtonPressed)
			{
				//`log(" pressed");
			}
			else if (bMyButtonHeld)
			{
				//`log(" held");
				if(drainStamina == true)
				{
						rGame.TotalStamina = rGame.TotalStamina - 0.05f;
						SprintCheck();
				}
			}
			else if (bMyButtonReleased)
			{
				if (!bMyButtonWasHeld)
				{
					StopSprint();
					regenCheck();
				}
				else
				{
					StopSprint();
				}
			}
 
			bOld_MyButton = bMyButton;
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
// Events
//xbox Trigger input and held 
event PlayerInput( float DeltaTime )
{

	 // Handle mouse 
  // Ensure we have a valid HUD
  if (myHUD != None) 
  {
    // Add the aMouseX to the mouse position and clamp it within the viewport width
    MousePosition.X = Clamp(MousePosition.X + aMouseX, 0, myHUD.SizeX); 
    // Add the aMouseY to the mouse position and clamp it within the viewport height
    MousePosition.Y = Clamp(MousePosition.Y - aMouseY, 0, myHUD.SizeY); 

	//MousePosition.X = SS_PlayerController(PlayerController).GetUIController().SceneClient.MousePosition.X;

	

  }
    Super.PlayerInput(DeltaTime);
 
    // handle my custom button
    MyButtonActions(DeltaTime);
}
//---------------------------------------------------------------------------------------------------------------\\
// Exec Functions
simulated exec function MyButton()
{
    bMyButton = true;
}
////////////////////\\\\\\\\\\\\\\\\\\\\
//xbox trigger pressed true
simulated exec function MyXboxTrigger()
{
    Sprint();
	drainStamina = true;
}
 ////////////////////\\\\\\\\\\\\\\\\\\\\
// FIXME - stop using 'Un' as a prefix for momentary inputs being released
simulated exec function UnMyButton()
{
    bMyButton = false;
}
////////////////////\\\\\\\\\\\\\\\\\\\\
//xbox sprint check
simulated exec function UnMyXboxTrigger()
{
   StopSprint();
   drainStamina = false;
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function SprintCheck()
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
		if ( rGame != none)
		{
			if (rGame.TotalStamina <= 0 || bPressedJump == true)
			{
				StopSprint();
			}
			else
			{

			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function decreaseStamina()
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
		if ( rGame != none)
		{
			if (rGame.TotalStamina >= 0)
			{
				drainStamina = true;
				//rGame.TotalStamina = rGame.TotalStamina - 0.05f;
				SprintCheck();

			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function Sprint()
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
			if(rGame.TotalStamina > 0 )
			{
				Pawn.GroundSpeed =600.0;
				WorldInfo.Game.SetGameSpeed(1);
				decreaseStamina();
				rGame.BackTrail = WorldInfo. MyEmitterPool. SpawnEmitterMeshAttachment(ParticleSystem'RainbowRibbonForSkelMeshes.RainbowSwordRibbon', Pawn.Mesh, 'b_Spine2', false);
				rGame.BackTrail.SetScale( 2.5);
				rGame.HeadTrail = WorldInfo. MyEmitterPool. SpawnEmitterMeshAttachment(ParticleSystem'RainbowRibbonForSkelMeshes.RainbowSwordRibbon', Pawn.Mesh, 'b_head', false);
				rGame.HeadTrail.SetScale( 2.5);
			}
			else
			{
				StopSprint();
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function StopSprint()
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
			WorldInfo.Game.SetGameSpeed(1);
			Pawn.GroundSpeed = 400.0;
			drainStamina = false;
			rGame.BackTrail.SetStopSpawning( -1, true);
			rGame.HeadTrail.SetStopSpawning(-1, true);
		}
	}
	
}



//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
	drainStamina = false;
	bUsingGamepad = true;
}