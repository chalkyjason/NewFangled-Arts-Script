// Author:  Team TrailBlazers
// Date:    09/2014
// Credit:  Jason Chalky
// Purpose: Initializing the 10 second collectible for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_TimerCollection10 extends KActor
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

				// Check if timer seconds are less then or equal to 54
				if(rGame.CountDownTMR.Sec <= 54)
				{
					// Add 5 seconds
					rGame.CountDownTMR.Sec += 5;
				}
				//Else if they do equal greater than 54 then do the following else if statements
				else if(rGame.CountDownTMR.Sec == 55)
				{
					// Set seconds to 0 because they looped to minutes
					rGame.CountDownTMR.Sec = 0;

					// Add one minute
					rGame.CountDownTMR.Min++;
				}
				else if(rGame.CountDownTMR.Sec == 56)
				{
					rGame.CountDownTMR.Sec = 1;
					rGame.CountDownTMR.Min++;
				}
				else if(rGame.CountDownTMR.Sec == 57)
				{
					rGame.CountDownTMR.Sec = 2;
					rGame.CountDownTMR.Min++;
				}
				else if(rGame.CountDownTMR.Sec == 58)
				{
					rGame.CountDownTMR.Sec = 3;
					rGame.CountDownTMR.Min++;
				}
				else if(rGame.CountDownTMR.Sec == 59)
				{
					rGame.CountDownTMR.Sec = 4;
					rGame.CountDownTMR.Min++;
				}
				self.Destroy();
				WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.timeCollectible10Emitter, Location, Rotation );
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
		
		// Check if timer seconds are less then or equal to 54
		if(rGame.CountDownTMR.Sec <= 54)
		{
			// Add 5 seconds
			rGame.CountDownTMR.Sec += 10;
		}
		//Else if they do equal greater than 54 then do the following else if statements
		else if(rGame.CountDownTMR.Sec == 50)
		{
			// Set seconds to 0 because they looped to minutes
			rGame.CountDownTMR.Sec = 0;

			// Add one minute
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 51)
		{
			rGame.CountDownTMR.Sec = 1;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 52)
		{
			rGame.CountDownTMR.Sec = 2;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 53)
		{
			rGame.CountDownTMR.Sec = 3;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 54)
		{
			rGame.CountDownTMR.Sec = 4;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 55)
		{
			rGame.CountDownTMR.Sec = 5;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 56)
		{
			rGame.CountDownTMR.Sec = 6;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 57)
		{
			rGame.CountDownTMR.Sec = 7;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 58)
		{
			rGame.CountDownTMR.Sec = 8;
			rGame.CountDownTMR.Min++;
		}
		else if(rGame.CountDownTMR.Sec == 59)
		{
			rGame.CountDownTMR.Sec = 9;
			rGame.CountDownTMR.Min++;
		}
	}
	if ( Pawn(Other) != none )
	{
		self.Destroy();
		WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.timeCollectible10Emitter, Location, Rotation );
		PlaySound(soundSample);
	}
}
//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
	TickGroup=TG_PostAsyncWork

	SupportedEvents.Add(class'SeqEvent_RigidBodyCollision')

	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'SS_Assets.StaticMesh.TimeSphere'
		Materials(0)=Material'Pickups.Deployables.Materials.M_Deployables_EMP_Mine_LightningMesh'
		WireframeColor=(R=0,G=255,B=128,A=255)
		BlockRigidBody=false
		RBChannel=RBCC_GameplayPhysics
		RBCollideWithChannels=(Pawn=TRUE,BlockingVolume=false,GameplayPhysics=false,EffectPhysics=false)
		bBlockFootPlacement=false
	End Object

	bDamageAppliesImpulse=false
	bNetInitialRotation=true
	Physics=PHYS_RigidBody
	bStatic=false
	bCollideWorld=false
	bProjTarget=true
	bBlockActors=false //Set to false so that player can collect them instead of just run into them
	bWorldGeometry=false

	bNoDelete=false
	bAlwaysRelevant=true
	bSkipActorPropertyReplication=false
	bUpdateSimulatedPosition=true
	bReplicateMovement=true
	RemoteRole=ROLE_SimulatedProxy

	bCollideActors=true
	bNoEncroachCheck=false
	bBlocksTeleport=true
	bBlocksNavigation=false
	bPawnCanBaseOn=false
	bSafeBaseIfAsleep=TRUE
	bNeedsRBStateReplication=true

	StayUprightTorqueFactor=1000.0
	StayUprightMaxTorque=1500.0

	MaxPhysicsVelocity=0

	ReplicatedDrawScale3D=(X=1000.0,Y=1000.0,Z=1000.0) // set so that default scale of (1,1,1) doesn't replicate anything

	DrawScale = 0.21 // Sets the mesh scale 
	
	soundSample = SoundCue'SS_Assets.Music.TimePickupSound_Cue'

	bDisableClientSidePawnInteractions=TRUE
}