// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Brad Fairley, Chris Augilar
// Purpose: Initializing the Ropes for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Rope extends KActorSpawnable
	placeable;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
var SoundCue pawnstaminagasp;
var(connections) RB_BSJointActor NextJoint, ThisJoint, PrevJoint;
//---------------------------------------------------------------------------------------------------------------\\
// Events
 event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	if ( SS_Pawn(Other) != none )
	{
		PlaySound(pawnstaminagasp);
	}
}
//---------------------------------------------------------------------------------------------------------------\\
DefaultProperties
{
	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'LT_Deco.SM.Mesh.S_LT_Deco_SM_Cable_01'
		PhysMaterialOverride=PhysicalMaterial'Test.SS_RopeControl_Material'
		WireframeColor=(R=0,G=255,B=128,A=255)
		BlockRigidBody=false
		RBChannel=RBCC_GameplayPhysics
		RBCollideWithChannels=(Pawn=TRUE,BlockingVolume=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE)
		bBlockFootPlacement=false
		LightingChannels=(Dynamic=true);
	End Object

	StaticMeshComponent = StaticMeshComponent0;
	CollisionComponent = StaticMeshComponent0;
	pawnstaminagasp = SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_DoubleJump_Cue'
}
