// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Initializing the ScaleFrom HUD for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Gfx_Hud extends GFxMoviePlayer;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
//Create a Health Cache variable
var float stamina;
var int mTimerMin;
var int mTimerSec;  

var float TimeRemaining;
// Create variables to hold references to the Flash MovieClips and Text Fields that will be modified
var GFxObject MainHUDMC, staminaBarMC, staminaBarYellow, staminaBarRed;
var GFxObject goldText, silverText, bronzeText,staminaText,timerTextMin, timerTextSec;
var GFxObject greenZero,  yellowZero,  redZero,timerYellowSec,timerRedSec ;


var GFxObject BlueTimer,RedTimer;
// Reference our player controller
var SS_PlayerController PlayerOwner;
//---------------------------------------------------------------------------------------------------------------\\
// Functions
// Round a float value to an int
function int roundNum(float NumIn)
{
    local int iNum;
    local float fNum;
     
    fNum = NumIn;
    iNum = int(fNum);
    fNum -= iNum;
    if (fNum >= 0.5f)
    {
        return (iNum + 1);
    }
    else
    {
        return iNum;
    }
}
////////////////////\\\\\\\\\\\\\\\\\\\\
//  Function to return a percentage by dividing the actual value from the maximum value
function int getpc2(int val, int max)
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);

		if ( rGame != none )
			//need to change this so it works with maxstamina;
			return roundNum((float(val) / float(max)) * 100.0f);
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
//Called from AegisHUD'd PostBeginPlay() to begin playing the HUD movie
function Init2(PlayerController PC)
{
        //Start and load the SWF Movie
        Start();
        Advance(0.f);
		//set scale so it fits to screen
		//https://forums.epicgames.com/threads/759121-SetViewScaleMode-SetAlignment-and-SetViewport

		SetViewScaleMode(SM_ExactFit);
		
			
        //Set the cache value to something rediculous to know it gets updated on the first tick
        stamina = 2000;
     
        //Load the references using the instance names from our HUD movie flash file
        MainHUDMC = GetVariableObject("_root.staminaBase");

        staminaBarMC = GetVariableObject("_root.staminaBase.staminaBar");
		staminaBarYellow = GetVariableObject("_root.staminaBase.YellowFill2");
		staminaBarRed = GetVariableObject("_root.staminaBase.RedFill");
        staminaText = GetVariableObject("_root.staminaBase.staminaText");

		timerTextMin = GetVariableObject("_root.timerMin");
		timerTextSec = GetVariableObject("_root.timerSec");
		timerYellowSec = GetVariableObject("_root.secYellow");

		greenZero = GetVariableObject("_root.gZero");
		yellowZero = GetVariableObject("_root.yZero");
		redZero = GetVariableObject("_root.rZero");
		
		timerRedSec = GetVariableObject("_root.secRed");

		
		goldText = GetVariableObject("_root.gold");
		silverText = GetVariableObject("_root.silver");
		bronzeText = GetVariableObject("_root.bronze");

		BlueTimer = GetVariableObject("_root.BlueTimer");
		RedTimer = GetVariableObject("_root.RedTimer");

	
}
////////////////////\\\\\\\\\\\\\\\\\\\\
//Updates the HUD
function TickHUD()
//going to set stamina here
{

	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);

		if ( rGame != none )
			//If the cached value for Health percentage isn't equal to the current...

		{
				
					
				
		
			if (stamina != rGame.TotalStamina)
			{
                //...Make it so...
                stamina = rGame.TotalStamina;
					
                //...Update the bar's xscale (but don't let it go over 100)...
				//  staminaBarMC.SetFloat("_xscale", (stamina > rGame.MaxStamina) ? rGame.MaxStamina : stamina);
                //...and update the text field
                
				staminaText.SetInt("text",roundNum(stamina));
					
				staminaBarMC.SetFloat("_xscale",(stamina/rGame.MaxStamina) * 100);
				staminaBarYellow.SetFloat("_xscale",(stamina/rGame.MaxStamina) * 100);
				staminaBarRed.SetFloat("_xscale",(stamina/rGame.MaxStamina) * 100);

			

				
				

	

				//Remove bar to change color
					
				//if(rGame.TotalStamina < 5.0f && rGame.TotalStamina > 3.0f)
				
				if(rGame.TotalStamina < 5.0f)
				{
						staminaBarRed.SetVisible(true);
					//staminaBarMC.SetVisible(true);
					staminaBarYellow.SetVisible(false);
				}

				if(rGame.TotalStamina < 3.0f)
				{
					//staminaBarMC.SetVisible(false);
					staminaBarRed.SetVisible(true);
				}
				if(rGame.TotalStamina > 5.0f)
				{
					staminaBarYellow.SetVisible(true);
					staminaBarRed.SetVisible(false);
				}

			}
		
				convertTime();

				if(TimeRemaining > 30)
				{
					BlueTimer.SetVisible(true);
					RedTimer.SetVisible(false);

				}

				if(TimeRemaining <= 30)
				{
					BlueTimer.SetVisible(false);
					RedTimer.SetVisible(true);
				}


				BlueTimer.SetFloat("_xscale",(TimeRemaining/rGame.TimeStarted) * 100);
				RedTimer.SetFloat("_xscale",(TimeRemaining/rGame.TimeStarted) * 100);
					
				if(mTimerMin > -1.0 && mTimerSec > -1.0)
			{
				mTimerMin = rGame.CountDownTMR.Min;
				mTimerSec = rGame.CountDownTMR.Sec;

				timerTextMin.SetInt("text",round(mTimerMin));
                timerTextSec.SetInt("text",roundNum(mTimerSec));
				timerYellowSec.SetInt("text",roundNum(mTimerSec));
				timerRedSec.SetInt("text",roundNum(mTimerSec));


				//mTimerMin >= 1 
				if( mTimerMin >= 1 || mTimerSec > 30)
				{
					timerTextMin.SetVisible(true);
					timerTextSec.SetVisible(true);
					timerYellowSec.SetVisible(false);
					timerRedSec.SetVisible(false);
			
					greenZero.SetVisible(false);
					yellowZero.SetVisible(false);
					redZero.SetVisible(false);
						
					if(mTimerSec > 9)
					{
						//greenZero.SetVisible(false);					
					}
							
					if( mTimerSec < 10)
					{
						greenZero.SetVisible(true);
						greenZero.SetInt("text",0);
					}
				}
					
				if(mTimerMin < 1 && mTimerSec <= 30)
				{
					timerTextMin.SetVisible(false);
					timerTextSec.SetVisible(false);
					greenZero.SetVisible(false);
					timerYellowSec.SetVisible(false);
					timerRedSec.SetVisible(true);
					redZero.SetVisible(false);
					timerYellowSec.SetInt("text",roundNum(mTimerSec));
					timerRedSec.SetInt("text",roundNum(mTimerSec));

					if(mTimerSec > 9)
					{
							redZero.SetVisible(false);
						//yellowZero.SetVisible(false);
					}
							
					if(mTimerSec < 10)
					{
						redZero.SetVisible(true);
						redZero.SetInt("text",0);

						//yellowZero.SetVisible(true);
						//yellowZero.SetInt("text",0);
					}
				}

				if(mTimerMin < 1 && mTimerSec <= 30)
				{
					timerYellowSec.SetVisible(false);
					timerTextMin.SetVisible(false);
					timerTextSec.SetVisible(false);
					yellowZero.SetVisible(false);
					greenZero.SetVisible(false);
					redZero.SetVisible(false);
					timerRedSec.SetVisible(true);
					timerTextSec.SetInt("text",  roundNum(mTimerSec));
					timerRedSec.SetInt("text",roundNum(mTimerSec));

					if(mTimerSec > 9)
					{
						
						redZero.SetVisible(false);					
					}
							
					if(mTimerSec < 10)
					{
						//timerRedSec.SetVisible(false);
						redZero.SetVisible(true);
						redZero.SetInt("text",0);
					}
				}
			}
	}
}

}

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
				TimeRemaining = rGame.CountDownTMR.Min * 60.0;
				TimeRemaining = TimeRemaining + rGame.CountDownTMR.Sec;
			}
			if(rGame.CountDownTMR.Min < 1)
			{
					TimeRemaining = rGame.CountDownTMR.Sec;
			}
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
        //hide the flash movie if the HUD is hidden
        bDisplayWithHudOff=false

        //The path to the swf asset we will create later
        MovieInfo=SwfMovie'SF_Hud.SS_SF_Hud'
}
