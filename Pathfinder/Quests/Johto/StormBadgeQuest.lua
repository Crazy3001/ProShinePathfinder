-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name		  = 'Storm Badge Quest'
local description = ' From ecruteak to Storm Badge'
local level = 40

local dialogs = {
	phare = Dialog:new({ 
		"Please return fast!"
	})
}

local StormBadgeQuest = Quest:new()

function StormBadgeQuest:new()
	o = Quest.new(StormBadgeQuest, name, description, level, dialogs)
	o.pokemonId = 1
	o.N = 2

	return o
end

function StormBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Storm Badge") and hasItem("Fog Badge") then
		return true
	end
	return false
end

function StormBadgeQuest:isDone()
	if hasItem("Storm Badge") and getMapName() == "Cianwood City Gym" then
		return true
	else
		return false
	end
end

function StormBadgeQuest:EcruteakGym()
	PathFinder.moveTo(getMapName(), "Ecruteak City")
end

function StormBadgeQuest:EcruteakCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Ecruteak" then
		PathFinder.moveTo(getMapName(), "Pokecenter Ecruteak")
	else PathFinder.moveTo(getMapName(), "Ecruteak Stop House 1")
	end
end

function StormBadgeQuest:PokecenterEcruteak()
	self:pokecenter("Ecruteak City")
end

function StormBadgeQuest:OlivinePokecenter()
	self:pokecenter("Olivine City")
end

function StormBadgeQuest:PokecenterCianwood()
	self:pokecenter("Cianwood City")
end



function StormBadgeQuest:EcruteakStopHouse1()
	PathFinder.moveTo(getMapName(), "Route 38")
end

function StormBadgeQuest:Route38()
	PathFinder.moveTo(getMapName(), "Route 39")
end

function StormBadgeQuest:Route39()
	PathFinder.moveTo(getMapName(), "Olivine City")
end

function StormBadgeQuest:OlivineCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Olivine" then
		PathFinder.moveTo(getMapName(), "Olivine Pokecenter")
	elseif not dialogs.phare.state then 
		PathFinder.moveTo(getMapName(), "Glitter Lighthouse 1F")
	else PathFinder.moveTo(getMapName(), "Route 40")
	end
end

function StormBadgeQuest:GlitterLighthouse1F()
	if dialogs.phare.state then 
		moveToCell(8,14)
	else moveToCell(9,5)
	end
end

function StormBadgeQuest:GlitterLighthouse2F()
	if dialogs.phare.state then 
		if Game.inRectangle (10,4,15,7)then
		moveToCell(13,7)
		elseif Game.inRectangle (3,4,9,13)then
		moveToCell(9,12)
		end
	else if Game.inRectangle (10,4,15,7)then
		moveToCell(12,4)
		elseif Game.inRectangle (3,4,9,13)then
		moveToCell(3,5)
		end
	end
end

function StormBadgeQuest:GlitterLighthouse3F()
	if dialogs.phare.state then 
		if Game.inRectangle (9,3,13,12)then
		moveToCell(12,5)
		elseif Game.inRectangle (1,6,6,3)then
		moveToCell(3,5)
		end
	else 
		if Game.inRectangle (9,3,13,12)then
		moveToCell(9,12)
		elseif Game.inRectangle (1,6,6,3)then
		 moveToCell(5,4)
		 end
	end
end

function StormBadgeQuest:GlitterLighthouse4F()
	if dialogs.phare.state then 
		moveToCell(5,4)
	else moveToCell(11,6)
	end
end

function StormBadgeQuest:GlitterLighthouse5F()
	if dialogs.phare.state then 
		moveToCell(11,11)
	else talkToNpcOnCell(11,9)
		 dialogs.phare.state = true
	end
end

function StormBadgeQuest:Route40()
	if not Game.hasPokemonWithMove("Surf") then
		if self.pokemonId <= getTeamSize() then
			useItemOnPokemon("HM03 - Surf", self.pokemonId)
			log("Pokemon: " .. self.pokemonId .. " Try Learn Surf")
			self.pokemonId = self.pokemonId + 1
		else
			return fatal("No pokemon in this team can learn Surf")
		end
	else PathFinder.moveTo(getMapName(), "Route 41")
	end
end

function StormBadgeQuest:Route41()
	PathFinder.moveTo(getMapName(), "Cianwood City")
end

function StormBadgeQuest:CianwoodCity()
	if self:needPokecenter() or self.registeredPokecenter != "Pokecenter Cianwood" then
		PathFinder.moveTo(getMapName(), "Pokecenter Cianwood")
	elseif not self:isTrainingOver() then 
		moveToWater()
	else PathFinder.moveTo(getMapName(), "Cianwood City Gym")
	end
end

function StormBadgeQuest:CianwoodCityGym()
	talkToNpcOnCell(32,15)
end








return StormBadgeQuest