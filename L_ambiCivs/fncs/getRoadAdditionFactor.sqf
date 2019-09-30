params [
	"_searchPos"
];

private _roadList = _searchPos nearRoads 26;
private _factorValue = (L_ambiCivs_inhabitChance * 0.35);
private _factor =   [0, _factorValue] select ((count _roadList) > 0); 
_factor;