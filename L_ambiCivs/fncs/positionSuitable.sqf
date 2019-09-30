/*
*	Author: LAxemann
*
*	Desc: Checks if a position is suitable for spawning
*
*	Params:
*	0 - Position to check
*	1 - [Optional] minimum distance
*
*	Example:
*/

params [
	"_searchPos",
	["_minDist", 0]
];
private _minDistReal = _minDist;
private _suitable 	= true;

// Check if position lies within blacklist
{
	if (_searchPos inArea _x) exitWith {_suitable = false};
} count L_ambiCivs_blackList;


// Check if position is too close to players
if (_suitable) then {
	{	
		if (L_ambiCivs_increaseForAir && {(vehicle _x) isKindOf "Air"}) then {
			_minDist = _minDist * L_ambiCivs_airMultiplicator;
		} else {
			_minDist = _minDistReal;
		};
		if ((_searchPos distance _x) < _minDist) exitWith {_suitable = false};
	} count L_ambiCivs_players;
};

_suitable;

