class SS_AIController extends AIController;

var Actor target;
var Actor NewTarget;
var() Vector TempDest;
var Projectile ShootProjectile;
var Vector ProjectileVelocity;
var SS_Weapon MyWeapon;
var float PlayersDistanceAI;

var Vector Direction;
var Rotator NewRotation;
var PlayerController PlayerController;

//Not needed anymore to spawn weapon
/*
event PreBeginPlay()
{


		MyWeapon = Spawn(class 'SS_Weapon',SS_BossPawn(Pawn).Owner);

}

*/
simulated event Tick( FLOAT DeltaTime )
{


	// Find the player controller in the world
		PlayerController = GetALocalPlayerController();

		if (PlayerController != None && PlayerController.Pawn != None)
		{
			// Set the enemy to the player controller's pawn
			Enemy = PlayerController.Pawn;
		}

	// Find the direction in order for me to look at my enemy
		Direction = Enemy.Location - Location;
		// Only need to use the yaw from the direction
		NewRotation = Rotator(Direction);
		NewRotation.Pitch = 0;
		NewRotation.Roll = 0;
		// Set the rotation so that I look at the enemy
		//When this is set it shoots in one direction
		//SetRotation(NewRotation);

	super.Tick(DeltaTime);
	SetUpPlayersDistance();
	//`log(PlayersDistanceAI);

	

}



auto state Idle
{


    event SeePlayer (Pawn Seen)
    {
        super.SeePlayer(Seen);
        target = Seen;
        GotoState('Follow');
    }

	Begin:
}
state Follow
{
    ignores SeePlayer;

    function bool FindNavMeshPath()
    
    {
        // Clear cache and constraints (ignore recycling for the moment)
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;
 
        // Create constraints
        class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle,target  );
        class'NavMeshGoal_At'.static.AtActor( NavigationHandle, target,32 );
 
        // Find path
        return NavigationHandle.FindPath();
    }

Begin:
  NewTarget = GetALocalPlayerController().Pawn;

 if( NavigationHandle.ActorReachable( target) )
    {

        FlushPersistentDebugLines();
 
        //Direct move
        MoveToward( target,target );
		

			
    }
    else if( FindNavMeshPath() )
    {
        NavigationHandle.SetFinalDestination(target.Location);
        FlushPersistentDebugLines();
        NavigationHandle.DrawPathCache(,TRUE);
 
        // move to the first node on the path
        if( NavigationHandle.GetNextMoveLocation( TempDest, Pawn.GetCollisionRadius()) )
        {
            //DrawDebugLine(Pawn.Location,TempDest,255,0,0,true);
            //DrawDebugSphere(TempDest,16,20,255,0,0,true);
			Target = GetALocalPlayerController().Pawn;
		
            MoveTo( TempDest, target );
			 


        }
    }
    else
    {
        //We can't follow, so get the hell out of this state, otherwise we'll enter an infinite loop.
        GotoState('Idle');
    }
 
	if (PlayersDistanceAI  <= 1200)
	
	
{
	
    GotoState('Shoot'); //Start shooting when close enough to the player.

}
    goto 'Begin';

}

state Shoot
{
    function Aim()
    {

// Set the rotation so that I look at the enemy
	//	SetRotation(NewRotation);


		
       // local Rotator final_rot;
        //final_rot = Rotator(vect(0,0,1)); //Look straight up
        //SS_Pawn(Pawn).SetViewRotation(final_rot);
    }
	
Begin:
 
   // SS_BossPawn(Pawn).ZeroMovementVariables();
    SS_BossPawn(Pawn).Sleep(1); //Give the pawn the time to stop.
 
  //  Aim();


	//ShootProjectile = Spawn(class'SS_BossProjectile',,,SS_BossPawn(Pawn).Location,SS_BossPawn(Pawn).Rotation);

	//ShootProjectile.Init(SS_Pawn(Pawn).Location);

	//ShootProjectile.Velocity.X = 200;



   SS_BossPawn(Pawn).StartFire(0);
   SS_BossPawn(Pawn).StopFire(0);
   //Pawn.StartFire(1);

   //Pawn.StopFire(1);
  
    GotoState('Idle');
}

simulated event GetPlayerViewPoint(out vector out_Location, out Rotator out_Rotation)
{
    // AI does things from the Pawn
    if (Pawn != None)
    {
        out_Location = Pawn.Location;
        out_Rotation = Rotation; //That's what we've changed
    }
    else
    {
        Super.GetPlayerViewPoint(out_Location, out_Rotation);
    }
}

function SetUpPlayersDistance()
{
    local WorldInfo rWorldInfo;
	local SS_Gametype rGame;
	
	
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();

	if(rWorldInfo != none)
	{
		rGame = SS_Gametype(rWorldInfo.Game);
		
		if ( rGame != none )
		{
			// Sets the distance for the pawn from the collection

			//Set an offset so the distance works. 
	
		
		
				
				PlayersDistanceAI = VSize(rGame.CurrentPlayersLocation - SS_BossPawn(Pawn).Location  );
			
		}
	}




}
DefaultProperties
{
}
