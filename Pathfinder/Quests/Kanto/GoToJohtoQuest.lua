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

local name		  = 'Start Johto Region'
local description = ' Route 26 to Bark Town'
local level = 95

local GoToJohtoQuest = Quest:new()

function GoToJohtoQuest:new()
	return Quest.new(GoToJohtoQuest, name, description, level)
end

function GoToJohtoQuest:isDoable()
	if self:hasMap() and not hasItem("Zephyr Badge") then
		return true
	end
	return false
end

function GoToJohtoQuest:isDone()
	if getMapName() == "New Bark Town" or getMapName() == "Indigo Plateau Center" or getMapName() == "Pokecenter Viridian" then
		return true
	end
	return false
end

function GoToJohtoQuest:Route26()
	return PathFinder.moveTo(getMapName(), "Route 27")
end

function GoToJohtoQuest:Route27()
	if Game.tryTeachMove("Surf","HM03 - Surf") == true then
		if Game.inRectangle(63,6,217,38) then
			return moveToCell(74,14)
		elseif Game.getPokemonIdWithItem("Leftovers") > 0 then
			return takeItemFromPokemon(Game.getPokemonIdWithItem("Leftovers")) --Take Leftovers from Pokemon, And start JohtoQuesting
		else
			return PathFinder.moveTo(getMapName(), "New Bark Town")
		end
	end
end

function GoToJohtoQuest:TohjoFalls()
	if isNpcOnCell(5,12) then
		return talkToNpcOnCell(5,12)
	else
		return moveToCell(23,32)
	end	
end

return GoToJohtoQuest