// Author:  Newfangled Arts
// Date:    11/2014
// Credit:  Jason Chalky
// Purpose: To Zoom the camera in and out using a trigger volume
//---------------------------------------------------------------------------------------------------------------\\
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SS_SetCamera extends SequenceAction;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var() int zoomAmount;
var vector tempDistance;

//Events
event Activated()
{
     local SS_Gametype rGame;
	local WorldInfo rWorld;
	local int i;
	local int countZoom;

	
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

		//Set temp distance to current camera
			//`log(zoomAmount);
		tempDistance.Y = rGame.TestCamera.Y;
		countZoom = zoomAmount;

		//loop the amount the developer wants to zoom

		if(zoomAmount < 0)
		{
			
		for ( i = 0; i > zoomAmount ; i-- )
			{
		
				//change temp distance
				tempDistance.Y = tempDistance.Y - 2;
				//`log(tempDistance.Y);
				//Set camera to temp distace
				//Cant just subtract from camera because it needs to be a constant. 
				rGame.testCamera.Y = tempDistance.Y;
				//need to change this, maybe to true, it is not running throuhg the loop, just doing a zoom and exiting.
				//rGame.continueZoom = false;
				

				if(zoomAmount + countZoom <= zoomAmount )
				{
					rGame.continueZoom = true;
					countZoom++;
					
				}
				if(zoomAmount + countZoom >= zoomAmount)
				{
					rGame.continueZoom = false;
					
					
				}

			}

		}
				
		

		
		if(zoomAmount > 0)
		{
			

				for ( i = 0; i < zoomAmount; i++ )
			{
		
				//change temp distance
				tempDistance.Y = tempDistance.Y + 2;
		
				//Set camera to temp distace
				//Cant just add from camera because it needs to be a constant. 
				rGame.testCamera.Y = tempDistance.Y;

					if(zoomAmount - countZoom >= zoomAmount )
				{
					rGame.continueZoom = true;
					countZoom++;
					
				}
				if(zoomAmount - countZoom <= zoomAmount)
				{
					rGame.continueZoom = false;
					
					
				}
				
			}
			
		}
		}
	}
}

defaultproperties
{
	ObjName="SS_SetCamera"
	ObjCategory="SwinginSwiggins Actions"
	zoomAmount = -1000
	
}

