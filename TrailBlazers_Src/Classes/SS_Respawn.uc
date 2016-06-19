// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Initializing the Respawn Location for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Respawn extends KActor
	placeable;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var float PawnsDistance;
//---------------------------------------------------------------------------------------------------------------\\
// Events
simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
}
//---------------------------------------------------------------------------------------------------------------\\
// Functions
function Tick ( float DeltaTime )
{
	// Calls the super of this function
	super.Tick (DeltaTime);
}
////////////////////\\\\\\\\\\\\\\\\\\\\
event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;
	
	

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);
		if(rGame != none)
		{
			rGame.actorObj = GetALocalPlayerController().Pawn;
			
			rGame.playersLocation = SS_Pawn(rGame.actorObj).Location;

		/*if(rGame.OurView  < -1.0f)
		{
			rGame.respawnOffset = vect(0,0,0);
			`log(rGame.respawnOffset);
		}

		if(rGame.OurView > 1.0f)
		{
			rGame.respawnOffset = vect(0,0,0);
			`log(rGame.respawnOffset);
		}
		*/
//			savePCVariables();
			self.Destroy();
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/*
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

			// Save the variables
		//	gameState.highScore = rGame.highScore; //Set the gameState’s highScore to the PC’s highScore

			gameState.currentMapName = rWorld.GetMapName(false);

			gameState.MaxStamina = rGame.MaxStamina;

			// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "GameState.bin", true, 0);
		}
	}
}
*/
//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
	TickGroup=TG_PostAsyncWork

	SupportedEvents.Add(class'SeqEvent_RigidBodyCollision')

	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'phystest_resources.RemadePhysBarrel'
		WireframeColor=(R=0,G=255,B=128,A=255)
		BlockRigidBody=false
		RBChannel=RBCC_GameplayPhysics
		RBCollideWithChannels=(Pawn=TRUE,BlockingVolume=false,GameplayPhysics=false,EffectPhysics=false)
		bBlockFootPlacement=false
	End Object

	bDamageAppliesImpulse=false
	Physics=PHYS_RigidBody
	bStatic=false
	bCollideWorld=false
	bBlockActors=false

	bNoDelete=false
	bSkipActorPropertyReplication=false

	bCollideActors=true
	bNoEncroachCheck=false
	bBlocksNavigation=false
	bPawnCanBaseOn=false

	StayUprightTorqueFactor=1000.0
	StayUprightMaxTorque=1500.0

	MaxPhysicsVelocity=0

	ReplicatedDrawScale3D=(X=1000.0,Y=1000.0,Z=1000.0) // set so that default scale of (1,1,1) doesn't replicate anything
	DrawScale = 1.0
	DrawScale3D = (X=1, Y=1, Z=1)

	bDisableClientSidePawnInteractions=TRUE
}
