// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Timothy Janssen, Brad Fairley, Andy Montgomery, Chris Augilar, Jesse Mangano
// Purpose: Initializing the Classic HUD for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_HUD extends UDKHUD;
//---------------------------------------------------------------------------------------------------------------\\
// Functions
function DrawHUD()
{
	local WorldInfo rWorldInfo;

	super.DrawHUD();

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		DrawStamina();
		//DrawDeathTotal();
		DrawTimer();
		DrawGoldWin();
		DrawSilverWin();
		DrawBronzeWin();
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function DrawGoldWin()
{
	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);     

		if (rGame != none )
			{
			if (rGame.CountDownTMR.Sec <= 9 && rGame.GoldTrue == true )
			{
				Canvas.Font = class'Engine'.static.GetLargeFont(); 
				Canvas.SetDrawColor(255,255,0);
				Canvas.SetPos(500,200);
				Canvas.DrawText("You achieved Gold ! -  "$rGame.CountDownTMR.Min$":0"$rGame.CountDownTMR.Sec);
			}
			if(rGame.CountDownTMR.Sec >= 9 && rGame.GoldTrue == true)
			{
				Canvas.Font = class'Engine'.static.GetLargeFont(); 
				Canvas.SetDrawColor(255,255,0);
				Canvas.SetPos(500,200);
				Canvas.DrawText("You achieved Gold ! - "$rGame.CountDownTMR.Min$":"$rGame.CountDownTMR.Sec);
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function DrawSilverWin()
{
	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);     
		if (rGame != none )
		{
			if ( rGame.CountDownTMR.Sec <= 9 && rGame.SilverTrue == true )
			{  
				Canvas.Font = class'Engine'.static.GetLargeFont(); 
				Canvas.SetDrawColor(204,204,204);
				Canvas.SetPos(500,200);
				Canvas.DrawText("You achieved Silver ! -  "$rGame.CountDownTMR.Min$":0"$rGame.CountDownTMR.Sec);
			}
			else if (rGame.CountDownTMR.Sec >= 9 && rGame.SilverTrue == true)
			{
				Canvas.Font = class'Engine'.static.GetLargeFont(); 
				Canvas.SetDrawColor(204,204,204);
				Canvas.SetPos(500,200);
				Canvas.DrawText("You achieved Silver ! - "$rGame.CountDownTMR.Min$":"$rGame.CountDownTMR.Sec);
			}
		}
	}			
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function DrawBronzeWin()
{
	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);     

		if (rGame != none )
		{
			if ( rGame.CountDownTMR.Sec <= 9 && rGame.BronzeTrue == true )
			{  
				Canvas.Font = class'Engine'.static.GetLargeFont(); 
				Canvas.SetDrawColor(205,127,50);
				Canvas.SetPos(500,200);
				Canvas.DrawText("You achieved Bronze ! -  "$rGame.CountDownTMR.Min$":0"$rGame.CountDownTMR.Sec);
			}
			else if (rGame.CountDownTMR.Sec >= 9 && rGame.BronzeTrue == true)
			{
				Canvas.Font = class'Engine'.static.GetLargeFont(); 
				Canvas.SetDrawColor(205, 127, 50);
				Canvas.SetPos(500,200);
				Canvas.DrawText("You achieved Bronze ! - "$rGame.CountDownTMR.Min$":"$rGame.CountDownTMR.Sec);
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function DrawStamina()
{
	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);     

		Canvas.Font = class'Engine'.static.GetLargeFont();      
		Canvas.SetDrawColor(255, 255, 255); // White
		Canvas.SetPos(70, 15);
   
		Canvas.DrawText("Stamina");

		if(rGame.TotalStamina < 3.0f)
		{
			Canvas.SetDrawColor(255, 0, 0); // Red
		}
		else if (rGame.TotalStamina < 6.0f)
		{
			Canvas.SetDrawColor(255, 255, 0); // Yellow
		} 
		else 
		{
			Canvas.SetDrawColor(0, 255, 0); // Green
		}
 
		Canvas.SetPos(200, 15);   
		Canvas.DrawRect(20 * rGame.TotalStamina, 30);      
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/*
function DrawDeathTotal()
{

	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);     

		Canvas.Font = class'Engine'.static.GetLargeFont();      
		Canvas.SetDrawColor(255, 255, 255); // White
		Canvas.SetPos(70, 45);
   
		Canvas.DrawText("DeathTotal:  " @ rGame.PlayersDeathTotal, ,1.0f,1.0f);     
	}
}
*/
////////////////////\\\\\\\\\\\\\\\\\\\\
function DrawTimer()
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
			if ( rGame.CountDownTMR.Sec <= 9 )
			{
				Canvas.SetDrawColor(0,255,0);
				Canvas.SetPos(700,10);
				Canvas.DrawText("Time Remaining - "$rGame.CountDownTMR.Min$":0"$rGame.CountDownTMR.Sec);
			}
			else
			{
				Canvas.SetDrawColor(0,255,0);
				Canvas.SetPos(700,10);
				Canvas.DrawText("Time Remaining - "$rGame.CountDownTMR.Min$":"$rGame.CountDownTMR.Sec);
			}
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{
  
}