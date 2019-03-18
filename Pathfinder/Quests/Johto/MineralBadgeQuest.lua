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

local name		  = 'Mineral Badge Quest'
local description = 'Last XP quest (62) until Dragon Den, and earn the 6th Badge'
local level = 65

local dialogs = {
	phare = Dialog:new({ 
		"fds"
	}),
	potion = Dialog:new({ 
		"How are you today deary?"
	})
}

local MineralBadgeQuest = Quest:new()

function MineralBadgeQuest:new()
	return Quest.new(MineralBadgeQuest, name, description, level, dialogs)
end

function MineralBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Mineral Badge") and hasItem("Storm Badge") then
		return true
	end
	return false
end

function MineralBadgeQuest:isDone()
	if hasItem("Mineral Badge") and getMapName() == "Olivine City Gym" then
		return true
	else
		return false
	end
end

function MineralBadgeQuest:CianwoodCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Cianwood" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Cianwood")
	elseif not dialogs.potion.state then 
		return PathFinder.moveTo(getMapName(), "Cianwood Shop")
	else
		return PathFinder.moveTo(getMapName(), "Route 41")
	end 
end

function MineralBadgeQuest:Route41()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		return moveToWater()
	else 
		return PathFinder.moveTo(getMapName(), "Route 40")
	end
end

function MineralBadgeQuest:Route40()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		return PathFinder.moveTo(getMapName(), "Route 41")
	else
		return PathFinder.moveTo(getMapName(), "Olivine City")
	end
	
end

function MineralBadgeQuest:OlivineCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Olivine City" then
		PathFinder.moveTo(getMapName(), "Olivine Pokecenter")
	elseif not dialogs.phare.state then 
		PathFinder.moveTo(getMapName(), "Glitter Lighthouse 1F")
	elseif not self:isTrainingOver() then 
		PathFinder.moveTo(getMapName(), "Route 40") 
	else PathFinder.moveTo(getMapName(), "Olivine City Gym")
	end
end

function MineralBadgeQuest:GlitterLighthouse1F()
	if dialogs.phare.state then 
		moveToCell(8,14)
	else moveToCell(9,5)
	end
end

function MineralBadgeQuest:GlitterLighthouse2F()
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

function MineralBadgeQuest:GlitterLighthouse3F()
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

function MineralBadgeQuest:GlitterLighthouse4F()
	if dialogs.phare.state then 
		moveToCell(5,4)
	else moveToCell(11,6)
	end
end

function MineralBadgeQuest:GlitterLighthouse5F()
	if dialogs.phare.state then 
		moveToCell(11,11)
	elseif  isNpcOnCell(11,9) then
		talkToNpcOnCell(11,9)
	elseif not isNpcOnCell(11,9) then
		dialogs.phare.state = true
		moveToCell(11,11)
		return
	end
end

function MineralBadgeQuest:CianwoodShop()
	if not dialogs.potion.state then 
		talkToNpcOnCell(2,2)
	else PathFinder.moveTo(getMapName(), "Cianwood City")
	end
end

function MineralBadgeQuest:OlivinePokecenter()
	self:pokecenter("Olivine City")
end

function MineralBadgeQuest:PokecenterCianwood()
	self:pokecenter("Cianwood City")
end

function MineralBadgeQuest:OlivineCityGym()
	talkToNpcOnCell(6,3)
end

function MineralBadgeQuest:CianwoodCityGym()
	PathFinder.moveTo(getMapName(), "Cianwood City")
end

function MineralBadgeQuest:MapName()
	
end


return MineralBadgeQuest