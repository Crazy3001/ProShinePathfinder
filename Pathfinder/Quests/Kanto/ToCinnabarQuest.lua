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

local name		  = 'Traveling'
local description = 'Route 8 To Cinnabar Island'
local level = 55

local ToCinnabarQuest = Quest:new()

function ToCinnabarQuest:new()
	local o = Quest.new(ToCinnabarQuest, name, description, level)
	return o
end

function ToCinnabarQuest:isDoable()
	if self:hasMap() and hasItem("Marsh Badge") and not hasItem("Volcano Badge") then
		return true
	end
	return false
end

function ToCinnabarQuest:isDone()
	if getMapName() == "Cinnabar Island" or getMapName() == "Pokecenter Saffron" then --Fix Blackout
		return true
	end
	return false
end

function ToCinnabarQuest:Route8()
	return PathFinder.moveTo(getMapName(), "Lavender Town")
end

function ToCinnabarQuest:PokecenterLavender()
	self:pokecenter("Lavender Town")
end

function ToCinnabarQuest:LavenderTown()
	if self:needPokecenter() or not self.registeredPokecenter == "Pokecenter Lavender" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Lavender")
	else
		return PathFinder.moveTo(getMapName(), "Route 12")
	end
end

function ToCinnabarQuest:Route12()
	return PathFinder.moveTo(getMapName(), "Route 13")
end

function ToCinnabarQuest:Route13()
	return PathFinder.moveTo(getMapName(), "Route 14")
end

function ToCinnabarQuest:Route14()
	return PathFinder.moveTo(getMapName(), "Route 15")
end

function ToCinnabarQuest:Route15()
	return PathFinder.moveTo(getMapName(), "Route 15 Stop House")
end

function ToCinnabarQuest:Route15StopHouse()
	return PathFinder.moveTo(getMapName(), "Fuchsia City")
end

function ToCinnabarQuest:PokecenterFuchsia()
	self:pokecenter("Fuchsia City")
end

function ToCinnabarQuest:FuchsiaHouse1()
	if hasItem("Old Rod") and not hasItem("Good Rod") and getMoney() > 15000 then
		return talkToNpcOnCell(3,6)
	else
		return PathFinder.moveTo(getMapName(), "Fuchsia City")
	end
end

function ToCinnabarQuest:FuchsiaCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Fuchsia" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Fuchsia")
	elseif hasItem("Old Rod") and not hasItem("Good Rod") and getMoney() > 15000 then
		return PathFinder.moveTo(getMapName(), "Fuchsia House 1") --Item: GoodRod
	else
		return PathFinder.moveTo(getMapName(), "Fuchsia City Stop House")
	end
end

function ToCinnabarQuest:FuchsiaCityStopHouse()	
	return PathFinder.moveTo(getMapName(), "Route 19")
end

function ToCinnabarQuest:Route19()
	if Game.tryTeachMove("Surf", "HM03 - Surf") then
		return PathFinder.moveTo(getMapName(), "Route 20")
	end
end

function ToCinnabarQuest:Route20()
	if Game.inRectangle(52,16,120,36) then
		return moveToCell(60,32)
	elseif Game.inRectangle(0,15,51,47) or Game.inRectangle(52,40,81,46) then
		return PathFinder.moveTo(getMapName(), "Cinnabar Island")
	else
		error("ToCinnabarQuest:Route20(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function ToCinnabarQuest:Seafoam1F()
	if Game.inRectangle(7,7,20,16) then
		return moveToCell(20,8)
	elseif Game.inRectangle(64,7,77,15)then
		return moveToCell(71,15)
	else
		error("ToCinnabarQuest:Seafoam1F(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function ToCinnabarQuest:SeafoamB1F()
	if isNpcOnCell(38,17) then
		return talkToNpcOnCell(38,17) --Item: Ice Heal
	else
		return moveToCell(85,22)
	end
end

return ToCinnabarQuest