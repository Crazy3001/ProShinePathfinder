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

local name		  = 'Ilex Forest'
local description = ' Farfetch Quest'
local level = 20

local dialogs = {
	farfetchQuestAccept = Dialog:new({ 
		"have you found it yet"
	})
}

local IlexForestQuest = Quest:new()

function IlexForestQuest:new()
	local o = Quest.new(IlexForestQuest, name, description, level, dialogs)
	o.pokemon = "Oddish"
	o.forceCaught = false
	return o
end

function IlexForestQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function IlexForestQuest:isDone()
	if getMapName() == "Goldenrod City" or getMapName() == "Pokecenter Azalea" or getMapName() == "Pokecenter Goldenrod"  or getMapName() == "Azalea Town" then
		return true
	end
	return false
end

function IlexForestQuest:IlexForestStopHouse()
	if self:needPokecenter() then
		return PathFinder.moveTo(getMapName(), "Azalea Town")
	else
		return PathFinder.moveTo(getMapName(), "Ilex Forest")
	end
end

function IlexForestQuest:IlexForest()
	if self:needPokecenter() then
		return PathFinder.moveTo(getMapName(), "Ilex Forest Stop House")
	elseif isNpcOnCell(12,58) then
		if not dialogs.farfetchQuestAccept.state then
			return talkToNpcOnCell(12,58)
		else
			if isNpcOnCell(47,42) then
				return talkToNpcOnCell(47,42)
			else
				return talkToNpcOnCell(12,58)
			end
		end
	elseif not self.forceCaught then
		moveToRectangle(19,46,43,63)
	else
		if Game.tryTeachMove("Cut","HM01 - Cut") == true then
			return PathFinder.moveTo(getMapName(), "Route 34 Stop House")
		end
	end
end

function IlexForestQuest:Route34StopHouse()
	return PathFinder.moveTo(getMapName(), "Route 34")
end

function IlexForestQuest:Route34()
	return PathFinder.moveTo(getMapName(), "Goldenrod City")
end

return IlexForestQuest