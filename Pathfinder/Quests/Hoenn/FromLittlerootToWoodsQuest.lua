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

local name        = 'FromLittlerootToWoodsQuest'
local description = 'From Littleroot to Petalburg Woods '
local level       = 9
local FromLittlerootToWoodsQuest = Quest:new()

local dialogs = {
	profCheck = Dialog:new({ 
		"i gave her a task"
	}),
	jirachiCheck = Dialog:new({
		"JIRACHI"
		
	}),
	mayCheck = Dialog:new({ 
		"I heard much",
	})
}

function FromLittlerootToWoodsQuest:new()
	return Quest.new(FromLittlerootToWoodsQuest, name, description, level, dialogs)
end


function FromLittlerootToWoodsQuest:isDoable()
	return self:hasMap() and not hasItem("Stone Badge")
end

function FromLittlerootToWoodsQuest:isDone()
	return getMapName() == "Petalburg Woods"  or getMapName() == "Rustboro City"
end


function FromLittlerootToWoodsQuest:Route102()
	if  self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Oldale Town" then
		PathFinder.moveTo(getMapName(), "Oldale Town")
	elseif not self:isTrainingOver()  then
		moveToGrass()
	else PathFinder.moveTo(getMapName(), "Petalburg City")
	end
end

function FromLittlerootToWoodsQuest:PetalburgCity()
	if isNpcOnCell(38,22) then
			talkToNpcOnCell (38,22)
	elseif isNpcVisible("Norman") then
			talkToNpc ("Norman")
	elseif self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Petalburg City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Petalburg City")
	elseif not self:isTrainingOver() then 
		return PathFinder.moveTo(getMapName(), "Route 104")
	else if isNpcVisible("Norman") then
			talkToNpc ("Norman")
		else PathFinder.moveTo(getMapName(), "Route 104")
		end
	end
end

function FromLittlerootToWoodsQuest:PokecenterPetalburgCity()
	return self:pokecenter("Petalburg City")
end

function FromLittlerootToWoodsQuest:Route104()
	if Game.inRectangle(7,0,41,67) then 
		PathFinder.moveTo(getMapName(), "Rustboro City")
	elseif self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Petalburg City" then
		return PathFinder.moveTo(getMapName(), "Petalburg City")
	else moveToCell(36,79)
	end
end	


function FromLittlerootToWoodsQuest:LittlerootTownTruck()
	return PathFinder.moveTo(getMapName(), "Littleroot Town")
end

function FromLittlerootToWoodsQuest:LittlerootTown()
	if getTeamSize() == 0 and not dialogs.profCheck.state then
		return PathFinder.moveTo(getMapName(), "Prof. Birch House")
	elseif getTeamSize() == 0 and dialogs.profCheck.state then
		return PathFinder.moveTo(getMapName(), "Lab Littleroot Town")
	else PathFinder.moveTo(getMapName(), "Route 101")
	end
end

function FromLittlerootToWoodsQuest:PlayerHouseLittlerootTown()
	if not dialogs.jirachiCheck.state then 
		return PathFinder.moveTo(getMapName(), "Player Bedroom Littleroot Town")
	else return PathFinder.moveTo(getMapName(), "Littleroot Town")
	end
end

function FromLittlerootToWoodsQuest:ProfBirchHouse()
	if isNpcVisible("Professor Birch") then 
		return talkToNpc("Professor Birch")
	else PathFinder.moveTo(getMapName(), "Littleroot Town")
		 dialogs.profCheck.state = true
			
	end
end
	
function FromLittlerootToWoodsQuest:LabLittlerootTown()
	if getTeamSize() == 0 then 
			talkToNpcOnCell(10,4)
	end
	if (getTeamSize() == 1 or  getTeamSize() == 2)  then
		if isNpcVisible("#261") then 
			talkToNpc ("#261")
		else moveToMap ("Littleroot Town")
		end
	end
end


function FromLittlerootToWoodsQuest:PlayerBedroomLittlerootTown()
	if dialogs.jirachiCheck.state then
		return PathFinder.moveTo(getMapName(), "Player House Littleroot Town")	
	elseif isNpcVisible("#385") then 
		return talkToNpc("#385")
	else dialogs.jirachiCheck.state = true
	end
		
end


function FromLittlerootToWoodsQuest:Route101()
	return PathFinder.moveTo(getMapName(), "Oldale Town")
end

function FromLittlerootToWoodsQuest:OldaleTown()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Oldale Town" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Oldale Town")
	elseif self:needPokemart() then
		return PathFinder.moveTo(getMapName(), "Mart Oldale Town")
	elseif dialogs.mayCheck.state then 
		return PathFinder.moveTo(getMapName(), "Route 102")
	else
		return PathFinder.moveTo(getMapName(), "Route 103")
	end
end

function FromLittlerootToWoodsQuest:MartOldaleTown()
	self:pokemart("Oldale Town")
end

function FromLittlerootToWoodsQuest:Route103()
	if isNpcOnCell (30,11) then
		talkToNpcOnCell(30,11)
	else dialogs.mayCheck.state = true
		PathFinder.moveTo(getMapName(), "Oldale Town")
	end
end


function FromLittlerootToWoodsQuest:PokecenterOldaleTown()
	self:pokecenter("Oldale Town")
end


return FromLittlerootToWoodsQuest
