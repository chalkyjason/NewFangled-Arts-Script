class SS_InventoryManager extends InventoryManager;

/*
event PostBeginPlay()
{
local SS_Weapon Myweapon;


Myweapon = Spawn(class 'SS_Weapon',Pawn(Owner));
AddInventory(Myweapon);
`log(Myweapon);


	Super.PostBeginPlay();
	//function to set pawn as owner
	SetupPawn();
	//Instigator = Pawn(Owner);

}

function SetupPawn()
{
local SS_BossPawn P;
Instigator = P;
SetOwner(P);

}
*/
DefaultProperties
{
    PendingFire(0)=0
    PendingFire(1)=0
}