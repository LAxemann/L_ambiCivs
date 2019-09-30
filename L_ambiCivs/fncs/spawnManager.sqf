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
*   call L_ambiCivs_fnc_spawnManager
* =================================================*/

if ((time > L_ambiCivs_nextSpawn) && {L_ambiCivs_enabled}) then {
	private _currentCivs = count L_ambiCivs_civs;
	call L_ambiCivs_fnc_getPlayers;
	if ((_currentCivs < L_ambiCivs_maxCivs) && {(count L_ambiCivs_players) > 0}) then {
		// Pick a random player, get the distances and a random position around them, then check for roads
		private _originUnit 	= selectRandom L_ambiCivs_players;
		private _searchPos 		= [getPosATL _originUnit,L_ambiCivs_minSpawnDistance + random ((L_ambiCivs_maxDistanceToPlayers - L_ambiCivs_minSpawnDistance) / 1.2)] call L_ambiCivs_fnc_getRandomPos;
		private _house = nearestBuilding _searchPos;
		
		/* Check if a house was found */
		if !(isNull _house) then {
			/* Was the house flagged "inhabited" before or has a civilian assigned at the moment? */
			if ((_house getVariable ["L_ambiCivs_inhabitedHouse",true]) && {_house getVariable ["L_ambiCivs_houseIsFree",true]}) then {
				private ["_debugMarker"];
				if (L_ambiCivs_debug) then {
					_debugMarker = _house getVariable ["L_ambiCivs_debugMarker","none"];
					if (_debugMarker == "none") then {
						_debugMarker = createMarkerLocal [format ["L_ambiCivs_debugMarker_%1",L_ambiCivs_debugMarkerIndex], position _house];
						_debugMarker setMarkerTypeLocal "mil_box";
						L_ambiCivs_debugMarkerIndex = L_ambiCivs_debugMarkerIndex + 1;
					};
				};	
				private _inhabitChance = random 1;
				private _roadAdditionFactor = [position _house] call L_ambiCivs_fnc_getRoadAdditionFactor;
				private _posArray = [_house] call BIS_fnc_buildingPositions;
				private _checkedBefore = _house getVariable ["L_ambiCivs_notCheckedBefore",true]; // Prevents already-checked buildings from changing their inhabitation state
				/* Check if the building will be "inhabited" and has enough building positions */
				if (_checkedBefore && {(_inhabitChance > (L_ambiCivs_inhabitChance + _roadAdditionFactor)) || ((count _posArray) == 0)}) then {
					if (L_ambiCivs_debug) then {
						_debugMarker setMarkerColorLocal "ColorRed";
					};
					_house setVariable ["L_ambiCivs_inhabitedHouse",false];
				} else {
					_house setVariable ["L_ambiCivs_notCheckedBefore",false];
					_searchPos = selectRandom _posArray;
					if ([_searchPos,L_ambiCivs_minSpawnDistance] call L_ambiCivs_fnc_positionSuitable) then {
						private _civ = [_searchPos] call L_ambiCivs_fnc_spawnCiv;
						_civ allowDamage true;
						private _grp = group _civ;
						if (L_ambiCivs_autoBehaviour) then {[_grp, getPos _civ, (20 + (random 200))] call BIS_fnc_taskPatrol};
						if !(L_ambiCivs_customInitFunction isEqualType "") then {[_civ,_house] call L_ambiCivs_customInitFunction};
						_grp setSpeedMode "LIMITED";
						
						_civ setVariable ["L_ambiCivs_house",_house];
						_house setVariable ["L_ambiCivs_houseIsFree",false];
						
						[L_ambiCivs_fnc_civManager, [_civ], L_ambiCivs_deleteCheckInterval] call CBA_fnc_waitAndExecute;
						
						if (L_ambiCivs_debug) then {
							
							_debugMarker setMarkerColorLocal "ColorGreen";
							_debugMarkerCiv = createMarkerLocal [format ["L_ambiCivs_debugMarker_%1",L_ambiCivs_debugMarkerIndex], position _civ];
							_debugMarkerCiv setMarkerTypeLocal "hd_dot";
							_debugMarkerCiv setMarkerColorLocal "ColorOrange";
							
							_civ setVariable ["L_ambiCivs_debugMarker",_debugMarker];
							_civ setVariable ["L_ambiCivs_debugMarkerCiv",_debugMarkerCiv];
							
							L_ambiCivs_debugMarkerIndex = L_ambiCivs_debugMarkerIndex + 1;
						};
					} else {
						if (L_ambiCivs_debug) then {
							deleteMarkerLocal _debugMarker;
							L_ambiCivs_debugMarkerIndex = L_ambiCivs_debugMarkerIndex - 1;
						};
					};
				};
			};
		};
	};
	L_ambiCivs_nextSpawn = time + L_ambiCivs_spawnCheckInterval;
};
