local Game = {}

local Lib = require("Pathfinder/Lib/Lib")

function Game.getDistance(xa, ya, xb, yb)
    local xDist = xb - xa
    local yDist = yb - ya

    return math.sqrt((xDist ^ 2) + (yDist ^ 2))
end

function Game.getPokemonNumberWithMove(move, joy) -- optional parameter happiness
    joy = joy or 0
    for i = 1, getTeamSize() do
        if hasMove(i, move) and getPokemonHappiness(i) >= joy then
            return i
        end
    end
    return nil
end

function Game.getNpcOnCell(x, y)
	for _, npc in pairs(getNpcData()) do
		if tonumber(npc.x) == x and tonumber(npc.y) == y then
			return npc
		end
	end
	return nil
end

function Game.getNpcByName(name)
	for _, npc in pairs(getNpcData()) do
		if npc.name == name then
			return npc
		end
	end
	return nil
end

function Game.isTeamFullyHealed()
	for pokemonId=1, getTeamSize(), 1 do
		if getPokemonHealthPercent(pokemonId) < 100
			or not isPokemonUsable(pokemonId) then
			return false
		end
	end
	return true
end

function Game.isPokemonFullPP(pokemonId)
	Lib.todo("add getPokemonMoves() to PROShine")
	error("waiting for proshine update")
	return true
end

function Game.useAnyMove()
	local pokemonId = getActivePokemonNumber()
	for i=1,4 do
		local moveName = getPokemonMoveName(pokemonId, i)
		if not moveName and getRemainingPowerPoints(pokemonID, moveName) > 0 then
			log("Use any move")
			return useMove(moveName)
		end
	end
	return false
end

function Game.hasPokemonWithMove(Move)
	for pokemonId=1, getTeamSize(), 1 do
		if hasMove(pokemonId, Move) then
			return true
		end
	end
	return false
end

function Game.getPokemonNumberWithMove(Move)
	for i=1, getTeamSize(), 1 do
		if hasMove(i, Move) then
			return i
		end
	end
	return 0
end

local function returnSorted(valueA, valueB)
	if valueA > valueB then
		return valueB, valueA
	end
	return valueA, valueB
end

--[[###########################################
##                                           ##
## Merged from 'Libs/gamelib.lua' (Questing) ##
##                                           ##
#############################################]]
function Game.inRectangle(x1, y1, x2, y2)
	local aX, bX = returnSorted(x1, x2)
	local aY, bY = returnSorted(y1, y2)
	local x = getPlayerX()
	local y = getPlayerY()
	if aX <= x and x <= bX and aY <= y and y <= bY then
		return true
	end
	return false
end

function Game.minTeamLevel()
	local current
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonLevel = getPokemonLevel(pokemonId)
		if  current == nil or pokemonLevel < current then
			current = pokemonLevel
		end
	end
	return current
end

function Game.maxTeamLevel()
	local current
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonLevel = getPokemonLevel(pokemonId)
		if  current == nil or pokemonLevel > current then
			current = pokemonLevel
		end
	end
	return current
end

function Game.getMaxLevelUsablePokemon()
	local currentId
	local currentLevel
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonLevel = getPokemonLevel(pokemonId)
		if  (currentLevel == nil or pokemonLevel > currentLevel)
			and isPokemonUsable(pokemonId) then
			currentLevel = pokemonLevel
			currentId    = pokemonId
		end
	end
	return currentId, currentLevel
end

function Game.getUsablePokemonCountUnderLevel(level)
	local count = 0
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonLevel = getPokemonLevel(pokemonId)
		if  pokemonLevel < level
			and isPokemonUsable(pokemonId) then
			count = count + 1
		end
	end
	return count
end

local pokemonIdTeach = 1
function Game.tryTeachMove(movename, ItemName)
	if not Game.hasPokemonWithMove(movename) then
		if pokemonIdTeach > getTeamSize() then
			return fatal("No pokemon in this Team can learn: ".. ItemName)
		else
			log("Pokemon: " .. getPokemonName(pokemonIdTeach) .. " Try Learning: " .. ItemName)
			useItemOnPokemon(ItemName, pokemonIdTeach)
			pokemonIdTeach = pokemonIdTeach + 1
			return
		end
	end
	pokemonIdTeach = 1
	return true
end

function Game.getTotalUsablePokemonCount()
	local count = 0
	for pokemonId=1, getTeamSize(), 1 do
		if isPokemonUsable(pokemonId) then
			count = count + 1
		end
	end
	return count
end

function Game.getFirstUsablePokemon()
	for pokemonId=1, getTeamSize(), 1 do
		if isPokemonUsable(pokemonId) then
			return pokemonId
		end
	end
	return 0
end

function Game.getPokemonIdWithItem(ItemName)	
	for pokemonId=1, getTeamSize(), 1 do
		if getPokemonHeldItem(pokemonId) == ItemName then
			return pokemonId
		end
	end
	return 0
end
return Game