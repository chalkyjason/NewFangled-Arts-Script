class SS_BossPawn extends UDKPawn
    placeable;

var float playersDistance;
var int TimeRemaining;

// Socket to use for attaching weapons
var(Pawn) const Name WeaponSocketName;

// Dynamic light environment component to help speed up lighting calculations for the pawn
var(Pawn) const DynamicLightEnvironmentComponent LightEnvironment;

 
function AddDefaultInventory()
{

	//InvManager.DiscardInventory();
	
	//InvManager.CreateInventory(class'TrailBlazers_Src.SS_Weapon');

   
    //For those in the back who don't follow, SandboxPaintballGun is a custom weapon
    //I've made in an earlier article, don't look for it in your UDK build.
}

simulated event Tick( FLOAT DeltaTime )
{
	closeToPlayer();

	super.Tick(DeltaTime);
}


 
simulated event PostBeginPlay()
{
	
	SetTimer(1.0f,true,'convertTime');
	

	//Does not work when done with the ut stuff, but works for add custom inventory. 
	//InvManager = Spawn( class'TrailBlazers_Src.SS_InventoryManager');
	
	

	//Override in my scripts to get it it to work.
	AddDefaultInventory();//GameInfo calls it only for players, so we have to do it ourselves for AI.
    super.PostBeginPlay();

    
}

function closeToPlayer ()
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
			playersDistance = VSize( Pawn(actorObj).Location - Location );
			

			// Checks to see if the collection is close enough
			if ( playersDistance >= 1200.0f )
			{
				AirSpeed = 01000.00;
			
				
			}

			if ( playersDistance >= 1000.0f && playersDistance <= 1200.0f )
			{
				AirSpeed = 00800.00;
		
			}

			if ( playersDistance >= 700.0f && playersDistance <= 1000.0f )
			{
				AirSpeed = 00500.00;
				
			}

			if ( playersDistance >= 500.0f && playersDistance <=700.0f)

			{
				AirSpeed =  00400.00;
				
				
			
				
			}

				
				/*code works, just commenting out to set things up
				 * //Remove time if too close
				rGame.CountDownTMR.Sec= rGame.CountDownTMR.Sec - 1.0;

				SS_Gametype(rWorldInfo.Game).CheckTimer();
			
				
				*/
				
			
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
				TimeRemaining = rGame.CountDownTMR.Min * 60;
				TimeRemaining = TimeRemaining + rGame.CountDownTMR.Sec;
			}
			if(rGame.CountDownTMR.Min < 1)
			{
					TimeRemaining = rGame.CountDownTMR.Sec;
			}
		}
	}
}

//Removed because it was giving error for ut 4/19/2015
/*simulated function Rotator GetAdjustedAimFor(Weapon W, vector StartFireLoc)
{
	local Vector SocketLocation;
	local Rotator SocketRotation;
	local SS_Weapon SS_Weapon;
	local SkeletalMeshComponent WeaponSkeletalMeshComponent;

	SS_Weapon = SS_Weapon(Weapon);
	if (SS_Weapon != None)
	{
		WeaponSkeletalMeshComponent = SkeletalMeshComponent(SS_Weapon.Mesh);
		if (WeaponSkeletalMeshComponent != None && WeaponSkeletalMeshComponent.GetSocketByName(SS_Weapon.MuzzleSocketName) != None)
		{			
			WeaponSkeletalMeshComponent.GetSocketWorldLocationAndRotation(SS_Weapon.MuzzleSocketName, SocketLocation, SocketRotation);
			return SocketRotation;
		}
	}

	return Rotation;
}


/**
 * Return world location to start a weapon fire trace from.
 *
 * @param	CurrentWeapon		Weapon about to fire
 * @return						World location where to start weapon fire traces from
 */
simulated event Vector GetWeaponStartTraceLocation(optional Weapon CurrentWeapon)
{
	local Vector SocketLocation;
	local Rotator SocketRotation;
	local SS_Weapon SS_Weapon;
	local SkeletalMeshComponent WeaponSkeletalMeshComponent;

	SS_Weapon = SS_Weapon(Weapon);
	if (SS_Weapon != None)
	{
		WeaponSkeletalMeshComponent = SkeletalMeshComponent(SS_Weapon.Mesh);
		if (WeaponSkeletalMeshComponent != None && WeaponSkeletalMeshComponent.GetSocketByName(SS_Weapon.MuzzleSocketName) != None)
		{
			WeaponSkeletalMeshComponent.GetSocketWorldLocationAndRotation(SS_Weapon.MuzzleSocketName, SocketLocation, SocketRotation);
			return SocketLocation;
		}
	}

	return Super.GetWeaponStartTraceLocation(CurrentWeapon);
}
*/
 
DefaultProperties
{
    Begin Object Name=CollisionCylinder
        CollisionHeight=+44.000000
    End Object
 
    Begin Object Class=SkeletalMeshComponent Name=SS_BossPawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
       AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		//AnimSets(1)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
		
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
 
    Mesh=SS_BossPawnSkeletalMesh
 
    Components.Add(SS_BossPawnSkeletalMesh)


    ControllerClass=class'TrailBlazers_Src.SS_AIController'
    InventoryManagerClass=class'TrailBlazers_Src.SS_InventoryManager'
	//InventoryManagerClass = class 'InventoryManager'

	
	
	
	
    bJumpCapable=true
    bCanJump=true


	AirSpeed=+00400.000000
	AirControl=+0.05
	Physics = PHYS_Flying;


	//Mass=+00500.000000
 
    GroundSpeed=300.0 //Making the bot slower than the player
}