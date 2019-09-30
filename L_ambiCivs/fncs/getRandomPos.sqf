/*
*	Author: LAxemann
*
*	Desc: 
*
*	Params:
*	0
*	1
*	2
*	3
*
*	Example:
*/

params [
	"_pos",
	"_dist"
];
private _dir = random 360;

_pos = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
_pos;