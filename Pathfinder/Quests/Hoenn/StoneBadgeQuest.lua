-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name        = 'StoneBadgeQuestQuest'
local description = 'Will get the 1st badge'

local level       = 11
local clock = os.clock





local StoneBadgeQuest = Quest:new()

local dialogs = {
	magmaCheck = Dialog:new({ 
		"You're against me"
	}),
	
}

function StoneBadgeQuest:new()
	return Quest.new(StoneBadgeQuest, name, description, level, dialogs)
end


function StoneBadgeQuest:isDoable()
	if not hasItem("Stone Badge")   and self:hasMap() then
		return true
	end
	return false
end

function StoneBadgeQuest:isDone()
	 if (hasItem("Stone Badge") and getMapName() == "Rustboro City Gym") or getMapName() == "Pokecenter Petalburg City" then 
			return true 
		else 
			return false
	end
end


function StoneBadgeQuest:PetalburgWoods()
	if isNpcOnCell(38,30) then 
		talkToNpcOnCell(38,30)
	elseif isNpcOnCell(36,30) and not dialogs.magmaCheck.state  then 
		talkToNpcOnCell(36,30)
	elseif isNpcOnCell(37,29) then
		talkToNpcOnCell(37,29)
	else moveToCell(22,0)
	end
end

function StoneBadgeQuest:RustboroCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		PathFinder.moveTo(getMapName(), "Pokecenter Rustboro City")
	elseif not self:isTrainingOver() then 
		return PathFinder.moveTo(getMapName(), "Route 104")
	elseif self:isTrainingOver() and not hasItem("Stone Badge") then
		PathFinder.moveTo(getMapName(), "Rustboro City Gym")
	end
end

function StoneBadgeQuest:Route104()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		moveToCell(40,0)
	elseif not self:isTrainingOver() then
		moveToGrass()
	else moveToCell(40.0)
	end
end	

function StoneBadgeQuest:PokecenterRustboroCity()
	return self:pokecenter("Rustboro City")
end

function StoneBadgeQuest:RustboroCityGym()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		return PathFinder.moveTo(getMapName(), "Rustboro City")
	elseif not hasItem("Stone Badge") then 
		talkToNpcOnCell(10,3)
	end
end	

return StoneBadgeQuest
