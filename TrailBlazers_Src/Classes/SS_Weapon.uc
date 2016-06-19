/**
 * Copyright 1998-2014 Epic Games, Inc. All Rights Reserved.
 */
class SS_Weapon extends UTWeap_RocketLauncher;

defaultproperties
{
	WeaponColor=(R=255,G=0,B=0,A=255)
	FireInterval(0)=+1.0
	FireInterval(1)=+1.05
	PlayerViewOffset=(X=0.0,Y=0.0,Z=0.0)

	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_1P'
		PhysicsAsset=None
		AnimTreeTemplate=AnimTree'WP_RocketLauncher.Anims.AT_WP_RocketLauncher_1P_Base'
		AnimSets(0)=AnimSet'WP_RocketLauncher.Anims.K_WP_RocketLauncher_1P_Base'
		Translation=(X=0,Y=0,Z=0)
		Rotation=(Yaw=0)
		scale=10.0
		FOV=60.0
		bUpdateSkelWhenNotRendered=true
	End Object
	SkeletonFirstPersonMesh = FirstPersonMesh;
	AttachmentClass=class'UTGameContent.UTAttachment_RocketLauncher'

	// Pickup staticmesh
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_3P'
	End Object

	WeaponLoadedSnd=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Load_Cue'
	WeaponFireSnd[0]=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Fire_Cue'
	WeaponFireSnd[1]=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Fire_Cue'
	WeaponEquipSnd=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Raise_Cue'
	AltFireModeChangeSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_AltModeChange_Cue'
	RocketLoadedSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_RocketLoaded_Cue'
	GrenadeFireSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_GrenadeFire_Cue'

	AltFireSndQue(0)=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_AltFireQueue1_Cue'
	AltFireSndQue(1)=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_AltFireQueue2_Cue'
	AltFireSndQue(2)=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_AltFireQueue3_Cue'

	LockAcquiredSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_SeekLock_Cue'
	LockLostSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_SeekLost_Cue'

	//WeaponProjectiles(0)=class'UTProj_Rocket'
	//WeaponProjectiles(1)=class'UTProj_Rocket'
	//LoadedRocketClass=class'UTProj_LoadedRocket'

	WeaponProjectiles(0)=class'TrailBlazers_Src.SS_BossProjectile'
	WeaponProjectiles(1)=class'TrailBlazers_Src.SS_BossProjectile'
	LoadedRocketClass=class'TrailBlazers_Src.SS_BossProjectile'

	//GrenadeClass=class'UTProj_Grenade'
	GrenadeClass=class'TrailBlazers_Src.SS_BossProjectile'

	FireOffset=(X=20,Y=12,Z=-5)

	MaxDesireability=0.78
	AIRating=+0.78
	CurrentRating=+0.78
	bInstantHit=false
	bSplashJump=true
	bRecommendSplashDamage=true
	bSniping=false
	ShouldFireOnRelease(0)=0
	ShouldFireOnRelease(1)=1
	InventoryGroup=8
	GroupWeight=0.5


	PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Rocket_Cue'

	AmmoCount=9
	LockerAmmoCount=18
	MaxAmmoCount=30

	SeekingRocketClass=class'UTProj_SeekingRocket'

	AltFireQueueTimes(0)=0.40
	AltFireQueueTimes(1)=0.96
	AltFireQueueTimes(2)=0.96
	AltFireLaunchTimes(0)= 0.51
	AltFireLaunchTimes(1)= 0.51
	AltFireLaunchTimes(2)= 0.51
	AltFireEndTimes(0)=0.44
	AltFireEndTimes(1)=0.44
	AltFireEndTimes(2)=0.44

	MaxLoadCount=3
	SpreadDist=1000
	FiringStatesArray(1)=WeaponLoadAmmo
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile
	WaitToFirePct=0.85
	GracePeriod=0.96

	MuzzleFlashSocket=MuzzleFlashSocketA
	MuzzleFlashSocketList(0)=MuzzleFlashSocketA
	MuzzleFlashSocketList(1)=MuzzleFlashSocketC
	MuzzleFlashSocketList(2)=MuzzleFlashSocketB

	MuzzleFlashPSCTemplate=WP_RocketLauncher.Effects.P_WP_RockerLauncher_Muzzle_Flash
	MuzzleFlashDuration=0.33
	MuzzleFlashLightClass=class'UTGame.UTRocketMuzzleFlashLight'


	ConsoleLockAim=0.992
	LockRange=8000
	LockAim=0.997
	LockChecktime=0.1
	LockAcquireTime=1.1
	LockTolerance=0.2

	IconX=460
	IconY=34
	IconWidth=51
	IconHeight=38

	EquipTime=+0.6

	GrenadeSpreadDist=300

	JumpDamping=0.75

	LockerRotation=(pitch=0,yaw=0,roll=-16384)
	IconCoordinates=(U=131,V=379,UL=129,VL=50)
	CrossHairCoordinates=(U=128,V=64,UL=64,VL=64)
	WeaponPutDownSnd=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Lower_Cue'

	LoadedIconCoords[0]=(U=0,V=384,UL=63,VL=63)
	LoadedIconCoords[1]=(U=63,V=384,UL=63,VL=63)
	LoadedIconCoords[2]=(U=126,V=384,UL=63,VL=63)

	LoadUpAnimList[0]=WeaponAltFireQueue1
	LoadUpAnimList[1]=WeaponAltFireQueue2
	LoadUpAnimList[2]=WeaponAltFireQueue3

	WeaponAltFireLaunch[0]=WeaponAltFireLaunch1
	WeaponAltFireLaunch[1]=WeaponAltFireLaunch2
	WeaponAltFireLaunch[2]=WeaponAltFireLaunch3

	WeaponAltFireLaunchEnd[0]=WeaponAltFireLaunch1End
	WeaponAltFireLaunchEnd[1]=WeaponAltFireLaunch2End
	WeaponAltFireLaunchEnd[2]=WeaponAltFireLaunch3End

	Begin Object Class=ForceFeedbackWaveform Name=ForceFeedbackWaveformShooting1
		Samples(0)=(LeftAmplitude=90,RightAmplitude=50,LeftFunction=WF_LinearDecreasing,RightFunction=WF_LinearDecreasing,Duration=0.200)
	End Object
	WeaponFireWaveForm=ForceFeedbackWaveformShooting1
}




/*
class SS_Weapon extends UDKWeapon;
//=============================================================================
// SPG_Weapon
//
// Simple weapon that can shoot projectiles.
//
// Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
//=============================================================================

// Name of the socket which represents the muzzle socket
var(Weapon) const Name MuzzleSocketName;
// Particle system representing the muzzle flash
var(Weapon) const ParticleSystemComponent MuzzleFlash;
// Projectile classes that this weapon fires. DisplayName lets the editor show this as WeaponProjectiles
var(Weapon) const array< class<Projectile> > Projectiles<DisplayName=Weapon Projectiles>;
// Sounds to play back when the weapon is fired
var(Weapon) const array<SoundCue> WeaponFireSounds;

/**
 * Constructor called when the weapon is spawned into the world
 *
 * @network					Server and client
 */
simulated event PostBeginPlay()
{

	local SkeletalMeshComponent SkeletalMeshComponent;
	setuppawn();
	Super.PostBeginPlay();

	if (MuzzleFlash != None)
	{
		SkeletalMeshComponent = SkeletalMeshComponent(Mesh);
		if (SkeletalMeshComponent != None && SkeletalMeshComponent.GetSocketByName(MuzzleSocketName) != None)
		{
			SkeletalMeshComponent.AttachComponentToSocket(MuzzleFlash, MuzzleSocketName);
		}
	}
}


function setuppawn()
{
local SS_BossPawn P;
	Instigator = P;
	SetOwner(P);

}



/**
 * Returns the projectile class based on the current fire mode
 *
 * @return			Returns the class of the projectile indexed within the Projectiles array
 * @network			Server
 */
function class<Projectile> GetProjectileClass()
{
	return (CurrentFireMode < Projectiles.length) ? Projectiles[CurrentFireMode] : None;
}




/**
 * Fires a projectile.
 * Spawns the projectile, but also increment the flash count for remote client effects.
 * Network: Local Player and Server
 */

simulated function Projectile ProjectileFire()
{
	local Vector SpawnLocation;
	local Rotator SpawnRotation;
	local class<Projectile> ProjectileClass;
	local Projectile SpawnedProjectile;

	// tell remote clients that we fired, to trigger effects
	IncrementFlashCount();

	// Only allow servers to spawn projectiles
	if (Role == ROLE_Authority)
	{
		// This is where we would spawn the projectile
		SpawnLocation = Instigator.GetWeaponStartTraceLocation();
		// This is the rotation we should spawn the projectile
		SpawnRotation = GetAdjustedAim(SpawnLocation);

		// Get the projectile class
		ProjectileClass = GetProjectileClass();
		if (ProjectileClass != None)
		{
			// Spawn the projectile setting the projectile's owner to myself
			SpawnedProjectile = Spawn(ProjectileClass, Self,, SpawnLocation, SpawnRotation);

			// Check if we've spawned the projectile, and that it isn't going to be deleted
			if (SpawnedProjectile != None && !SpawnedProjectile.bDeleteMe)
			{
				// Initialize the projectile
				SpawnedProjectile.Init(Vector(SpawnRotation));
			}
		}
		
		// Return it up the line
		return SpawnedProjectile;
	}

	return None;
}

//added after i got it to shot

simulated function TimeWeaponEquipping()
{
    AttachWeaponTo( Instigator.Mesh,'WeaponPoint' );
    super.TimeWeaponEquipping();
}


 
simulated function AttachWeaponTo( SkeletalMeshComponent MeshCpnt, optional Name SocketName )
{
    MeshCpnt.AttachComponentToSocket(Mesh,SocketName);
}


simulated event SetPosition(UDKPawn Holder)
{
    local SkeletalMeshComponent compo;
    local SkeletalMeshSocket socket;
    local Vector FinalLocation;
 
    compo = Holder.Mesh;
 
    if (compo != none)
    {
        socket = compo.GetSocketByName('WeaponPoint');
        if (socket != none)
        {
            FinalLocation = compo.GetBoneLocation(socket.BoneName);
        }
    } //And we probably should do something similar for the rotation <img src="http://www.moug-portfolio.info/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley"> 
 
    SetLocation(FinalLocation);
}


defaultproperties
{

	
	

	// Create the particle system component for the weapon's muzzle flash
	Begin Object Class=ParticleSystemComponent Name=MyParticleSystemComponent		
	End Object
	MuzzleFlash=MyParticleSystemComponent
	Components.Add(MyParticleSystemComponent);

	// Set the weapon firing states
	FiringStatesArray(0)="WeaponFiring"
	FiringStatesArray(1)="WeaponFiring"

	// Set the weapon to fire projectiles by default
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile
	//might need this to adjust where the shot comes from.
	//FireOffset=(X=12,Y=10,Z=-10)

	FireInterval(0) = 0.2
	FireInterval(1) = 2.0
	Spread(0) = 0.2
	Spread(1) = 0.1
    WeaponProjectiles(0) = Class'TrailBlazers_Src.SS_BossProjectile'
	WeaponProjectiles(1) = Class'TrailBlazers_Src.SS_BossProjectile'
	
}
		
*/