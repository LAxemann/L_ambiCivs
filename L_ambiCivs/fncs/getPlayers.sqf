/*
*	Author: LAxemann
*
*	Desc: Sets the array of players without blacklisted players
*
*	Params: None
*
*	Returns:
*	Array, Array of players minus blacklisted ones
*
*	Example:
*/
private ["_startPos","_endPos","_objects"];
if ((count L_ambiCivs_blacklist_players) > 0) then {
	L_ambiCivs_players = allPlayers select {
		!(_x in L_ambiCivs_blacklist_players)
	};
} else {
	L_ambiCivs_players = allPlayers;
};

/*
L_ambiCivs_playerBuildings = [];

{
	_startPos = eyePos _x;
	_startPos params [
		"_posX",
		"_posY",
		"_posZ"
	];
	_endPos = [_posX,_posY,_posZ + 4];
	_objects = lineIntersectsWith [_startPos, _endPos];
	
	
} count L_ambiCivs_players;
*/