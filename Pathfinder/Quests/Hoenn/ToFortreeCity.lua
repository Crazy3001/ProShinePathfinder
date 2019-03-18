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

local name		  = 'ToFortreeCity'
local description = ' Clean Rockets at Weather Institute, and get Devon Scope'
local level = 45

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local ToFortreeCity = Quest:new()

function ToFortreeCity:new()
	return Quest.new(ToFortreeCity, name, description, level, dialogs)
end



function ToFortreeCity:isDoable()
	return self:hasMap() and not hasItem("Devon Scope")
end

function ToFortreeCity:isDone()
	return hasItem("Devon Scope")
end

function ToFortreeCity:PokecenterPetalburgCity()
	self:pokecenter("Petalburg City")
end

function ToFortreeCity:PetalburgCityGym()
	if  Game.inRectangle(68,101,79,109) then
		return moveToCell(74,109)
	elseif Game.inRectangle(36,82,47,90) then
		return moveToCell(38,90)
	elseif Game.inRectangle(35,55,47,63) then
		return moveToCell(44,63)
	elseif Game.inRectangle(35,28,46,36) then
		return moveToCell(37,36)
	elseif Game.inRectangle(18,4,29,11) then 
		return moveToCell(27,11)
	end
end

function ToFortreeCity:PetalburgCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Petalburg City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Petalburg City")
	else
		return PathFinder.moveTo(getMapName(), "Route 102")
	end
end

function ToFortreeCity:Route102()
	if Game.tryTeachMove("Surf", "HM03 - Surf") then
		return PathFinder.moveTo(getMapName(), "Oldale Town")
	end
end

function ToFortreeCity:OldaleTown()
	return PathFinder.moveTo(getMapName(), "Route 103")
end

function ToFortreeCity:Route103()
	 return PathFinder.moveTo(getMapName(), "Route 110")
end

function ToFortreeCity:Route110()
	return PathFinder.moveTo(getMapName(), "Mauville City Stop House 1")
end

function ToFortreeCity:MauvilleCityStopHouse1()
	return PathFinder.moveTo(getMapName(), "Mauville City")
end

function ToFortreeCity:MauvilleCity()
	return PathFinder.moveTo(getMapName(), "Mauville City Stop House 4")
end


function ToFortreeCity:MauvilleCityStopHouse4()
	return PathFinder.moveTo(getMapName(), "Route 118")
end

function ToFortreeCity:Route118()
	return PathFinder.moveTo(getMapName(), "Route 119B")
end

function ToFortreeCity:Route119B()
	return PathFinder.moveTo(getMapName(), "Route 119A")
end

function ToFortreeCity:Route119A()
	
	if self:needPokecenter() then 
		return PathFinder.moveTo(getMapName(), "Weather Institute 1F")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	elseif isNpcOnCell (18,43) then 
		return PathFinder.moveTo(getMapName(), "Weather Institute 1F") 
	elseif isNpcOnCell(41,30) then 
		return talkToNpcOnCell(41,30)
	else
		return PathFinder.moveTo(getMapName(), "Fortree City")
	end
end

function ToFortreeCity:WeatherInstitute1F()
	if not Game.isTeamFullyHealed() then
		return talkToNpcOnCell(18,24)
	elseif not self:isTrainingOver()  then
		return PathFinder.moveTo(getMapName(), "Route 119A")
	elseif  isNpcOnCell(32,9) then
		return talkToNpcOnCell(32,9)
	elseif isNpcOnCell(24,13) then
		return PathFinder.moveTo(getMapName(), "Weather Institute 2F")
	else
		return PathFinder.moveTo(getMapName(), "Route 119A")
	end
end

function ToFortreeCity:WeatherInstitute2F()
	if isNpcOnCell(16,19) then
		return talkToNpcOnCell(16,19)
	else
		return PathFinder.moveTo(getMapName(), "Weather Institute 1F")
	end
end


function ToFortreeCity:Route120()
	if isNpcOnCell(45,13) then 
		return talkToNpcOnCell(45,13)
	end
end

function ToFortreeCity:FortreeCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fortree City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Fortree City")
	else
		return PathFinder.moveTo(getMapName(), "Route 120")
	end
end

function ToFortreeCity:PokecenterFortreeCity()
	self:pokecenter("Fortree City")
end

return ToFortreeCity