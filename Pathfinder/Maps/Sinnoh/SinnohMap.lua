local cpath = select(1, ...) or "" -- callee path
local function nTimes(n, f, x) for i = 0, n - 1 do x = f(x) end return x end -- calls n times f(x)
local function rmlast(str) return str:sub(1, -2):match(".+[%./]") or "" end -- removes last dir / file from the callee path
local cpppdpath = nTimes(4, rmlast, cpath) -- callee parent parent of parent dir path

local _ss = require (cpppdpath .. "Settings/Static_Settings")

return function()

-- local K_SUBWAY = 1
-- if getServer() ~= "None" then
	-- local ss = _ss()
	-- K_SUBWAY = ss.K_SUBWAY
-- end

local SinnohMap = {}

SinnohMap["Canalave City"] = {["Route 218 Stop House 2"] = {1}, ["Canalave Pokemart"] = {1}, ["Canalave Pokecenter"] = {1}}
SinnohMap["Canalave Pokecenter"] = {["Canalave City"] = {1}}
SinnohMap["Canalave Pokemart"] = {["Canalave City"] = {1}}
SinnohMap["Celestic Pokecenter"] = {["Celestic Town"] = {1}}
SinnohMap["Celestic Town"] = {["Route 210 North"] = {1}, ["Celestic Pokecenter"] = {1}, ["Route 211_B"] = {1}}
SinnohMap["Dawn House"] = {}
SinnohMap["Eterna City Stop House"] = {["Eterna City"] = {1}, ["Route 206"] = {1}}
SinnohMap["Eterna City"] = {["Route 205_B"] = {1}, ["Pokecenter Eterna City"] = {1}, ["Mart Eterna City"] = {1}, ["Route 211_A"] = {1}, ["Eterna City Stop House"] = {1}}
SinnohMap["Eternal Forest"] = {["Route 205_A"] = {1}}
SinnohMap["Floaroma Meadow"] = {["Floaroma Town"] = {1}}
SinnohMap["Floaroma Town"] = {["Route 204_B"] = {1}, ["Pokecenter Floaroma"] = {1}, ["Mart Floaroma"] = {1}, ["Route 205_A"] = {1}, ["Floaroma Meadow"] = {1}}
SinnohMap["Hearthome City Stop House 2"] = {["Hearthome City"] = {0.2}, ["Route 212 North"] = {0.2}}
SinnohMap["Hearthome City"] = {["Route 208 Stop House"] = {1}, ["Mart Hearthome"] = {1}, ["Hearthome Pokecenter"] = {1}, ["Route 209 Stop House"] = {1}, ["Hearthome City Stop House 2"] = {1}}
SinnohMap["Hearthome Pokecenter"] = {["Hearthome City"] = {1}}
SinnohMap["Jubilife City"] = {["Pokecenter Jubilife City"] = {1}, ["Mart Jubilife City"] = {1}, ["Route 202"] = {1}, ["Route 204_A"] = {1}, ["Route 203"] = {1}, ["Route 218 Stop House 1"] = {1}, ["Jubilife TV 1F"] = {1}, ["Jubilife House 1"] = {1}, ["Jubilife House 2"] = {1}, ["Jubilife House 3"] = {1}, ["Jubilife Trainers School"] = {1}, ["Jubilife Global Station"] = {1}, ["Poketch Company 1F"] = {1}}
SinnohMap["Jubilife Global Station"] = {}
SinnohMap["Jubilife House 1"] = {}
SinnohMap["Jubilife House 2"] = {}
SinnohMap["Jubilife House 3"] = {}
SinnohMap["Jubilife TV 1F"] = {}
SinnohMap["Jubilife Trainers School"] = {}
SinnohMap["Lake Valor Exploded"] = {["Valor Lakefront"] = {1}, ["Valor Cavern"] = {1}}
SinnohMap["Lake Verity"] = {}
SinnohMap["Link"] = {}
SinnohMap["Mart Eterna City"] = {["Eterna City"] = {1}}
SinnohMap["Mart Floaroma"] = {["Floaroma Town"] = {1}}
SinnohMap["Mart Hearthome"] = {["Hearthome City"] = {1}}
SinnohMap["Mart Jubilife City"] = {["Jubilife City"] = {1}}
SinnohMap["Mart Oreburgh City"] = {["Oreburgh City"] = {1}}
SinnohMap["Mart Sandgem Town"] = {["Sandgem Town"] = {1}}
SinnohMap["Mt. Coronet Center"] = {["Route 211_A"] = {1}, ["Route 211_B"] = {1}, ["Mt. Coronet Tunnel"] = {1, {["abilities"] = {"rock smash"}}}}
SinnohMap["Mt. Coronet South"] = {["Route 207"] = {1}, ["Route 208"] = {1}}
SinnohMap["Mt. Coronet Tunnel"] = {["Mt. Coronet Center"] = {1}}
SinnohMap["Oreburgh City"] = {["Oreburgh Gate 1F"] = {1}, ["Pokecenter Oreburgh City"] = {1}, ["Mart Oreburgh City"] = {1}, ["Route 207"] = {1}, ["Oreburgh Mine B1F"] = {1}}
SinnohMap["Oreburgh Gate 1F"] = {["Route 203"] = {1}, ["Oreburgh City"] = {1}, ["Oreburgh Gate B1F"] = {1,{["abilities"] = {"rock smash"}}}}
SinnohMap["Oreburgh Gate B1F"] = {["Oreburgh Gate 1F"] = {1}}
SinnohMap["Oreburgh Mine B1F"] = {["Oreburgh City"] = {1}, ["Oreburgh Mine B2F 1R"] = {1}}
SinnohMap["Oreburgh Mine B2F 1R"] = {["Oreburgh Mine B1f"] = {1}, ["Oreburgh Mine B2F 2R"] = {1}}
SinnohMap["Oreburgh Mine B2F 2R"] = {["Oreburgh Mine B2F 1R"] = {1}, ["Oreburgh Mine B1F"] = {1}}
SinnohMap["Pastoria City Stop House"] = {["Route 213"] = {0.2}, ["Pastoria City"] = {0.2}}
SinnohMap["Pastoria City"] = {["Pastoria City Stop House"] = {1}, ["Pastoria Pokecenter"] = {1}, ["Pastoria Pokemart"] = {1}}
SinnohMap["Pastoria Pokecenter"] = {["Pastoria City"] = {1}}
SinnohMap["Pastoria Pokemart"] = {["Pastoria City"] = {1}}
SinnohMap["Pokecenter Eterna City"] = {["Eterna City"] = {1}}
SinnohMap["Pokecenter Floaroma"] = {["Floaroma Town"] = {1}}
SinnohMap["Pokecenter Jubilife City"] = {["Jubilife City"] = {1}}
SinnohMap["Pokecenter Oreburgh City"] = {["Oreburgh City"] = {1}}
SinnohMap["Pokecenter Sandgem Town"] = {["Sandgem Town"] = {1}}
SinnohMap["Poketch Company 1F"] = {}
SinnohMap["Ravaged Path_A"] = {["Route 204_A"] = {1}, ["Ravaged Path_B"] = {0.2, {["abilites"] = {"rock smash"}}}}
SinnohMap["Ravaged Path_B"] = {["Ravaged Path_A"] = {0.2, {["abilities"] = {"rock smash"}}}, ["Route 204_B"] = {1}}
SinnohMap["Route 201"] = {["Sandgem Town"] = {1}, ["Twinleaf Town"] = {1}, ["Lake Verity"] = {1}}
SinnohMap["Route 202"] = {["Sandgem Town"] = {1}, ["Jubilife City"] = {1}}
SinnohMap["Route 203"] = {["Jubilife City"] = {1}, ["Oreburgh Gate 1F"] = {1}}
SinnohMap["Route 204_A"] = {["Jubilife City"] = {1}, ["Ravaged Path_A"] = {1}}
SinnohMap["Route 204_B"] = {["Ravaged Path_B"] = {1}, ["Floaroma Town"] = {1}}
SinnohMap["Route 205_A"] = {["Floaroma Town"] = {1}, ["Valley Windworks"] = {1}, ["Eternal Forest"] = {1}, ["Route 205_B"] = {0, {["abilities"] = {"cut"}}}}
SinnohMap["Route 205_B"] = {["Route 205_A"] = {0, ["abilities"] = {"cut"}}, ["Eterna City"] = {1}}
SinnohMap["Route 206 Stop House"] = {["Route 206"] = {1}, ["Hearthome City"] = {1}}
SinnohMap["Route 206"] = {["Eterna City Stop House"] = {0.2, {["abilities"] = {"cut"}}}, ["Route 206 Stop House"] = {1}, ["Route 207"] = {0.2, {["abilities"] = {"cut"}}}}
SinnohMap["Route 207"] = {["Route 206"] = {1}, ["Mt. Coronet South"] = {1}, ["Oreburgh City"] = {1}}
SinnohMap["Route 208 Stop House"] = {["Route 208"] = {0.2}, ["Hearthome City"] = {0.2}}
SinnohMap["Route 208"] = {["Mt. Coronet South"] = {1}, ["Route 208 Stop House"] = {1}}
SinnohMap["Route 209 Stop House"] = {["Hearthome City"] = {0.2}, ["Route 209"] = {0.2}}
SinnohMap["Route 209"] = {["Route 209 Stop House"] = {1}, ["Solaceon Town"] = {1}}
SinnohMap["Route 210 North"] = {["Route 210"] = {1}, ["Celestic Town"] = {1}}
SinnohMap["Route 210"] = {["Solaceon Town"] = {1}, ["Route 215"] = {1}, ["Route 210 North"] = {1}}
SinnohMap["Route 211_A"] = {["Eterna City"] = {1}, ["Mt. Coronet Center"] = {1}}
SinnohMap["Route 211_B"] = {["Mt. Coronet Center"] = {1}, ["Celestic Town"] = {1}}

SinnohMap["Route 212 North"] = {["Hearthome City Stop House 2"] = {1}, ["Route 212 South"] = {0.2}}
SinnohMap["Route 212 South"] = {["Route 212 North"] = {1}, ["Pastoria City"] = {1}}
SinnohMap["Route 213 House 1"] = {["Route 213"] = {0.2}}
SinnohMap["Route 213"] = {["Valor Lakefront"] = {1}, ["Route 213 House 1"] = {1}, ["Pastoria City Stop House"] = {1}}
SinnohMap["Route 214 Stop House"] = {["Veilstone City"] = {0.2}, ["Route 214"] = {0.2}}
SinnohMap["Route 214"] = {["Route 214 Stop House"] = {1}, ["Valor Lakefront"] = {1}}
SinnohMap["Route 215 Stop House"] = {["Route 215"] = {0.2}, ["Veilstone City"] = {0.2}}
SinnohMap["Route 215"] = {["Route 210"] = {1}, ["Route 215 Stop House"] = {1}}
SinnohMap["Route 218 Stop House 1"] = {["Jubilife City"] = {1}, ["Route 218"] = {1}}
SinnohMap["Route 218 Stop House 2"] = {["Route 218"] = {0.2}, ["Canalave City"] = {0.2}}
SinnohMap["Route 218"] = {["Route 218 Stop House 1"] = {1}, ["Route 218 Stop House 2"] = {1}}
SinnohMap["Rowan Lab"] = {}
SinnohMap["Sandgem Town House"] = {}
SinnohMap["Sandgem Town"] = {["Route 202"] = {1}, ["Route 201"] = {1}, ["Pokecenter Sandgem Town"] = {1}, ["Mart Sandgem Town"] = {1}, ["Rowan Lab"] = {1}, ["Sandgem Town House"] = {1}, ["Dawn House"] = {1}, ["Route 219"] = {1}}
SinnohMap["Solaceon Pokecenter"] = {["Solaceon Town"] = {1}}
SinnohMap["Solaceon Pokemart"] = {["Solaceon Town"] = {1}}
SinnohMap["Solaceon Town"] = {["Route 209"] = {1}, ["Solaceon Pokemart"] = {1}, ["Solaceon Pokecenter"] = {1}, ["Route 210"] = {1}}
SinnohMap["Twinleaf Town House 1"] = {}
SinnohMap["Twinleaf Town Player House"] = {["Twinleaf Town"] = {1}}
SinnohMap["Twinleaf Town Revival House"] = {}
SinnohMap["Twinleaf Town"] = {["Route 201"] = {1}, ["Twinleaf Town Player House"] = {1}, ["Twinleaf Town House 1"] = {1}, ["Twinleaf Town Revival House"] = {1}, ["Link"] = {1}, ["Route 219"] = {1, {["abilities"] = {"surf"}}}}
SinnohMap["Valley Windworks Interior"] = {["Valley Windworks"] = {1}}
SinnohMap["Valley Windworks"] = {["Route 205_A"] = {1}, ["Valley Windworks Interior"] = {1}}
SinnohMap["Valor Cavern"] = {["Lake Valor Exploded"] = {1}}
SinnohMap["Valor Lakefront"] = {["Route 214"] = {1}, ["Route 213"] = {1}, ["Lake Valor Exploded"] = {1}}
SinnohMap["Veilstone City"] = {["Route 215 Stop House"] = {1}, ["Veilstone Pokecenter"] = {1}, ["Route 214 Stop House"] = {1}}
SinnohMap["Veilstone Pokecenter"] = {["Veilstone City"] = {1}}


-- KantoMap["node"] = {["link"] = {distance, {["restrictionType"] = {"restriction"}}}}

return SinnohMap
end
