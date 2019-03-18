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

local name		  = 'Azalea Town'
local description = ' Hive Badge'
local level = 20

local HiveBadgeQuest = Quest:new()

function HiveBadgeQuest:new()
	return Quest.new(HiveBadgeQuest, name, description, level)
end

function HiveBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function HiveBadgeQuest:isDone()
	return getMapName() == "Ilex Forest"
end

function HiveBadgeQuest:PokecenterAzalea()
	self:pokecenter("Azalea Town")
end

function HiveBadgeQuest:AzaleaPokemart()
	self:pokemart("Azalea Town")	
end

function HiveBadgeQuest:AzaleaTown()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Azalea" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Azalea")
	elseif self:needPokemart() then
		return PathFinder.moveTo(getMapName(), "Azalea Pokemart")	
	elseif not self:isTrainingOver() then
		return PathFinder.moveTo(getMapName(), "Route 33")
	elseif isNpcOnCell(19,28) then	
		return PathFinder.moveTo(getMapName(), "Slowpoke Well")
	elseif not hasItem("Hive Badge") then
		return PathFinder.moveTo(getMapName(), "Azalea Town Gym")
	elseif isNpcOnCell(5,12) then
		return talkToNpcOnCell(5,12)
	else
		return PathFinder.moveTo(getMapName(), "Ilex Forest Stop House")
	end	
end

function HiveBadgeQuest:Route33()
	if self:needPokecenter() or self:needPokemart() or not self.registeredPokecenter == "Pokecenter Azalea" then
		return PathFinder.moveTo(getMapName(), "Azalea Town")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	else
		return PathFinder.moveTo(getMapName(), "Azalea Town")
	end
end

function HiveBadgeQuest:IlexForestStopHouse()
	return PathFinder.moveTo(getMapName(), "Ilex Forest")
end

function HiveBadgeQuest:SlowpokeWell()
	if isNpcOnCell(12,26) then
		return talkToNpcOnCell(12,26)
	else
		return PathFinder.moveTo(getMapName(), "Azalea Town")
	end
end

function HiveBadgeQuest:AzaleaTownGym()
	if not hasItem("Hive Badge") then
		return talkToNpcOnCell(15,3)
	else
		return PathFinder.moveTo(getMapName(), "Azalea Town")
	end
end

return HiveBadgeQuest