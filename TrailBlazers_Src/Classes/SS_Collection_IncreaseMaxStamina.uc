// Author:  Team TrailBlazers
// Date:    08/2014
// Credit:  Jason Chalky
// Purpose: Initializing the Max Stamina Collectible for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Collection_IncreaseMaxStamina extends Kactor
	placeable;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var SoundCue soundSample;
var float collectionDistance;
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
	collectCheck ();
	// Calls the super of this function
	super.Tick (DeltaTime);
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function collectCheck ()
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	local Actor actorObj;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);
		// Typecast for the access to the Pawn Location
		actorObj = GetALocalPlayerController().Pawn;

		if ( rGame != none )
		{
			// Sets the distance for the pawn from the collection
			collectionDistance = VSize( Pawn(actorObj).Location - Location );
			// Checks to see if the collection is close enough
			if ( collectionDistance <= 110.0f )
			{
			//Increase Max Stamina
			rGame.MaxStamina = rGame.MaxStamina + 2.0f;
			rGame.TotalStamina = rGame.TotalStamina + 2.0f;
			WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.MaxStaminaEmitter, Location, Rotation );
			self.Destroy();
			PlaySound(soundSample);
			}
		}
	}
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
		//Increase Max Stamina
		rGame.MaxStamina = rGame.MaxStamina + 2.0f;
		rGame.TotalStamina = rGame.TotalStamina + 2.0f;
//		savePCVariables();
	}
	if ( Pawn(Other) != none )
	{
		WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.MaxStaminaEmitter, Location, Rotation );
		self.Destroy();
		PlaySound(soundSample);
	}
}
//---------------------------------------------------------------------------------------------------------------\\


/*
// Functions
function savePCVariables()
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
		

			// Call the Engine BasicSaveObject function to save the gameState object
			// Version 0: Development
			class'Engine'.static.BasicSaveObject(gameState, "GameState.bin", true, 0);
		}
	}
}
*/
DefaultProperties
{
	TickGroup=TG_PostAsyncWork

	SupportedEvents.Add(class'SeqEvent_RigidBodyCollision')

	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'SS_Assets_Jason.MaxStamina'
		Materials(0)=Material'SS_Assets_Jason.Materials.StaminMat'
		WireframeColor=(R=0,G=255,B=128,A=255)
		BlockRigidBody=true
		RBChannel=RBCC_GameplayPhysics
		RBCollideWithChannels=(Pawn=TRUE,BlockingVolume=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE)
		bBlockFootPlacement=false
	End Object

	bDamageAppliesImpulse=false
	bNetInitialRotation=true
	Physics=PHYS_SoftBody
	bStatic=false
	bCollideWorld=false
	bProjTarget=true
	bBlockActors=false
	bWorldGeometry=false

	bNoDelete=false
	bAlwaysRelevant=true
	bSkipActorPropertyReplication=false
	bUpdateSimulatedPosition=true
	bReplicateMovement=true
	RemoteRole=ROLE_SimulatedProxy

	bCollideActors=true
	bNoEncroachCheck=true
	bBlocksTeleport=true
	bBlocksNavigation=true
	bPawnCanBaseOn=false
	bSafeBaseIfAsleep=TRUE
	bNeedsRBStateReplication=true
	

	StayUprightTorqueFactor=1000.0
	StayUprightMaxTorque=1500.0

	MaxPhysicsVelocity=0
	DrawScale = 0.50

	ReplicatedDrawScale3D=(X=1000.0,Y=1000.0,Z=1000.0) // set so that default scale of (1,1,1) doesn't replicate anything
	
	soundSample = SoundCue'SS_Assets.Music.MaxStaminaPickupSoundChippy_Cue'

	bDisableClientSidePawnInteractions=TRUE
}
