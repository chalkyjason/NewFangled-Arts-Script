// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky
// Purpose: Create asteroids for the space levels
//---------------------------------------------------------------------------------------------------------------\\

class SS_Asteroid extends KActorspawnable
	placeable
	ClassGroup(Physics)
    showcategories(Navigation);;

// Variables
var SoundCue soundSample;
var float AsteroidDistance;
var bool bDoGravity;
var vector GravityDirection, NormGravity;
var float Mass;
var float tickUpdate;



simulated event PostBeginPlay()
{

    Mass = StaticMeshComponent.BodyInstance.GetBodyMass();
    NormGravity = vect(0,0,100);
    GravityDirection = vect(500,0,0);
   // NormGravity.z = GetNormGravityZ();
     
    enable('Tick');
     
    bDoGravity = true;
 super.PostBeginPlay();

}
//function not needed
function float GetNormGravityZ()
{
    local float GNGZ;
 
    GNGZ = Mass * 512;
 
    return GNGZ;
}
// Functions
function Tick ( float DeltaTime )
{
//local Vector Direction;

	TouchCheck ();
 
    super.Tick(DeltaTime);
	StaticMeshComponent.AddImpulse((NormGravity+GravityDirection) * DeltaTime);
    if (bDoGravity)
    {
        if(tickUpdate <= 0) 
        {
				//Direction = vect(0,0,0) * 1;
               // GravityDirection = Direction;
            
             
            tickUpdate = default.tickUpdate;
            //`Log("Gravity update = " @ exaPC.gravity);
        }
        else
            tickUpdate -= DeltaTime;
		
         
        DoGravity(DeltaTime); //update gravity
    }
     

	
	// Calls the super of this function
	super.Tick (DeltaTime);

	
}

function DoGravity(float DeltaTime)
{
	//if(tickUpdate >= 5.0f)
	//{
		//Spawn(SS_Asteroid,,,rGame.asteroidLocation);
    StaticMeshComponent.AddImpulse((NormGravity+GravityDirection) * DeltaTime);
	`log("DoGravity");
	//}
	//else
		//StaticMeshComponent.AddImpulse((NormGravity+GravityDirection/2) * DeltaTime);

}

function TouchCheck ()
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
			AsteroidDistance = VSize( Pawn(actorObj).Location - Location );
			// Checks to see if the collection is close enough
			if ( AsteroidDistance <= 45.0f )
			{
				
			   // actorObj.Acceleration.X = 200;
			  
				if(rGame.TotalStamina > 0)
				{
				//rGame.TotalStamina= rGame.TotalStamina - 2;
				}
				//self.Destroy();
				//WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.StaminaCollectibleEmitter, Location, Rotation );
				//PlaySound(soundSample);
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
 event Bump(Actor Other, PrimitiveComponent OtherComp,  vector HitNormal)
{
	local SS_Gametype rGame;
	local WorldInfo rWorldInfo;
	

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();

	if(rWorldInfo != none )
	{
		rGame = SS_GameType(rWorldInfo.Game);  
	
	}
	if ( SS_Pawn(Other) != none )
	{

		//Change the direction the player jumps off the rope usinf PlayerInput.aStrafe
				if(rGame.OurView > 1.0f)
				{
					
					Velocity = vect(0,0,0);
					
					SS_Pawn(Other).AddVelocity(vect(500,0,525),SS_Pawn(Other).Location,none);
					`log("Adding");
				}

				if(rGame.OurView  < -1.0f)
				{
					Velocity = vect(0,0,0);
					
					SS_Pawn(Other).AddVelocity(vect(-500,0,525),SS_Pawn(Other).Location,none);
					`log("Adding");
				}
	
	
				if(rGame.TotalStamina > 0 && rGame.TotalStamina - 2 > 0)
				{
				rGame.TotalStamina= rGame.TotalStamina - 0.5;
				}
			
		//self.Destroy();
		//WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.AsteroidEmitter, Location, Rotation );
		//PlaySound(soundSample);
	}
}
//---------------------------------------------------------------------------------------------------------------\\


DefaultProperties
{

	Begin Object Name=StaticMeshComponent0
       StaticMesh=StaticMesh'SS_Assets_Jason.Mesh.SS_Rock_01'
		WireframeColor=(R=0,G=255,B=128,A=255)
		BlockRigidBody=true
		bNotifyRigidBodyCollision=true
		RBChannel=RBCC_GameplayPhysics
		RBCollideWithChannels=(Default=TRUE,BlockingVolume=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE)
		bBlockFootPlacement=false
	End Object
	Components.Add(StaticMeshComponent0)

	bDamageAppliesImpulse=false
	Physics=PHYS_RigidBody
	bStatic=false
	bCollideWorld=false
	bBlockActors=true

	bNoDelete=false
	bSkipActorPropertyReplication=false

	bCollideActors=true
	bNoEncroachCheck=false
	bBlocksNavigation=false
	bPawnCanBaseOn=false
	bWakeOnLevelStart = false;

	StayUprightTorqueFactor=1000.0
	StayUprightMaxTorque=1500.0

	//MaxPhysicsVelocity=0

	 bDoGravity = true;
    Mass = 0;
     
    tickUpdate = 1.0f //in seconds
     
    //KActor properties
    MaxPhysicsVelocity=500.0

	ReplicatedDrawScale3D=(X=1000.0,Y=1000.0,Z=1000.0) // set so that default scale of (1,1,1) doesn't replicate anything

}