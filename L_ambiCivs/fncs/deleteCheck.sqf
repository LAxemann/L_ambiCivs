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
private ["_maxDist"];
params [
	"_civ"
];
private _delete = true;
private _maxDistReal = L_ambiCivs_maxDistanceToPlayers;
private _multiplierValue = (L_ambiCivs_elevationMultiplier - 1) max 0;

// Check if position is far enough away from players
{
	if (L_ambiCivs_increaseWithElevation) then {
		_maxDist = [eyePos _x,eyePos _civ,_maxDistReal,_multiplierValue] call L_ambiCivs_fnc_getElevationMultiplicatorValue;
	} else {
		_maxDist = _maxDistReal;
	};
	if ((_civ distance2d _x) < _maxDist) exitWith {_delete = false;}
} count L_ambiCivs_players;

_delete;