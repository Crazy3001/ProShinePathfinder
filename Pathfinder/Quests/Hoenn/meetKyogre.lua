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

local name		  = 'meetKyogre'
local description = ' Learn Dive, dive to Seafloor Cavern and defeat admin Matt'
local level = 63
local diveID = nil 

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local meetKyogre = Quest:new()

function meetKyogre:new()
	o = Quest.new(meetKyogre, name, description, level, dialogs)
	o.pokemonId = 1

	return o
end

function meetKyogre:isDoable()
	return self:hasMap() and  hasItem("Blue Orb") and hasItem("Mind Badge")
end

function meetKyogre:isDone()
	return not hasItem("Blue Orb")
end

function meetKyogre:MossdeepGym()
	if Game.inRectangle(51,48,58,65) then
		return moveToCell(54,65)
	elseif Game.inRectangle(6,3,18,11) then 
		return moveToCell(7,3)
	elseif Game.inRectangle(4,27,16,34) then
		return moveToCell(10,34)
	elseif Game.inRectangle(47,6,56,12) then 
		return moveToCell(56,6)
	elseif Game.inRectangle(29,59,35,68) then 
		return moveToCell(29,60)
	elseif Game.inRectangle(4,52,18,67) or Game.inRectangle(2,60,20,67) then
		return PathFinder.moveTo(getMapName(), "Mossdeep City")
	end
end

function meetKyogre:MossdeepCity()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Mossdeep City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Mossdeep City")
	elseif isNpcOnCell(83,22) then 
		return talkToNpcOnCell(83,22)
	elseif not hasItem("HM06 - Dive") then 
		return PathFinder.moveTo(getMapName(), "Mossdeep City Space Center 1F")
	elseif not self:isTrainingOver() then
		return moveToRectangle(4,8,12,19)
	elseif Game.tryTeachMove("Dive", "HM06 - Dive") then
		return PathFinder.moveTo(getMapName(), "Route 127")
	end
end

function meetKyogre:MossdeepCitySpaceCenter1F()
	if not hasItem("HM06 - Dive") then
		return talkToNpcOnCell(12,6)
	else
		return PathFinder.moveTo(getMapName(), "Mossdeep City")
	end
end

function meetKyogre:PokecenterMossdeepCity()
	self:pokecenter("Mossdeep City")
end

function meetKyogre:Route127()
	if Game.tryTeachMove("Dive", "HM06 - Dive") then
		for i=1, getTeamSize(), 1 do
			if hasMove(i, "Dive") then
				pushDialogAnswer(1)
				pushDialogAnswer(i)
				return moveToCell(37,25)
			end
		end
	end
end


function meetKyogre:Route127Underwater()
	return PathFinder.moveTo(getMapName(), "Route 128 Underwater")
end

function meetKyogre:Route128Underwater()
	return PathFinder.moveTo(getMapName(), "Secret Underwater Cavern")
end

function meetKyogre:SecretUnderwaterCavern()
	if Game.tryTeachMove("Dive", "HM06 - Dive") then
		for i=1, 6, 1 do
			if hasMove(i, "Dive") then
				pushDialogAnswer(1)
				pushDialogAnswer(i)
				return moveToCell(8,6)
			end
		end
	end
end

function meetKyogre:SeafloorCavernEntrance()
	return PathFinder.moveTo(getMapName(), "Seafloor Cavern R1")
end

function meetKyogre:SeafloorCavernR1()
	return PathFinder.moveTo(getMapName(), "Seafloor Cavern R2")
end

function meetKyogre:SeafloorCavernR2()
	return PathFinder.moveTo(getMapName(), "Seafloor Cavern R3")
end

function meetKyogre:SeafloorCavernR3()
	return PathFinder.moveTo(getMapName(), "Seafloor Cavern R4")
end

function meetKyogre:SeafloorCavernR4()
	if Game.tryTeachMove("Rock Smash", "TM114") then
		return PathFinder.moveTo(getMapName(), "Seafloor Cavern R6")
	end
end

function meetKyogre:SeafloorCavernR6()
	if Game.inRectangle(4,19,4,19) then
		return moveToCell(5,19)
	elseif Game.inRectangle(5,19,5,19) then
		return moveToCell(6,19)
	elseif Game.inRectangle(6,19,6,19) then
		return moveToCell(7,19)
	elseif Game.inRectangle(7,19,7,19) then
		return moveToCell(7,18)
	elseif Game.inRectangle(7,18,7,18) then
		return moveToCell(8,18)
	elseif Game.inRectangle(8,18,8,18) then
		return moveToCell(9,18)
	elseif Game.inRectangle(9,18,9,18) then 
		return moveToCell(10,18)
	elseif Game.inRectangle(11,18,14,18) then
		return moveToCell(15,18)
	elseif Game.inRectangle(19,12,19,12) then
		return moveToCell(20,12)
	elseif Game.inRectangle(19,8,19,8) then
		return moveToCell(19,7)
	elseif Game.inRectangle(11,8,11,8) then
		return moveToCell(11,7)
	elseif Game.inRectangle(3,3,8,7) then
		return PathFinder.moveTo(getMapName(), "Seafloor Cavern R7")
	end
end

function meetKyogre:SeafloorCavernR7()
	return PathFinder.moveTo(getMapName(), "Seafloor Cavern R8")
end

function meetKyogre:SeafloorCavernR8()
	return PathFinder.moveTo(getMapName(), "Seafloor Cavern R9")
end

function meetKyogre:SeafloorCavernR9()
	return talkToNpcOnCell(16,37)
end

return meetKyogre