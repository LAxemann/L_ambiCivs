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
	"_civ"
];
private ["_debugMarkerCiv"];

// If criteria met, delete, otherwise set time for next check
private _grp = group _civ;
if (L_ambiCivs_debug) then {
	_debugMarkerCiv = _civ getVariable ["L_ambiCivs_debugMarkerCiv",objNull];
	_debugMarkerCiv setMarkerPosLocal (getPos _civ);
};

if ([_civ] call L_ambiCivs_fnc_deleteCheck) then {
	private _index = L_ambiCivs_civs find _civ;
	private _house = _civ getVariable ["L_ambiCivs_house",objNull];
	_house setVariable ["L_ambiCivs_houseIsFree",nil];
	L_ambiCivs_civs deleteAt _index;
	if (L_ambiCivs_debug) then {
		private _debugMarker = _civ getVariable ["L_ambiCivs_debugMarker",objNull];
		_debugMarker setMarkerColorLocal "ColorBlue";
		_house setVariable ["L_ambiCivs_debugMarker",_debugMarker];
		deleteMarkerLocal _debugMarkerCiv;
	};
	deleteVehicle _civ;
	deleteGroup _grp;
} else {
	if ((behaviour _civ) == "SAFE") then {
		_grp setSpeedMode "LIMITED";
	};
	[L_ambiCivs_fnc_civManager, [_civ], L_ambiCivs_deleteCheckInterval] call CBA_fnc_waitAndExecute;		
};



	








