class SS_BossProjectile extends UTProj_Rocket;

defaultproperties
{
    MyDamageType=class'UTDmgType_SeekingRocket'
    LifeSpan=8.000000
    bRotationFollowsVelocity=true
	CheckRadius=0.0
	BaseTrackingStrength=1.0
	HomingTrackingStrength=16.0
	Damage = 0.0
	Speed = 200.0
	MaxSpeed = 400.0
}


/*class SS_BossProjectile extends UDKProjectile;




simulated function PostBeginPlay()
{

	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	//local Actor actorObj;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);
		// Typecast for the access to the Pawn Location
	//	actorObj = GetALocalPlayerController().Pawn;

		if ( rGame != none )
		{
	// force ambient sound if not vehicle game mode
//	bImportantAmbientSound = !WorldInfo.bDropDetail;
	//SeekTarget = actorObj;
	InitialDir = rGame.playersLocation;
	SetTimer(0.1,true,'Findplayer');
	
	Super.PostBeginPlay();

		}
	}
}
	
function Findplayer()
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	local Actor actorObj;
	
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);
		

		if ( rGame != none )
		{
			actorObj = GetALocalPlayerController().Pawn;
			SeekTarget = actorObj;

	//Velocity.X = 25;
	Velocity.Y = rGame.playersLocation.Y;
		}

	}

}

	

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	//local Actor actorObj;
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);
		// Typecast for the access to the Pawn Location
		//actorObj = GetALocalPlayerController().Pawn;

		if ( rGame != none )
		{
	
			if (DamageRadius > 0.0)
	{
		Explode( HitLocation, HitNormal );
		rGame.CountDownTMR.Sec = rGame.CountDownTMR.Sec - 5;

	}
	else
	{
		Other.TakeDamage(Damage,InstigatorController,HitLocation,MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		Shutdown();
	}
}
	}
}



DefaultProperties
{

	//Need to make custom damage type possibly for the time. 
	MyDamageType=class'UTDmgType_SeekingRocket'
    LifeSpan=8.000000
    bRotationFollowsVelocity=true
	CheckRadius=0.0
	BaseTrackingStrength=1.0
	HomingTrackingStrength=16.0
//Items commented out because I believe they use UT,not UDK. Woulnd need to copy code for UT to get
// the vars to work with this code
	
	ProjFlightTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketTrail'
	ProjExplosionTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketExplosion'
	ExplosionDecal=MaterialInstanceTimeVarying'WP_RocketLauncher.Decals.MITV_WP_RocketLauncher_Impact_Decal01'
	DecalWidth=128.0
	DecalHeight=128.0
	speed=25.0
	MaxSpeed=100.0
	Damage=0.0
	DamageRadius=220.0
	MomentumTransfer=85000
	AmbientSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Travel_Cue'
	ExplosionSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Impact_Cue'
	RotationRate=(Roll=50000)
	bCollideWorld=true
	bCheckProjectileLight=true
	
	ProjectileLightClass=class'UTGame.UTRocketLight'
	ExplosionLightClass=class'UTGame.UTRocketExplosionLight'

	bWaitForEffects=true
	bAttachExplosionToVehicles=false
}
*/