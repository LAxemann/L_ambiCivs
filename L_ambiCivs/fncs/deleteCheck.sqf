/*
*	Author: LAxemann
*
*	Desc: 
*   Manages the spawning of civilians and cars
*
*	Params:
*	None
*
*	Returns:
*	Nothing
*
*	Example: 
*   call L_ambiCivs_fnc_civManager
* =================================================*/
params [
	"_object"
];
private _delete = true;

// Check if position is far enough away from players
{
	if ((_object distance2d _x) < L_ambiCivs_maxDistanceToPlayers) exitWith {_delete = false;}
} count L_ambiCivs_players;

_delete;