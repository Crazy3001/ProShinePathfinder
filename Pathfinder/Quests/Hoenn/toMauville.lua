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

local name        = 'ToMauville'
local description = 'Beat Museum,May and go to Mauville '

local level       = 25
local toMauville = Quest:new()


local dialogs = {
	devonVic = Dialog:new({ 
		"I need to do some research on this"
		
	}),
	ingenieur = Dialog:new({ 
		"Oh, you need to see Devon",
		"Restaurants for cats?" --ARE THEY OUT OF THEIR MINDS ? 

	}),
	goingO = Dialog:new({ 
		"What is going on?"

	}),
}

function toMauville:new()
	return Quest.new(toMauville , name, description, level, dialogs)
end


function toMauville:isDoable()
	if hasItem("Stone Badge") and self:hasMap() and not  hasItem("Dynamo Badge") then
		return true
	end
	return false
end

function toMauville:isDone()
		if (hasItem("Knuckle Badge") and  getMapName() == "Mauville City") then 
		return true
	end
	return false
end 

	
function toMauville:DevonCorporation3F()
	return PathFinder.moveTo(getMapName(), "Devon Corporation 2F")
end

function toMauville:DevonCorporation2F()
	return PathFinder.moveTo(getMapName(), "Devon Corporation 1F")
end

function toMauville:DevonCorporation1F()
	return PathFinder.moveTo(getMapName(), "Rustboro City")
end

function toMauville:RustboroCity()
	PathFinder.moveTo(getMapName(), "Route 104")
end


function toMauville:Route104()
	if Game.inRectangle(7,0,67,51) then 
		PathFinder.moveTo(getMapName(), "Petalburg Woods")
	else PathFinder.moveTo(getMapName(), "Route 104 Sailor House")
		
end
end

function toMauville:DewfordTown()
	pushDialogAnswer(2)
	talkToNpcOnCell(37,9)
end

function toMauville:Route109()
	PathFinder.moveTo(getMapName(), "Slateport City")
	
end

function toMauville:Route104SailorHouse()
	if isNpcOnCell(8,7) then 
		talkToNpcOnCell(8,7)
	elseif isNpcOnCell(8,6) then 
		talkToNpcOnCell(8,6)
	elseif isNpcOnCell(8,5) then 
		talkToNpcOnCell(8,5)
	elseif isNpcOnCell(9,5) then 
		talkToNpcOnCell(9,5)
	elseif isNpcOnCell(10,5) then 
		talkToNpcOnCell(10,5)
	elseif isNpcOnCell(11,5) then 
		talkToNpcOnCell(11,5)
	elseif isNpcOnCell(11,6) then 
		talkToNpcOnCell(11,6)
	elseif isNpcOnCell(11,7) then 
		talkToNpcOnCell(11,7)
	elseif isNpcOnCell(11,6) then 
		talkToNpcOnCell(11,6)
	elseif isNpcOnCell(11,7) then 
		talkToNpcOnCell(11,7)
	elseif isNpcOnCell(11,8) then 
		talkToNpcOnCell(11,8)
	elseif isNpcOnCell(10,8) then 
		talkToNpcOnCell(10,8)
	elseif isNpcOnCell(9,8) then 
		talkToNpcOnCell(9,8)
	elseif isNpcOnCell(8,8) then 
		talkToNpcOnCell(8,8)
	
		
	end
end

function toMauville:SlateportCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Slateport" then
		return moveToCell(32,25)
	elseif not hasItem("Devon Goods") then 
		return PathFinder.moveTo(getMapName(), "Route 110")
	elseif not dialogs.ingenieur.state and not dialogs.devonVic.state then 
		return moveToCell(39,54)
	elseif dialogs.ingenieur.state then 
		return moveToCell(55,38)
	else PathFinder.moveTo(getMapName(), "Route 110")
	end
	
end

function toMauville:SlateportShipyard1F()
	if not dialogs.ingenieur.state then 
		return talkToNpcOnCell(5,6)
	else
		return PathFinder.moveTo(getMapName(), "Slateport City")
	end
	
end

function toMauville:PokecenterSlateport()
	return self:pokecenter("Slateport City")
end

function toMauville:SlateportMuseum1F()
	if not dialogs.devonVic.state then 
		PathFinder.moveTo(getMapName(), "Slateport Museum 2F")
	else PathFinder.moveTo(getMapName(), "Slateport City")	
	end
end

 function toMauville:SlateportMuseum2F()
    if isNpcOnCell(11,14) and Game.inRectangle(9,12,12,15) then 
        return talkToNpcOnCell (11,14)
    elseif isNpcOnCell(11,14) and not Game.inRectangle(9,12,12,15) then 
        return talkToNpcOnCell(10,16)
    elseif isNpcVisible("Devon") and not dialogs.goingO.state then 
        return talkToNpc("Devon")
    elseif dialogs.devonVic.state then 
        dialogs.ingenieur.state = false
        return PathFinder.moveTo(getMapName(), "Slateport Museum 1F")
    else dialogs.devonVic.state = true
        dialogs.ingenieur.state = false
    end
end 

function toMauville:Route110()
	if self:needPokecenter() then
		PathFinder.moveTo(getMapName(), "Slateport City")
	elseif not self:isTrainingOver() then
		moveToRectangle(10,127,20,132)
	elseif isNpcOnCell(43,78) then 
		talkToNpcOnCell(43,78)
	else PathFinder.moveTo(getMapName(), "Mauville City Stop House 1")
	end
end

function toMauville:MauvilleCityStopHouse1()
	return PathFinder.moveTo(getMapName(), "Mauville City")
end

function toMauville:PetalburgWoods()
	return moveToCell(24,60)
	
	end
	
return toMauville