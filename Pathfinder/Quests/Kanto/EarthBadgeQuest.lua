-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name		  = 'Earth Badge'
local description = ' Beat Giovanni'
local level = 75

local EarthBadgeQuest = Quest:new()

function EarthBadgeQuest:new()
	return Quest.new(EarthBadgeQuest, name, description, level)
end

function EarthBadgeQuest:isDoable()
	if self:hasMap() and hasItem("Volcano Badge") and not hasItem("Zephyr Badge")then --Fixed DC on gym after win
		return true
	end
	return false
end

function EarthBadgeQuest:isDone()
	if (hasItem("Earth Badge") and getMapName() == "Route 22") or getMapName() == "Pokecenter Cinnabar" then --Fixed DC on gym after win, and Blackout
		return true
	end
	return false	
end

function EarthBadgeQuest:Route21()
	return PathFinder.moveTo(getMapName(), "Pallet Town")
end

function EarthBadgeQuest:PlayerBedroomPallet()
	return PathFinder.moveTo(getMapName(), "Player House Pallet")
end

function EarthBadgeQuest:PlayerHousePallet()
	return moveToCell(4,10)
end

function EarthBadgeQuest:PalletTown()
	return PathFinder.moveTo(getMapName(), "Route 1")
end

function EarthBadgeQuest:Route1()
	return PathFinder.moveTo(getMapName(), "Route 1 Stop House")
end

function EarthBadgeQuest:Route1StopHouse()
	return PathFinder.moveTo(getMapName(), "Viridian City")
end

function EarthBadgeQuest:PokecenterViridian()
	self:pokecenter("Viridian City")
end

function EarthBadgeQuest:ViridianPokemart()
	self:pokemart("Viridian City")
end

function EarthBadgeQuest:ViridianCity()
	if self:needPokecenter() or not self.registeredPokecenter == "Pokecenter Viridian" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Viridian")
	elseif self:needPokemart() then
		return PathFinder.moveTo(getMapName(), "Viridian Pokemart")
	elseif hasItem("Earth Badge") then
		return PathFinder.moveTo(getMapName(), "Route 22")
	elseif not self:isTrainingOver() then
		return fatal("Error This team can't beat Giovanni")
	else
		return moveToCell(60,22) --Viridian Gym 2
	end
end

function EarthBadgeQuest:ViridianGym2()
	if hasItem("Earth Badge") then
		return PathFinder.moveTo(getMapName(), "Viridian City")
	else
		if isNpcOnCell(10,26) then --NPC Gary
			return talkToNpcOnCell(10,26)
		else
			return talkToNpcOnCell(10,8)
		end
	end
end

return EarthBadgeQuest