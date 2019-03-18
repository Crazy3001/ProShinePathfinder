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

local name		  = 'Rising Badge Quest'
local description = 'Will exp to lv 80 and earn the 8th badge'
local level = 80

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local RisingBadgeQuest = Quest:new()

function RisingBadgeQuest:new()
	return Quest.new(RisingBadgeQuest, name, description, level, dialogs)
end

function RisingBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Rising Badge") and hasItem("Glacier Badge") then
		return true
	end
	return false
end

function RisingBadgeQuest:isDone()
	if hasItem("Rising Badge") then
		return true
	else
		return false
	end
end

function RisingBadgeQuest:MahoganyTownGym()
	if Game.inRectangle(15,66,21,50) then 
		moveToCell(18,67)
	elseif Game.inRectangle(12,33,18,45) then  
		moveToCell(17,46)
	elseif Game.inRectangle(13,12,20,28) then 
		moveToCell(17,29)
	end
end

function RisingBadgeQuest:PokecenterMahogany()
	if isNpcOnCell(9,22) then
		talkToNpcOnCell(9,22)
	else return self:pokecenter("Mahogany Town")
	end
end


function RisingBadgeQuest:MahoganyTown()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Mahogany Town" then
		PathFinder.moveTo(getMapName(), "Pokecenter Mahogany")
	else PathFinder.moveTo(getMapName(), "Route 44")
	end
end

function RisingBadgeQuest:Route44()
	PathFinder.moveTo(getMapName(), "Ice Path 1F")
end

function RisingBadgeQuest:IcePath1F()
	if Game.inRectangle(11,61,49,15) or Game.inRectangle(47,13,58,19) then
		moveToCell(57,15)
	else PathFinder.moveTo(getMapName(), "Blackthorn City")
	end
end

function RisingBadgeQuest:IcePathB1F()
	if Game.inRectangle (41,41,24,49) or Game.inRectangle (24,45,17,43) then
		moveToCell(18,45)
	else
	moveToCell(21,25)
	end
end

function RisingBadgeQuest:IcePathB2F()
	if Game.inRectangle (58,9,49,30) then
		moveToCell(50,27)
	else
		moveToCell(23,22)
	end
end

function RisingBadgeQuest:IcePathB3F()
	moveToCell(32,17)
end

function RisingBadgeQuest:BlackthornCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Blackthorn City" then
		PathFinder.moveTo(getMapName(), "Pokecenter Blackthorn" )
	elseif not self:isTrainingOver() then 
		PathFinder.moveTo(getMapName(), "Dragons Den Entrance")
	else PathFinder.moveTo(getMapName(), "Blackthorn City Gym")
	end
end

function RisingBadgeQuest:DragonsDenEntrance()
	if self:needPokecenter() then
		PathFinder.moveTo(getMapName(), "Blackthorn City")
	elseif not self:isTrainingOver() then
		PathFinder.moveTo(getMapName(), "Dragons Den")
	else PathFinder.moveTo(getMapName(), "Blackthorn City")
	end
end

function RisingBadgeQuest:DragonsDen()
	if self:needPokecenter() then 
		PathFinder.moveTo(getMapName(), "Dragons Den Entrance")
	elseif not self:isTrainingOver()then
		moveToRectangle(35,17,50,24)
	else PathFinder.moveTo(getMapName(), "Dragons Den Entrance")
	end
end

function RisingBadgeQuest:PokecenterBlackthorn()
	self:pokecenter("Blackthorn City")
end


function RisingBadgeQuest:BlackthornCityGym()
	talkToNpcOnCell(29,12)
end

return RisingBadgeQuest