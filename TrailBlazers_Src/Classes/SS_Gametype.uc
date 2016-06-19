// Author:  Team TrailBlazers
// Date:    07/2014
// Credit:  Jason Chalky, Timothy Janssen, Brad Fairley, Andy Montgomery, Chris Augilar, Jesse Mangano
// Purpose: Initializing the Game Type for Swingin Swiggins
//---------------------------------------------------------------------------------------------------------------\\
class SS_Gametype extends UDKGame;
//---------------------------------------------------------------------------------------------------------------\\
// Variables
//variable for stamina
var float TotalStamina;
//Var for max stamina
var float MaxStamina;
//amount the player has died
var int PlayersDeathTotal;
//global timer variables
var int LevelMin;
var int LevelSec;
var float overall; 
//The start time of the level
var float TimeStarted;
var float TimeStarterMin;
var float TimeStartedSec;
//bool variables for drawing
var bool GoldTrue;
var bool SilverTrue;
var bool BronzeTrue;

//coffe mugs count
var int coffeeMugCount;
//HighScore
var int highScore;
var string currentMapName;
//Vars used for respawn
var int SS_Health;
var Vector playersLocation;
//Used to track player all the time for boss
var Vector CurrentPlayersLocation;
var SS_Pawn P;
// Variables for the collection respawn
var array <Vector> spawnLocation;
//var Vector spawnLocation;
var array <bool> isInWorld;
//var bool isInWorld;
var array <int> currentSeconds;
//var int currentSeconds;
// Variables for the collection respawn
var array <Vector> checkPointSpawnLocation;
//var Vector spawnLocation;
var array <bool> CheckPointIsInWorld;
//var bool isInWorld;
var array <int> CheckPointCurrentSeconds;
//var int currentSeconds;
//Sound for siren
var SoundCue Siren;
//Particle emitter variables
var ParticleSystem timeCollectibleEmitter;
var ParticleSystem StaminaCollectibleEmitter;
var ParticleSystem MaxStaminaEmitter;
var ParticleSystem timeCollectible10Emitter;
var ParticleSystemComponent BackTrail;
var ParticleSystemComponent HeadTrail;
var ParticleSystem AsteroidEmitter;
var bool slowMo;
var float slowPercent;
//Actor for respawn
var Actor actorObj;
//Respawn offset
var Vector respawnOffset;
// Used to tell which direction the player is moving in multiple cases
var float OurView;
//asteroids
var array <Vector> asteroidLocation;
//check if is in world
var array <bool> asteroidIsInWorld;
//timer for asteroid
var array <int> asteroidTimer;
//used to get map name
var string rMapName;

// Vector for camera
var Vector TestCamera;
var bool continueZoom;

//Varible to see if player is pressing S on last join
var bool FallDown;

//HighScoreMenu
var  int GoldMetalCount;
var  int SilverMetalCount;
var  int BronzeMetalCount;
var array<bool> levelbeat;
var array <bool> lvlNotBeatGold;
var array <bool> lvlNotBeatSilver;
var array <bool> lvlNotBeatBronze;

//Used to check if I need to destroy 
var bool destoryMaxStamina7;
// used to count levels passed;
var int LevelCounter;






//---------------------------------------------------------------------------------------------------------------\\
// Structs
Struct tCountDownTimer // struct that holds the CountDown Timer info
{
   var  Int     Sec;  //  Seconds component of the timer
   var  Int     Min; //  minutes component of the timer
};
Var  tCountDownTimer  CountDownTMR;
//---------------------------------------------------------------------------------------------------------------\\
// Events
simulated event Tick( FLOAT DeltaTime )
{
	if ( !slowMo )
	{
		WorldInfo.TimeDilation = 1.0;
	}
	else
	{
		WorldInfo.TimeDilation = slowPercent;
	}


	super.Tick(DeltaTime);
}
//---------------------------------------------------------------------------------------------------------------\\
// Functions
Function CheckTimer()
{


     if (CountDownTMR.Min == 0 &&  CountDownTMR.Sec == 0 )
     {
        // ----  Add any code that is needed to be initialized on CountDown Timer stoppage --------
          ClearTimer( 'CheckTimer' );
		 // RestartGame();
          Return;
     }
     if ( CountDownTMR.Sec > 0 )
     {
		if(CountDownTMR.Min < 1 && CountDownTMR.Sec == 59)
		{
			PlaySound(Siren);
		}
		if(CountDownTMR.Min < 1 && CountDownTMR.Sec == 30)
		{
			PlaySound(Siren);
		}
		if(CountDownTMR.Min < 1 && CountDownTMR.Sec == 10)
		{
			PlaySound(Siren);
		}

        CountDownTMR.Sec -= 1; // each Second decrease By 1
     }
	else if ( CountDownTMR.Sec == 0 )
	{
    CountDownTMR.Sec = 59;
    CountDownTMR.Min -= 1 ; // each 60 seconds decrease by 1
	}
	

}
////////////////////\\\\\\\\\\\\\\\\\\\\
Function SetCountDownTimer( int StartMin ,  Int StartSec ) // Activate the CountDown  timer
{
  if (!IsTimerActive('CheckTimer' ) )
  {
    CountDownTMR.Min =  StartMin;
    CountDownTMR.Sec = StartSec;
    Settimer( 1, true , 'CheckTimer' );
	SetTimer(2.0,true,'spawnCollectables');
	TestCamera.Y = -1000;
	//check to see if it is the right map, if so start the timer. 
	/*if(rMapName == "SwiginsTemplateBoss" || rMapName == "swiginstemplateboss")
	{
	SetTimer(1.0,false,'spawnAsteroids');
	TestCamera.Y = -1000;
	}
	*/
	
  }
}
////////////////////\\\\\\\\\\\\\\\\\\\\
simulated function PostBeginPlay()
{
	

    super.PostBeginPlay();
	//set map name before the level starts
	rMapName = WorldInfo.GetMapName();

	AdjustandSetTimer();

	
	//check to see if it is the right map
	/*
	if(rMapName == "SwiginsTemplateBoss" || rMapName == "swiginstemplateboss")
	{
	setAsteroidsLocations();
	`log("Setting location");
	}*/
}
////////////////////\\\\\\\\\\\\\\\\\\\\



function AdjustandSetTimer()
{
	local WorldInfo rWorldInfo;

	// Used to gain access to the world info of the game
	rWorldInfo = class 'WorldInfo'.static.GetWorldInfo ();
	// check to make sure we have a valid world info
	if ( rWorldInfo != none )
	{
		 SetCountDownTimer(LevelMin, LevelSec);
	}
}

////////////////////\\\\\\\\\\\\\\\\\\\\
/*function setAsteroidsLocations()
{
	local Vector alocation;
	

	alocation.X = -200;
	alocation.Y = 64;
	alocation.Z = 416;

	



	asteroidLocation.AddItem(alocation);
	asteroidTimer.AddItem(0);
	

	asteroidIsInWorld.AddItem(true);

	`log("Location is set");
	

}



/////////////////////////////\\\\\\\\\\\\\\\\\

function spawnAsteroids()
{

	// Used for the array loops
	local int j;
	local int i;
	
for ( j = 0; j < asteroidIsInWorld.Length; j++ )
	{
		//if (!asteroidIsInWorld[j])
		//{
			for ( i = 0; i < asteroidLocation.Length; i++ )
			{
				
				asteroidTimer[i] += 1;
				if ( asteroidTimer[i] == 1 )
				{
					asteroidIsInWorld[i] = true;
					Spawn (class 'SS_Asteroid',,, asteroidLocation[i] );
					`log("SpawnedAsteriod");
					
				
					
					
					//`log(asteroidLocation[i]);
					asteroidLocation.Remove (i, 1 );
					asteroidIsInWorld.Remove ( i, 1 );
					asteroidTimer.Remove ( i, 1 );
				}
			}
		//}
	}
setAsteroidsLocations();
}

*/
///////////////\\\\\\\\\\\\\\\\\
function spawnCollectables()
{

	// Used for the array loops
	local int j;
	local int i;

for ( j = 0; j < isInWorld.Length; j++ )
	{
		if (!isInWorld[j])
		{
			for ( i = 0; i < spawnLocation.Length; i++ )
			{
				currentSeconds[i] += 1;
				if ( currentSeconds[i] == 3 )
				{
					isInWorld[i] = true;
					Spawn (class 'SS_Collection', , , spawnLocation[i] );
					
					spawnLocation.Remove (i, 1 );
					isInWorld.Remove ( i, 1 );
					currentSeconds.Remove ( i, 1 );
				}
			}
		}
	}

}




//---------------------------------------------------------------------------------------------------------------\\
// Events
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return Default.Class;
}
//---------------------------------------------------------------------------------------------------------------\\
defaultproperties
{
   DefaultPawnClass=class'TrailBlazers_Src.SS_Pawn'
   PlayerControllerClass=class'TrailBlazers_Src.SS_PlayerController'

	
	
   //MapPrefixes[0]="UDN"

	// Set default stamina amount
	TotalStamina = 10.0f;
	MaxStamina = 10.0f;
	PlayersDeathTotal = 0;

	coffeeMugCount = 0;
	
	
	//Timer Variables Initial
	LevelMin = 1;
	LevelSec = 45;
	// HUD
	HUDType=class'TrailBlazers_Src.SS_SF_HUD'

	//set up bools for drawing
	GoldTrue = false;
	SilverTrue = false;
	BronzeTrue = false;

	SS_Health = 100;
	bDelayedStart = false;
	
	// Naming
	timeCollectibleEmitter = ParticleSystem'SS_Assets_Andy.Time_Collection_ParticleSystem';
	timeCollectible10Emitter = ParticleSystem'SS_Assets_Andy.Time_Collection10_ParticleSystem';
	StaminaCollectibleEmitter = ParticleSystem'SS_Assets_Andy.StaminaPickupCoffeeMugEffect';
	MaxStaminaEmitter = ParticleSystem'SS_Assets_Andy.MaxStaminaCollectionPS';
	AsteroidEmitter = ParticleSystem'KismetGame_Assets.Projectile.P_Spit_01';
	Siren = SoundCue'SS_Assets.Music.TimeRunningOut_Cue';	

	

	slowMo = false;
	slowPercent = 0.0;

	continueZoom = true;
	FallDown = false;

	levelbeat(0) = false;
	levelbeat(1) = false;
	lvlNotBeatGold(0) = true;
	lvlNotBeatGold(1) = true;
	lvlNotBeatGold(2) = true;
	lvlNotBeatGold(3) = true;
	lvlNotBeatGold(4) = true;
	lvlNotBeatGold(5) = true;
	lvlNotBeatGold(6) = true;
	lvlNotBeatGold(7) = true;
	lvlNotBeatGold(8) = true;
	lvlNotBeatGold(9) = true;
    lvlNotBeatGold(10) = true;
	lvlNotBeatGold(11) = true;
	lvlNotBeatGold(12) = true;
	lvlNotBeatGold(13) = true;
	lvlNotBeatGold(14) = true;
	lvlNotBeatGold(15) = true;
	lvlNotBeatGold(16) = true;
	lvlNotBeatGold(17) = true;
	lvlNotBeatGold(18) = true;
	lvlNotBeatGold(19) = true;
	lvlNotBeatGold(20) = true;
	lvlNotBeatGold(21) = true;
	lvlNotBeatGold(22) = true;
    lvlNotBeatGold(23) = true;
	lvlNotBeatGold(24) = true;
	lvlNotBeatGold(25) = true;
	lvlNotBeatGold(26) = true;
	lvlNotBeatGold(27) = true;
	lvlNotBeatGold(28) = true;
	lvlNotBeatGold(29) = true;
	
	lvlNotBeatSilver(0) = true;
	lvlNotBeatSilver(1) = true;
	lvlNotBeatSilver(2) = true;
	lvlNotBeatSilver(3) = true;
	lvlNotBeatSilver(4) = true;
	lvlNotBeatSilver(5) = true;
	lvlNotBeatSilver(6) = true;
	lvlNotBeatSilver(7) = true;
	lvlNotBeatSilver(8) = true;
    lvlNotBeatSilver(9) = true;
	lvlNotBeatSilver(10) = true;
	lvlNotBeatSilver(11) = true;
	lvlNotBeatSilver(12) = true;
	lvlNotBeatSilver(13) = true;
	lvlNotBeatSilver(14) = true;
	lvlNotBeatSilver(15) = true;
    lvlNotBeatSilver(16) = true;
	lvlNotBeatSilver(17) = true;
	lvlNotBeatSilver(18) = true;
	lvlNotBeatSilver(19) = true;
    lvlNotBeatSilver(20) = true;
	lvlNotBeatSilver(21) = true;
    lvlNotBeatSilver(22) = true;
    lvlNotBeatSilver(23) = true;
	lvlNotBeatSilver(24) = true;
	lvlNotBeatSilver(25) = true;
	lvlNotBeatSilver(26) = true;
	lvlNotBeatSilver(27) = true;
	lvlNotBeatSilver(28) = true;
	lvlNotBeatSilver(29) = true;

	lvlNotBeatBronze(0) = true;
	lvlNotBeatBronze(1) = true;
	lvlNotBeatBronze(2) = true;
	lvlNotBeatBronze(3) = true;
	lvlNotBeatBronze(4) = true;
	lvlNotBeatBronze(5) = true;
	lvlNotBeatBronze(6) = true;
	lvlNotBeatBronze(7) = true;
	lvlNotBeatBronze(8) = true;
	lvlNotBeatBronze(9) = true;
	lvlNotBeatBronze(10) = true;
	lvlNotBeatBronze(11) = true;
	lvlNotBeatBronze(12) = true;
	lvlNotBeatBronze(13) = true;
	lvlNotBeatBronze(14) = true;
	lvlNotBeatBronze(15) = true;
	lvlNotBeatBronze(16) = true;
	lvlNotBeatBronze(17) = true;
	lvlNotBeatBronze(18) = true;
	lvlNotBeatBronze(19) = true;
	lvlNotBeatBronze(20) = true;
	lvlNotBeatBronze(21) = true;
	lvlNotBeatBronze(22) = true;
	lvlNotBeatBronze(23) = true;
	lvlNotBeatBronze(24) = true;
	lvlNotBeatBronze(25) = true;
	lvlNotBeatBronze(26) = true;
	lvlNotBeatBronze(27) = true;
	lvlNotBeatBronze(28) = true;
	lvlNotBeatBronze(29) = true;
	
	
}