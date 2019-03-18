-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name        = 'Boulder Badge'
local description = 'from route 2 to route 3'

local BoulderBadgeQuest = Quest:new()
function BoulderBadgeQuest:new()
	return Quest.new(BoulderBadgeQuest, name, description, 14)
end

function BoulderBadgeQuest:isDoable()
	if not hasItem("Cascade Badge") and self:hasMap()
	then
		return true
	end
	return false
end

function BoulderBadgeQuest:isDone()
	return getMapName() == "Pokecenter Route 3"
end

-- in case of black out
function BoulderBadgeQuest:PokecenterViridian()
	return PathFinder.moveTo(getMapName(), "Viridian City")
end

function BoulderBadgeQuest:ViridianCity()
	return PathFinder.moveTo(getMapName(), "Route 2")
end

function BoulderBadgeQuest:Route2()
	if Game.inRectangle(0, 90, 24, 130) then
		return PathFinder.moveTo(getMapName(), "Route 2 Stop")
	elseif Game.inRectangle(0, 0, 28, 42) then
		self:route2Up()
	else
		error("BoulderBadgeQuest:Route2(): This position should not be possible")
	end
end

function BoulderBadgeQuest:Route2Stop()
	return PathFinder.moveTo(getMapName(), "Viridian Forest")
end

function BoulderBadgeQuest:ViridianForest()
	return PathFinder.moveTo(getMapName(), "Route 2 Stop2")
end

function BoulderBadgeQuest:Route2Stop2()
	return PathFinder.moveTo(getMapName(), "Route 2")
end

function BoulderBadgeQuest:route2Up()
	if self.registeredPokecenter ~= "Pokecenter Pewter" then
		return PathFinder.moveTo(getMapName(), "Pewter City")
	elseif not self:needPokecenter() and not self:isTrainingOver() then
		return moveToGrass()
	else
		return PathFinder.moveTo(getMapName(), "Pewter City")
	end
end

function BoulderBadgeQuest:PewterCity()
	if isNpcOnCell(23, 22) then
		-- red blocking the way after beating Brock
		return talkToNpcOnCell(23, 22)
	elseif self:needPokemart() then
		return PathFinder.moveTo(getMapName(), "Pewter Pokemart")
	elseif hasItem("Boulder Badge") then
		return PathFinder.moveTo(getMapName(), "Route 3")
	elseif self.registeredPokecenter ~= "Pokecenter Pewter"
		or not Game.isTeamFullyHealed()
	then
		return PathFinder.moveTo(getMapName(), "Pokecenter Pewter")
	elseif getItemQuantity("Pokeball") < 50 and getMoney() >= 200 then
		return PathFinder.moveTo(getMapName(), "Pewter Pokemart")
	elseif self:isTrainingOver() then
		return PathFinder.moveTo(getMapName(), "Pewter Gym")
	else
		return PathFinder.moveTo(getMapName(), "Route 2")
	end
end

function BoulderBadgeQuest:PewterGym()
	if hasItem("Boulder Badge") then
		Lib.todo("BoulderBadgeQuest::PewterGym(): buy the TM")
		return PathFinder.moveTo(getMapName(), "Pewter City")
	else
		return talkToNpcOnCell(7,5)
	end
end

function BoulderBadgeQuest:Route3()
	return PathFinder.moveTo(getMapName(), "Pokecenter Route 3")
end

function BoulderBadgeQuest:PokecenterPewter()
	self:pokecenter("Pewter City")
end

function BoulderBadgeQuest:PewterPokemart()
	self:pokemart("Pewter City")
end

return BoulderBadgeQuest
