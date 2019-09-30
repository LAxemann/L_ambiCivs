/*
*	Author: LAxemann
*
*	Desc: 
*   Spawns a civilian and returns it
*
*	Params:
*	0 - Position where to spawn
*
*	Returns:
*	Object - Civilian
*
*	Example: 
*   [_spawnPos] call L_ambiCivs_fnc_getRoadDir
* =================================================*/
params [
	"_spawnPos"
];

private _type 	= selectRandom L_ambiCivs_civClasses;
private _grp 	= createGroup civilian;
private _civ 	= _grp createUnit [_type, _spawnPos,[],0,""];

_civ allowDamage false;
_civ setBehaviour "SAFE";					
_civ setSkill 0;	// Set skill to 0, saves performance :)
//_civ disableAI "RADIOPROTOCOL";
_civ disableAI "AUTOTARGET";
_grp setSpeedMode "LIMITED";

L_ambiCivs_civs pushBack _civ;

_civ;