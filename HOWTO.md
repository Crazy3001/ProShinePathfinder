This is a guide on possibilities provided by the PathFinder module, and how to use them.

I strongly advice you read the LoadMe_Test.lua. As it is the simplest application of the module you can make.
The Settings are located in Pathfinder/Settings/static_Settings.lua, You should read and modify them if you want.
How to enable Dig / Headbutt / Discoving Items ? Read the setting file.

The only module you need to require is MoveToApp. The module return a table of functions.
Pathfinder = require "Pathfinder/MoveToApp"

The following assume you understand the lua module system and understand how to use functions from a module.

Module functions list :
1) MoveTo(map)
2) MoveToPC()
3) UseNearestPokecenter()
4) UseNearestPokemart(item, amount)
5) EnableBikePath()
6) DisableBikePath()
7) EnableDigPath()
8) DisableDigPath()

1) MoveTo(map)
- Expect parameter map, string or list of string, strings must be the names of a known map ( case sensitive ).
See the list of maps supported inside Maps folder.
if it receive a list of maps it will go to the closest one.
- Return true if moving and false when destination is reached.
- Examples use of MoveTo(map) : - MoveTo("Viridian City") -> will move to Viridian City.
                                - MoveTo({"Viridian City", "Ecruteak City"}) -> will move to the closest map found.

2) MoveToPC()
- function requesting MoveTo() with a list of Pokecenter, resulting in moving to the closest Pokecenter.
- return true when moving, false when in a Pokecenter.

3) UseNearestPokecenter()
- Move to the closest Pokecenter and use it.
- Return value will always be true.

4) UseNearestPokemart(item, amount) /!\ items map not completed /!\ see Maps/Items
- Moves to the closest Pokemart and buy item, amount times.
- Return true if moving, false on performing a buy.

About digways shortcut path and Bike exclusive path:
The pathfinder checks on loading if you have the requierments to use them,
if in your script you happend to want to change them you can use functions 5 to 8.

5) EnableBikePath() / 6) DisableDigPath()
- function enable / disable the digways shortcuts paths.

7) EnableDigPath() / 8) DisableDigPath()
- function enable / disable the bike exclusive paths
