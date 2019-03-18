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

local name		  = 'Plain Badge Quest'
local description = ' Plain Badge'
local level = 23

local PlainBadgeQuest = Quest:new()

function PlainBadgeQuest:new()
	return Quest.new(PlainBadgeQuest, name, description, level)
end

function PlainBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function PlainBadgeQuest:isDone()
	if hasItem("Plain Badge") and getMapName() == "Goldenrod City Gym" then
		return true
	else
		return false
	end
end

function PlainBadgeQuest:PokecenterGoldenrod()
	self:pokecenter("Goldenrod City")
end

function PlainBadgeQuest:GoldenrodCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Goldenrod" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Goldenrod")	
	elseif not self:isTrainingOver() then
		return PathFinder.moveTo(getMapName(), "Route 34")
    elseif isNpcOnCell(50,34) then
        talkToNpcOnCell(50,34)
	elseif not hasItem("Plain Badge") then
		return PathFinder.moveTo(getMapName(), "Goldenrod City Gym")
	else
		return PathFinder.moveTo(getMapName(), "Route 35 Stop House")
	end	
end

function PlainBadgeQuest:Route34()
    if not self:isTrainingOver() then
		return moveToGrass()
	else
		return PathFinder.moveTo(getMapName(), "Goldenrod City")
	end
end

function PlainBadgeQuest:GoldenrodCityGym()
	return talkToNpcOnCell(10,3)
end

return PlainBadgeQuest