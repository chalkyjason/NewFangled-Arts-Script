// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Timothy Janssen, Brad Fairley, Andy Montgomery, Chris Augilar, Jesse Mangano
// Purpose: Initializing the Player Controller for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_PlayerController extends PlayerController;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var float TimeSecondsDelay;
var Actor LastRope;
var RB_BSJointActor swingingJoint;
var bool RopeGrab;

var Vector Destination;
var bool isLerping;
var bool climbingUp;
var bool climbingDown;

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



//---------------------------------------------------------------------------------------------------------------\\
// Events
/* 
 * This function is over written to initialize our class members and resources
 * */
simulated event PostBeginPlay()
{
	SetTimer ( 0.05f, true, 'regen' );
	//SetTimer(0.01f,true,'SSRespawn');
	// Super will call the specified parent version of this extended script
	super.PostBeginPlay();


	// Set up time for our delay(s)
	TimeSecondsDelay = WorldInfo.TimeSeconds;
}
//---------------------------------------------------------------------------------------------------------------\\
// Functions
exec function ShiftDownFunction()
{
	//Will script for the shift button to work on his computer
	/*
	RopeGrab = !RopeGrab;
	`Log("RopeGrab is " @ RopeGrab ? "true" : "false");

	if (!RopeGrab)
	{
		Pawn.DoJump(true);
		bPressedJump = true;
		swingingJoint = none;
	}*/


	`Log("User has pressed grab key");
	RopeGrab = true;
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function ShiftUpFunction()
{
	RopeGrab = false;
	`Log("User has released grab key");
	if (swingingJoint != none) 
	{
		if(RopeGrab == false)
		{
			Pawn.DoJump(true);
			bPressedJump = true;
		}
		if(RopeGrab == false && swingingJoint != none)
		{
			swingingJoint = none;
		}
		if(RopeGrab == true && swingingJoint == none)
		{
			RopeGrab = false;
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function SpacebarCheck()
{
	if (swingingJoint != none)
	{
		if(RopeGrab == true)
		{
			`Log("False Jump");
			bPressedJump = false;
		}
	}
	else if(swingingJoint == none)
	{
		`Log("True Jump");
		bPressedJump = true;
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This function is over written to shut down any other class members we added and resources
 * */
simulated event Destroyed()
{
	// Super will call the specified parent version of this extended script
	super.Destroyed();
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This function is over written to update our class members and resources
 * */
simulated event Tick(float DeltaTime)
{
	SS_Input(PlayerInput).SprintCheck();

	// Super will call the specified parent version of this extended script
	super.Tick(DeltaTime);
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This state is auto enabled for our custom movement
 * Taken from UDN Camera Technical Guide
 * */
//---------------------------------------------------------------------------------------------------------------\\
// States
auto state PlayerWalking
{
	ignores SeePlayer, HearNoise, Bump;

	/* 
	 * This function is over written to apply movement for our possessed pawn, including rope swings
	 * Taken from UDN Camera Technical Guide - For Side Scroller(s)
	 * */
	// Are we trying to move?
	function ProcessMove(float DeltaTime, Vector NewAccel, EDoubleClickDir Doubleclickmove, Rotator DeltaRot)
	{

		local Rotator tempRot;
       //local eDoubleClickDir DoubleClickMove;	
		local WorldInfo rWorldInfo;
		local SS_Gametype rGame;
	
		rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

		if(rWorldInfo != none)
		{
			rGame = SS_Gametype(rWorldInfo.Game);

			if ( rGame != none )
			{

				if(Pawn == none)
			{
				return;
			}
			if(Role == ROLE_Authority)
			{
				Pawn.SetRemoteViewPitch(Rotation.Pitch);
			}

			CheckJumpOrDuck();

			if (PlayerInput.aStrafe != 0)
			{
				newAccel.X = PlayerInput.aStrafe * DeltaTime * 100 * PlayerInput.MoveForwardSpeed;
				newAccel.Y = 0;
				newAccel.Z = 0;
				//set var for jumping off rope left or right
				rGame.OurView = PlayerInput.aStrafe;
				// set bool to fall down with s
				rGame.FallDown = false;
				rGame.CurrentPlayersLocation = SS_Pawn(Pawn).Location;
				spawnCheckPoints();
			}
			else
			
				NewAccel = vect(0,0,0);
		
			CheckJumpOrDuck();
			tempRot.Pitch = Pawn.Rotation.Pitch;
			tempRot.Roll = 0;
			if(Normal(NewAccel) dot vect(1,0,0) > 0)
			{
				tempRot.Yaw =  0;
				Pawn.SetRotation(tempRot);
			}
			else if(Normal(NewAccel) dot vect(1,0,0) < 0)
			{
				tempRot.Yaw = 32768;
				Pawn.SetRotation(tempRot);
			}

			// Are we swinging? We may need different movement
			if(swingingJoint != none)
			{
				SS_Input(PlayerInput).StopSprint();
				isLerping = true;

				if(PlayerInput.aForward > 0.0f && SS_Rope(LastRope).NextJoint != none &&  (WorldInfo.TimeSeconds - TimeSecondsDelay) >= 0.2f)
				{
					TimeSecondsDelay = WorldInfo.TimeSeconds;
					swingingJoint = SS_Rope(LastRope).NextJoint;
					LastRope = swingingJoint.ConstraintActor2;
					climbingUp = true;
				}
				else if(PlayerInput.aForward < 0.0f && SS_Rope(LastRope).PrevJoint != none && (WorldInfo.TimeSeconds - TimeSecondsDelay) >= 0.2f)
				{
					TimeSecondsDelay = WorldInfo.TimeSeconds;
					swingingJoint = SS_Rope(LastRope).PrevJoint;
					LastRope = swingingJoint.ConstraintActor2;
					climbingDown = true;
				}
				else if(PlayerInput.aForward < 0.0f && SS_Rope(LastRope).PrevJoint == none && (WorldInfo.TimeSeconds - TimeSecondsDelay) >= 0.2f)
				{
					TimeSecondsDelay = WorldInfo.TimeSeconds;
					rGame.FallDown = true;
				}

				else if(PlayerInput.aForward == 0.0f && SS_Rope(LastRope).PrevJoint == none && (WorldInfo.TimeSeconds - TimeSecondsDelay) >= 0.2f)
				{
					TimeSecondsDelay = WorldInfo.TimeSeconds;
					rGame.FallDown = false;
				}
				else if(LastRope.IsA('KActor'))
				{
					KActor(LastRope).ApplyImpulse(Normal(NewAccel), Pawn.GroundSpeed / 70, Pawn.Location);
				}	

				// Force pawn to latch onto the rope we are on
				Pawn.SetLocation(Pawn.Location);
				Pawn.ReattachComponent (Pawn.Mesh);
				Destination = LastRope.Location;
				Pawn.ForceUpdateComponents();
			}
			else
			{
				// If not we move the pawn like normal - with Acceleration
				isLerping = false;
				climbingUp = false;
				climbingDown = false;
				rGame.FallDown = false;
				Pawn.Acceleration = newAccel;
			}      
			}
		}
	}
}
//---------------------------------------------------------------------------------------------------------------\\
// Functions
/* 
 * This function is over written to update our pawn view rotation
 * Taken from UDN Camera Technical Guide - For Side Scroller(s)
 * */
function UpdateRotation( float DeltaTime )
{
	local Rotator	DeltaRot, ViewRotation;

	ViewRotation = Rotation;
	if (Pawn!=none)
	{
		Pawn.SetDesiredRotation(ViewRotation);
	}

	// Calculate Delta to be applied on ViewRotation
	DeltaRot.Yaw	= Pawn.Rotation.Yaw;
	DeltaRot.Pitch	= PlayerInput.aLookUp;

	ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
	SetRotation(ViewRotation);

	if ( Pawn != None )
		Pawn.FaceRotation(DeltaRot, deltatime);
} 
////////////////////\\\\\\\\\\\\\\\\\\\\
function regenCheck()
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);

		if ( rGame != none )
		{
			if (rGame.TotalStamina >= rGame.MaxStamina)
			{
				rGame.TotalStamina = rGame.MaxStamina;
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function regen ()
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);

		if ( rGame != none )
		{
			if ( rGame.TotalStamina != rGame.MaxStamina && SS_Pawn (Pawn).Velocity.X == 0 && swingingJoint == none )
			{
				rGame.TotalStamina += 0.20085f;
				regenCheck();
			}
		     /*if(SS_Pawn(Pawn).Health > 0)
			{
				// Does nothing
			}*/
			if (SS_Pawn(Pawn).Health == 0)
			{
                rGame.SS_Health = 0;
				//player died so respawn

				//Need to add save here maybe
				SSRespawn();
				

				WorldInfo.Game.Broadcast ( self, "You fell hard bro. Get up and swing again!" );
				//Set back to max stamina
				rGame.TotalStamina = rGame.MaxStamina;
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function SSRespawn()
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);

		if ( rGame != none )
		{	
			if (rGame.SS_Health == 0)
			{
				rGame.SS_Health = 100;
				
				//rGame.playersLocation = rGame.playersLocation - rGame.respawnOffset;
				
			
				rGame.P = Spawn(class'SS_Pawn',self,,rGame.playersLocation,Pawn.Rotation);
				
				Possess(rGame.P,false);

				spawnCheckPoints();
			
				//Spawn(class'SS_Pawn',self,,rGame.playersLocation,Pawn.Rotation);
				
				// Spawns all the collectibles that are not in the world
				
				//Removed to stop double spawning. 

				//for ( i = 0; i < rGame.spawnLocation.Length; i ++ )
				//{
				//	Spawn ( class 'SS_Collection', , , rGame.spawnLocation[i] );
				//}

				// Clears all the arrays at the end of the level
				//rGame.isInWorld.Remove ( 0,rGame.isInWorld.Length );
				//rGame.spawnLocation.Remove ( 0, rGame.isInWorld.Length );
				//rGame.currentSeconds.Remove ( 0, rGame.currentSeconds.Length );
				
		

				rGame.PlayersDeathTotal++;
			}  
		}
	}
}

////////////////////////////////////////
function spawnCheckPoints()
{

	// Used for the array loops
	local int j;
	local int i;

	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);

		if ( rGame != none )
		{	
for ( j = 0; j < rGame.checkPointIsInWorld.Length; j++ )
	{
		if (!rGame.CheckPointIsInWorld[j])
		{
			for ( i = 0; i < rGame.checkPointSpawnLocation.Length; i++ )
			{
				rGame.CheckPointCurrentSeconds[i] += 1;
				if ( rGame.CheckPointCurrentSeconds[i] == 1 )
				{
					rGame.CheckPointIsInWorld[i] = true;
					Spawn (class 'SS_Respawn', , , rGame.checkPointSpawnLocation[i] );
					rGame.checkPointSpawnLocation.Remove (i, 1 );
					rGame.CheckPointIsInWorld.Remove ( i, 1 );
					rGame.CheckPointCurrentSeconds.Remove ( i, 1 );
				}
			}
		}
	}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function LerpCheck()
{
	local float offsetDistZ;

	if ( climbingDown )
	{
		offsetDistZ = SS_Pawn(Pawn).Location.Z - Destination.Z;
	}
	else if ( climbingUp )
	{
		offsetDistZ = Destination.Z - SS_Pawn(Pawn).Location.Z;
	}

	if(isLerping == true )
	{
		if ( offsetDistZ > 0.2f  )
		{
		SS_Pawn(Pawn).SetLocation(VLerp(SS_Pawn(Pawn).Location,Destination,0.3f));
		}
		else if ( offsetDistZ <= 0.2f )
		{
			isLerping = false;
			climbingDown = false;
			climbingUp = false;
			SS_Pawn(Pawn).SetLocation ( Destination);
		}
	}
}




/*/** Saves the game. Bind this function to a key (like F5 or F6 or something like that) in DefaultInput.ini */
exec function SaveGame() 
{
    /** The string that will hold the absolute path of save location */
    local string SaveLoc;
    
    /** Since we extended the SaveGameBase from Object we must use "new" to create a new one */
    SGB = new class'SaveGameBase';
    
    /** Assign the players position to Loc variable inside SaveGameBase (SGB) */
    SGB.Loc = SS_Pawn(self.Pawn).Location;
    
    /** Calls the DLLFunction which returns MyDocuments\FolderName\SaveFileName.SaveFileExtension */
    SaveLoc = SGB.SaveGameToMyDocuments(FolderName, SaveFileName, SaveFileExtension);


    
    /** Finally call the Engine Function to save all the SGB variables to the specified location */
    class'Engine'.static.BasicSaveObject(SGB, SaveLoc, true, SGB.SAVE_VERSION);
    
    /** [TESTING ONLY] */
    WorldInfo.Game.Broadcast(self, "Game Saved.");
    WorldInfo.Game.Broadcast(self, SaveLoc);
    WorldInfo.Game.Broadcast(self, "Player Position: "$SGB.Loc);
    
}
*/

/*
/** Loads the game. Bind this function to a key (like F9) in DefaultInput.ini */
exec function LoadGame(int LoadVersion)
{
    /** Holds the path to load the save game */
    local string LoadLoc;
    SGB = new class'SaveGameBase';
    
    /** Calls the DLLFunction which returns MyDocuments\FolderName\SaveFileName_LoadVersion.SaveFileExtension */
    LoadLoc = SGB.LoadGameFromMyDocuments(FolderName, SaveFileName, SaveFileExtension, string(LoadVersion));
    
    /** If everything goes well and SGB.SAVE_VERSION is correct then load the file */
    if (class'Engine'.static.BasicLoadObject(SGB, LoadLoc, true, SGB.SAVE_VERSION))
    {
        /** Change the players position to whatever is defined in SGB.Loc */
        SS_Pawn(self.Pawn).SetLocation(SGB.Loc);
    }
}

*/

//---------------------------------------------------------------------------------------------------------------\\

DefaultProperties
{
	/* DEFAULT PROPERTIES TIE IN CUSTOM SCIRPT CLASSES WE WANT TO OVER RIDE */
	isLerping = false;
	InputClass=class'SS_Input'

	climbingUP = false;
	climbingDown = false;

		
}
