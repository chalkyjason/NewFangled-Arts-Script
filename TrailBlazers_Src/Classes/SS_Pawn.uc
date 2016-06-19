// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Timothy Janssen, Brad Fairley, Andy Montgomery, Chris Augilar, Jesse Mangano
// Purpose: Initializing the Pawn for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Pawn extends Pawn;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
// Dynamic light environment component to help speed up lighting calculations for the pawn
var(Pawn) const DynamicLightEnvironmentComponent LightEnvironment;
var SoundCue grabRopeSound;
var SoundCue staminaSound;
var ParticleSystemComponent LeftLegTrail;

var bool turnOnSound;

//---------------------------------------------------------------------------------------------------------------\\



// Events
simulated event Tick( FLOAT DeltaTime )
{
	SS_PlayerController(Controller).LerpCheck();

	super.Tick(DeltaTime);
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This function is over written to initialize our class members
 * */
simulated event PostBeginPlay()
{

	local SS_Gametype rGame;

	rGame = SS_Gametype(class'WorldInfo'.static.GetWorldInfo().Game);

	if (rGame != none)
	{
		rGame.BackTrail = WorldInfo. MyEmitterPool. SpawnEmitterMeshAttachment(ParticleSystem'RainbowRibbonForSkelMeshes.RainbowSwordRibbon', Mesh, 'b_Spine2', false);
		rGame.HeadTrail = WorldInfo. MyEmitterPool. SpawnEmitterMeshAttachment(ParticleSystem'RainbowRibbonForSkelMeshes.RainbowSwordRibbon', Mesh, 'b_head', false);
		rGame.BackTrail.SetStopSpawning(-1, true);
		rGame.HeadTrail.SetStopSpawning(-1, true);
	}

	SetTimer ( 0.1f, true, 'drawMaterial');

	SetTimer(0.01f,true,'destroyPawn');

//	loadPCVariables();
	//loadHighScore();
	
	// Super will call the specified parent version of this extended script
	super.PostBeginPlay();
	`Log("Custom Pawn up");

	// Gives the "Rainbow Fish" trail on his Left Knee
	LeftLegTrail = WorldInfo. MyEmitterPool. SpawnEmitterMeshAttachment(ParticleSystem'RainbowRibbonForSkelMeshes.RainbowSwordRibbon', Mesh, 'b_LeftLeg', false);

	Mesh.SetMaterial(0, Material'SS_Assets_Jason.Mat.Pawn_White');
	Mesh.SetMaterial(1, Material'SS_Assets_Jason.Mat.Pawn_White');
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This function is over written to shut down any other class members(resources) we added
 * */
simulated event Destroyed()
{
	// Super will call the specified parent version of this extended script
	Super.Destroyed();
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This function is over written to latch onto any rope we collide with
 * Taken from UDN Collision Technical Guide
 * */
event Touch ( Actor Other, PrimitiveComponent OtherComp, Vector HitLocation,Vector HitNormal )
{	
	local Actor rope; 
	local RB_BSJointActor proxy;
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
				
			// Look for ropes or collection in collision
			if(Other.IsA('SS_Rope') && rGame.TotalStamina > 0.0 && SS_PlayerController(Controller).RopeGrab == True 
				|| Other.IsA('SS_Collection') || Other.IsA('SS_Collection_IncreaseMaxStamina' ))
			{
				proxy = SS_Rope(Other).ThisJoint;
				if(proxy !=none)
				{
					rope = proxy.ConstraintActor2;
				 
					//rope impulse at attach adjust if needed			
					if(rGame.OurView > 1.0f && SS_PlayerController(Controller).isLerping == false )
					{
						SS_Rope(Other).StaticMeshComponent.AddImpulse(vect(200,0,0),Location );
					}

					if(rGame.OurView < -1.0f && SS_PlayerController(Controller).isLerping == false )
					{
						SS_Rope(Other).StaticMeshComponent.AddImpulse(vect(-200,0,0),Location);
					}
				
					rope.AttachComponent(Mesh);
					CheatGhost(); 
					SetPhysics (PHYS_Flying);
					SS_PlayerController(controller).LastRope = rope;
					SS_PlayerController(Controller).swingingJoint = proxy;
					SetTimer (0.1f, true, 'decreaseStamina' );
				}
			}
			else
			{
				// Clear swing rope for next grab - meaning store the value back to nothing
				SS_PlayerController(Controller).LastRope = none;
				SS_PlayerController(Controller).swingingJoint = none;
			}
		}
	}
	// Super will call the specified parent version of this extended script
	super.Touch(Other, OtherComp, HitLocation, HitNormal);
}
 //---------------------------------------------------------------------------------------------------------------\\
// Functions
/* 
 * This function is over written release from a rope if we are swinging
 * Taken from parent script
 * */
function bool DoJump( bool bUpdating )
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
			// Are we in "swinging" mode - This will cancel out
			if(SS_PlayerController(Controller).swingingJoint != none)
			{
				// Clear swing rope for next grab - meaning store the value back to nothing
				SS_PlayerController(Controller).swingingJoint = none;
		
				// Have this pawn attach his mesh back and force an update on components with ReattachComponent(mesh)'
				ReattachComponent (Mesh);
			
				// Resets Physics
				SetPhysics (PHYS_Walking);
				SetTimer ( 0.0f, false, 'decreaseStamina' );
				CheatWalk ();

				//Change the direction the player jumps off the rope usinf PlayerInput.aStrafe
				if(rGame.OurView > 1.0f && rGame.FallDown == false)
				{
					Velocity = vect(0,0,0);
					AddVelocity(vect(500,0,525),Location,none);
				}

				if(rGame.OurView  < -1.0f && rGame.FallDown == false)
				{
					Velocity = vect(0,0,0);
					AddVelocity(vect(-500,0,525),Location,none);
				}
				//if player last pressed s the fall down
				if(rGame.FallDown == true)
				{
					Velocity = vect(0,0,0);
					AddVelocity(vect(0,0,-200),Location,none);
				}
		
				// Force net relevancy for security purposes
				return bUpdating;
			}
			else
			{
				// Super will call the specified parent version of this extended script
				return super.DoJump(bUpdating);
			}
		}
	}
}

//function for when stamina is gone the player falls off rope instead of jumping in a direction
function bool FallOff( bool bUpdating )
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
			// Are we in "swinging" mode - This will cancel out
			if(SS_PlayerController(Controller).swingingJoint != none)
			{
				// Clear swing rope for next grab - meaning store the value back to nothing
				SS_PlayerController(Controller).swingingJoint = none;
		
				// Have this pawn attach his mesh back and force an update on components with ReattachComponent(mesh)'
				ReattachComponent (Mesh);
			
				// Resets Physics
				SetPhysics (PHYS_Walking);
				SetTimer ( 0.0f, false, 'decreaseStamina' );
				CheatWalk (); 

				
						//Change the direction the player jumps off the rope usinf PlayerInput.aStrafe
				if(rGame.OurView > 1.0f )
				{
					Velocity = vect(0,0,0);
					AddVelocity(vect(500,0,-200),Location,none);
				}

				if(rGame.OurView  < -1.0f )
				{
					Velocity = vect(0,0,0);
					AddVelocity(vect(-500,0,-200),Location,none);
				}
				// Force net relevancy for security purposes
				return bUpdating;
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
/* 
 * This function is over written to apply our own side scrolling camera
 * Taken from UDN Camera Technical Guide
 * */
simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
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
	// Taken from UDN Camera Technical Guide - For Side Scroller(s)

	out_CamLoc = Location;
	//This was removed to not limit the camera from zooming in for when 
	//using the warp
	/*if(rGame.TestCamera.Y > -1000)
	{
		rGame.TestCamera.Y = -1000;
	}
	*/
	out_CamLoc.Y -= rGame.TestCamera.Y;

    out_CamRot.Pitch = 0;
    out_CamRot.Yaw = -16384;
    out_CamRot.Roll = 0;

    return true;

		}
	}
}

////////////////////\\\\\\\\\\\\\\\\\\\\
function decreaseStamina ()
{
	// Local Variables used to gain access to player stamina
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
			rGame.TotalStamina -= 0.15f;

			if ( rGame.TotalStamina <= 00.f )
			{
				FallOff (true);
				PlaySound(grabRopeSound);
				SS_PlayerController(controller).LastRope = none; 
				SS_PlayerController(Controller).swingingJoint = none;
			}
		}
	}
}
////////////////////\\\\\\\\\\\\\\\\\\\\
function drawMaterial ()
{
	// Local Variables used to gain access to player stamina
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

		
			//play sound when stamina gets low
			if(rGame.TotalStamina < 3.0f  && turnOnSound == true)
			{
				PlaySound(staminaSound);
				turnOnSound = false;
			}

			if(rGame.TotalStamina > 6.0f)
			{

				turnOnSound = true;

			}

			// Used for changing the material of the Pawn
			if (rGame.TotalStamina < 3.0f)    //player mesh goes to a fast flicker from 1-4 stamina
			{
				Mesh.SetMaterial(0, Material'Test.Material.Flicker_Faster');
				Mesh.SetMaterial(1, Material'Test.Material.Flicker_Faster');
				
			}
			else if (rGame.TotalStamina < 6.0f)    //player mesh goes to a slow flicker from 5-7 stamina
			{
				Mesh.SetMaterial(0, Material'Test.Material.Flicker');
				Mesh.SetMaterial(1, Material'Test.Material.Flicker');
				
			}
			else if (rGame.TotalStamina <= 10.0f || rGame.TotalStamina >= 10.0f)   //player mesh stays normal from 8-10 stamina
			{
				Mesh.SetMaterial(0, Material'SS_Assets_Jason.Mat.Pawn_White');
				Mesh.SetMaterial(1, Material'SS_Assets_Jason.Mat.Pawn_White');
			}
		}
	}
}


/*
////////////////////\\\\\\\\\\\\\\\\\\\\
exec function loadPCVariables()
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
			gameState =  new class'DH_GameState';
 
			// Load the variables gamestate using BasicLoadObject
			// Version 0: Development

			if(class'Engine'.static.BasicLoadObject(gameState, "GameState.bin", true, 0)) //Load only if the file actually exists
			{
				//rGame.highScore = gameState.highScore; //Set the PC’s highScore to the value we loaded
				rGame.currentMapName = gameState.currentMapName; 
				rGame.MaxStamina = gameState.MaxStamina;
				rGame.TotalStamina = gameState.MaxStamina;
				
			}
			else
			{
				`Log("File not found while loading PC’s variables");
			}
		}
	}
}

////////////////////\\\\\\\\\\\\\\\\\\\\
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

///////////////////////////////////////////
/*function loadHighScore()
{
   local SS_Gametype rGame;
	local WorldInfo rWorld;
	local SS_HighScoreMenu gameState;
	local int i;

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
			gameState = new class'SS_HighScoreMenu';
			// Load the variables gamestate using BasicLoadObject
			// Version 0: Development

			if(class'Engine'.static.BasicLoadObject(gameState, "HighScore.bin", true, 0)) //Load only if the file actually exists
			{
			
			rGame.GoldMetalCount = 	gameState.GoldMetalCount;
			rGame.SilverMetalCount = gameState.SilverMetalCount ;
			rGame.BronzeMetalCount = gameState.BronzeMetalCount ;
			rGame.coffeeMugCount = gameState.coffeeMugCount;
			for ( i = 0; i < rGame.levelbeat.Length; i++ )
			{
			rGame.levelbeat[i] = gameState.levelbeat[i];

			}
		
			for ( i = 0; i < rGame.lvlNotBeatGold.Length; i++)
			{
			rGame.lvlNotBeatGold[i] = gameState.lvlNotBeatGold[i];

			}
			for ( i = 0; i < rGame.lvlNotBeatSilver.Length; i++)
			{
			rGame.lvlNotBeatSilver[i] = gameState.lvlNotBeatSilver[i];

			}
			for ( i = 0; i < rGame.lvlNotBeatBronze.Length; i++)
			{
			rGame.lvlNotBeatBronze[i] = gameState.lvlNotBeatBronze[i];

			}

			}
				

		}
	}

}
*/
////////////////////\\\\\\\\\\\\\\\\\\\\
function destroyPawn()
{

	if(Health <= 0 )
	{
//		savePCVariables();
		//DetachFromController(true);
		self.Destroy();
		Health = 100;
	}
}
	


//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{	
	// Remove the sprite component as it is not really needed
	Components.Remove(Sprite)

	// Create a light environment for the pawn
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=true
		bIsCharacterLightEnvironment=true
		bUseBooleanEnvironmentShadowing=false
	End Object
	Components.Add(MyLightEnvironment)
	LightEnvironment=MyLightEnvironment

	// Create a skeletal mesh component for the pawn
	Begin Object Class=SkeletalMeshComponent Name=MySkeletalMeshComponent
		PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_AimOffset'
		AnimSets(1)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
		//SkeletalMesh= SkeletalMesh'SwinginChar.swingin1'
	//	SkeletalMesh =SkeletalMesh'Chartestheight.testrun_Swiggins_Char';

		SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'

		//SkeletalMesh= SkeletalMesh'testchar.Knight_D_Pelegrini'

		//SkeletalMesh = SkeletalMesh'testchar.mudboxchar1';
	 

		// Extra Stuff
		AlwaysLoadOnServer=true
            CastShadow=true
            BlockRigidBody=false
            bUpdateSkelWhenNotRendered=true
            bIgnoreControllersWhenNotRendered=false
            bUpdateKinematicBonesFromAnimation=true
            bCastDynamicShadow=true
            RBChannel=RBCC_Untitled3
            RBCollideWithChannels=(Untitled3=true)
            LightEnvironment=MyLightEnvironment
            bAcceptsDynamicDecals=false
            bHasPhysicsAssetInstance=true
            TickGroup=TG_PreAsyncWork
            MinDistFactorForKinematicUpdate=0.0f
            bChartDistanceFactor=true
            RBDominanceGroup=20
            bUseOnePassLightingOnTranslucency=true
            bPerBoneMotionBlur=true
		End Object
	Mesh=MySkeletalMeshComponent
	Components.Add(MySkeletalMeshComponent)

	// Floating fix
	Begin Object Name=CollisionCylinder
		CollisionRadius=+0031.000000
		CollisionHeight=+0044.000000
		//OLD ONE WITH NONE CUSTOM 
		//CollisionHeight=+0044.000000
	End Object
	CylinderComponent=CollisionCylinder
	

	// Other pawn properties can give or take some extra behavior
	RBPushRadius=10.0
    RBPushStrength=50.0
	bPushesRigidBodies=true
	grabRopeSound = SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_BodyImpact_BodyFall_Cue' 
	// Air control adjusts the control the player has while in air ( float between 0 and 1, 1 being more control)
	AirControl = 0.50f
	AirSpeed = 1000.0
	

	GroundSpeed = 400.0 // Controls how fast the player can sprint
	//WalkingPct = .5    //Control default movement speed
	JumpZ = 525       // Controls how high the player can jump
	staminaSound = SoundCue'SS_Assets.Music.SirenSoundChips_Cue'
	MaxFallSpeed = 0
	
	turnOnSound = true;


}