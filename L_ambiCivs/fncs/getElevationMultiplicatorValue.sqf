params [
	"_pos1",
	"_pos2",
	"_value",
	"_multiplierValue"
];
private _z1 = _pos1 param [2,0];
private _z2 = _pos2 param [2,0];

private _diff = (_z1 - _z2) min L_ambiCivs_maxElevationDifference;
if (_diff > 0) then {
	_value = _value * (1 + (_multiplierValue * (_diff / L_ambiCivs_maxElevationDifference)));
};

_value;