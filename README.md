//--/ L_ambiCivs by LAxemann /--//
A lightweight script suite that allows multiplayer-compatible civil population.
Civilians will walk around urban areas after spawning into "their" house.
Features a "script hook" for running a function on every spawned civilian or its assigned house.
Features blacklisting areas and players.
The script runs COMPLETELY SERVER-SIDE.


/* Quick Start */
1.   Drop the "L_ambiCivs" folder as well as the "initServer.sqf" into your mission folder. That's it.
1.1  If you already got an initServer.sqf, paste the following anywhere into the file:
     #include "L_ambiCivs\init.sqf"

	 
/* Quick configuration */
1. Navigate into the L_ambiCivs folder within your mission folder. You may want to look into three files: "config.sqf","classes.sqf" and "blacklists.sqf"
2. Config.sqf: Basic settings like spawn distances and behaviour. (Tip: Increase the check intervals in case you experience performance issues with a large amount of players)
	2.1: Assigning a function name to L_ambiCivs_customInitFunction will make the function run when a civilian spawns, passing the argument [civilian, assigned house].
3. Classes.sqf: Civilian classes that will be spawned.
4. Blacklist.sqf: Blacklisting areas civilians shouldn't spawn in and players that should be ignored by the script.
!! All parameters can be changed on the fly during a mission !!


/* Known issues / limitations */
- The script focuses on performance and by default does a simple job - it makes AI civilians walk around cities. Advanced behaviour has to be scripted manually.


/* License */
You are free to modify the script to your liking within your mission, but please mention the modification.
Uploading a modification of the script as a "standalone" version is not permitted.