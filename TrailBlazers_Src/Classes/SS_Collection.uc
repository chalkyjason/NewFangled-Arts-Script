// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Timothy Janssen, Brad Fairley, Andy Montgomery, Chris Augilar, Jesse Mangano
// Purpose: Initializing the Stamina Collectible for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Collection extends KActor
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
			if ( collectionDistance <= 45.0f )
			{
				if(rGame.TotalStamina < rGame.MaxStamina && rGame.TotalStamina + rGame.MaxStamina/4 < rGame.MaxStamina)
				{
					//Add stamina if it is not reached its max
					rGame.TotalStamina = rGame.TotalStamina + rGame.MaxStamina/4;;
				}
				rGame.spawnLocation.AddItem (self.Location);
				rGame.isInWorld.AddItem (false);
				rGame.currentSeconds.AddItem (0);
				self.Destroy();
				WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.StaminaCollectibleEmitter, Location, Rotation );
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
		//Check to see if we have reach maxstamina
		if(rGame.TotalStamina < rGame.MaxStamina  && rGame.TotalStamina + rGame.MaxStamina/4 < rGame.MaxStamina)
		{
		//Add stamina if it is not reached its max
		rGame.TotalStamina = rGame.TotalStamina + rGame.MaxStamina/4;
		}
		else
			rGame.TotalStamina =   rGame.MaxStamina;
	}
	if ( Pawn(Other) != none )
	{
		rGame.spawnLocation.AddItem (self.Location);
		rGame.isInWorld.AddItem (false);
		rGame.currentSeconds.AddItem (0);
		self.Destroy();
		WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.StaminaCollectibleEmitter, Location, Rotation );
		PlaySound(soundSample);
	}
}
//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
	TickGroup=TG_PostAsyncWork

	SupportedEvents.Add(class'SeqEvent_RigidBodyCollision')

	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'SS_Assets_Jason.StaminaMug'
		Materials(0)=Material'SS_Assets_Jason.Materials.StaminaMugMat'
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
	DrawScale = 0.85
	DrawScale3D = (X=1, Y=1, Z=1)
	
	soundSample = SoundCue'SS_Assets.Music.StaminaPickupSound_Cue' 

	bDisableClientSidePawnInteractions=TRUE
}
