class SS_Projectile extends UTProj_LinkPlasma;

var float HitDistance;

//---------------------------------------------------------------------------------------------------------------\\
// Functions
function Tick ( float DeltaTime )
{
	hitCheck ();
	// Calls the super of this function
	super.Tick (DeltaTime);
}
////////////////////\\\\\\\\\\\\\\\\\\\\

function hitCheck ()
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
			HitDistance = VSize( Pawn(actorObj).Location - Location );
			// Checks to see if the collection is close enough
			if ( HitDistance <= 45.0f )
			{
			
				rGame.SS_Health = rGame.SS_Health - 100;
				`log("Getting Hit");
				
				//WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.StaminaCollectibleEmitter, Location, Rotation );
				
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
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

	

	if ( Other != Instigator )
	{
		if ( !Other.IsA('Projectile') || Other.bProjTarget )
		{
			MomentumTransfer = (UTPawn(Other) != None) ? 0.0 : 1.0;
			Other.TakeDamage(Damage, InstigatorController, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
			Explode(HitLocation, HitNormal);

				if ( rGame != none )
		{
			// Sets the distance for the pawn from the collection
			HitDistance = VSize( Pawn(actorObj).Location - Location );
			// Checks to see if the collection is close enough
			if ( HitDistance<= 45.0f )
			{

				
				
				MomentumTransfer = (UTPawn(Other) != None) ? 0.0 : 1.0;
			Other.TakeDamage(Damage, InstigatorController, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
			Explode(HitLocation, HitNormal);
				
				
			//	WorldInfo.MyEmitterPool.SpawnEmitter ( rGame.StaminaCollectibleEmitter, Location, Rotation );
				
			}
		}
		}
	}
	}
}

simulated event HitWall(vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
	MomentumTransfer = 1.0;

	Super.HitWall(HitNormal, Wall, WallComp);
}

simulated function SpawnFlightEffects()
{
	Super.SpawnFlightEffects();
	if (ProjEffects != None)
	{
		ProjEffects.SetVectorParameter('LinkProjectileColor', ColorLevel);
	}
}


simulated function SetExplosionEffectParameters(ParticleSystemComponent ProjExplosion)
{
	Super.SetExplosionEffectParameters(ProjExplosion);
	ProjExplosion.SetVectorParameter('LinkImpactColor', ExplosionColor);
}

DefaultProperties
{
ProjFlightTemplate=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Projectile'
	ProjExplosionTemplate=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Impact'
	MaxEffectDistance=7000.0

	Speed=1400
	MaxSpeed=5000
	AccelRate=3000.0

	Damage=100
	DamageRadius=0
	MomentumTransfer=0
	CheckRadius=100.0

	MyDamageType=class'UTDmgType_LinkPlasma'
	LifeSpan=3.0
	NetCullDistanceSquared=+144000000.0

	bCollideWorld=true
	DrawScale=2.5

	ExplosionSound=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_ImpactCue'
	ColorLevel=(X=1,Y=1.3,Z=1)
	ExplosionColor=(X=1,Y=1,Z=1);

}
