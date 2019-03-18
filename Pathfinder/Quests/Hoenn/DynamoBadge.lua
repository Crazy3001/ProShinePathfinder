-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa] @Melt


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name		  = 'Dynamo Badge'
local description = 'Will earn Dynamo Badge'
local level = 32
local DynamoBadge = Quest:new()

function DynamoBadge:new()
	return Quest.new(DynamoBadge, name, description, level, dialogs)
end

function DynamoBadge:isDoable()
	if self:hasMap() and not  hasItem("Dynamo Badge") then
		return true
	end
	return false
end

function DynamoBadge:isDone()
	return  hasItem("Dynamo Badge")
end

function DynamoBadge:MauvilleCity()
	if not hasItem("TM114") then
		return PathFinder.moveTo(getMapName(), "Mauville City House 2")	
	elseif not Game.tryTeachMove("Rock Smash", "TM114") then
		return -- until move gets taught or error -- NEED PC LIB
	elseif self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Mauville City")
	elseif isNpcOnCell(13,14) then
		return talkToNpcOnCell(13,14)
	elseif not self:isTrainingOver() then
		return PathFinder.moveTo(getMapName(), "Mauville City Stop House 2")
	elseif not  hasItem("Dynamo Badge") then 
		return PathFinder.moveTo(getMapName(), "Mauville City Gym")
	end
	
	
end

function DynamoBadge:Route117()
	if self:needPokecenter() then
		return PathFinder.moveTo(getMapName(), "Mauville City Stop House 2")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	else 
		return PathFinder.moveTo(getMapName(), "Mauville City Stop House 2")
	end
	
end

function DynamoBadge:MauvilleCityHouse2()
	if not hasItem("TM114") then
		return talkToNpc("Nerd Julian")
	else
		return PathFinder.moveTo(getMapName(), "Mauville City")
	end
	
end

function DynamoBadge:PokecenterMauvilleCity()
	return self:pokecenter("Mauville City")
end

function DynamoBadge:MauvilleCityStopHouse2()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		return PathFinder.moveTo(getMapName(), "Route 117")
	else
		return PathFinder.moveTo(getMapName(), "Mauville City")
	end
end

function DynamoBadge:MauvilleCityGym()
	if isNpcOnCell(9,15) then
		log("Switching 1st Because of Right of 2nd locked")
		return talkToNpcOnCell(1,19)
	elseif isNpcOnCell(7,9) and isNpcOnCell(11,13) then
		log("Switching 2nd Because of Lower 3rd locked")
		return talkToNpcOnCell(7,15)
	elseif isNpcOnCell(7,9) then
		log("Switching 3rd Because of Boss locked")
		return talkToNpcOnCell(11,11)
	elseif isNpcOnCell(7,13) then
		log("Switch 2nd Because of Middle locked")
		return talkToNpcOnCell(7,15)
	else
		log("Going to Gym leader")
		return talkToNpcOnCell(7,1)
	end
end



return DynamoBadge