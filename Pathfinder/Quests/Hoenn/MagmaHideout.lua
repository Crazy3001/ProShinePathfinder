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

local name		  = 'Magma Hideout'
local description = ' Clear Magma Hideout'
local level = 60

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local MagmaHideOut = Quest:new()

function MagmaHideOut:new()
	return Quest.new(MagmaHideOut, name, description, level, dialogs)
end

function MagmaHideOut:isDoable()
	return self:hasMap() and hasItem("Blue Orb") and hasItem("Red Orb")
end

function MagmaHideOut:isDone()
	return not hasItem("Red Orb")
end

function MagmaHideOut:PokecenterLilycoveCity()
	self:pokecenter("Lillycove City")
end

function MagmaHideOut:LillycoveCity()
	return PathFinder.moveTo(getMapName(), "Route 121")
end

function MagmaHideOut:Route120()
	return PathFinder.moveTo(getMapName(), "Route 121")
end

function MagmaHideOut:Route121()
	return PathFinder.moveTo(getMapName(), "Route 122")
end

function MagmaHideOut:MtPyreSummit()
	return PathFinder.moveTo(getMapName(), "Mt. Pyre Exterior")
end

function MagmaHideOut:MtPyreExterior()
	return PathFinder.moveTo(getMapName(), "Mt. Pyre 3F")
end

function MagmaHideOut:MtPyre3F()
	return PathFinder.moveTo(getMapName(), "Mt. Pyre 2F")
end

function MagmaHideOut:MtPyre2F()
	return PathFinder.moveTo(getMapName(), "Mt. Pyre 1F")
end

function MagmaHideOut:MtPyre1F()
	return PathFinder.moveTo(getMapName(), "Route 122")
end

function MagmaHideOut:Route122()
	return PathFinder.moveTo(getMapName(), "Route 123")
end

function MagmaHideOut:Route123()
	return PathFinder.moveTo(getMapName(), "Route 118")
end

function MagmaHideOut:Route118()
	return PathFinder.moveTo(getMapName(), "Mauville City Stop House 4")
end

function MagmaHideOut:MauvilleCityStopHouse4()
	return PathFinder.moveTo(getMapName(), "Mauville City")
end

function MagmaHideOut:MauvilleCity()
	if  self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Mauville City")
	else
		return PathFinder.moveTo(getMapName(), "Mauville City Stop House 3")
	end
end

function MagmaHideOut:PokecenterMauvilleCity()
	self:pokecenter("Mauville City")
end

function MagmaHideOut:MauvilleCityStopHouse3()
	return PathFinder.moveTo(getMapName(), "Route 111 South")
end

function MagmaHideOut:Route111South()
	return PathFinder.moveTo(getMapName(), "Route 112")
end

function MagmaHideOut:Route112()
	return PathFinder.moveTo(getMapName(), "Cable Car Station 1")
end

function MagmaHideOut:CableCarStation1()
	return talkToNpcOnCell(10,6)
end

function MagmaHideOut:CableCarStation2()
	return PathFinder.moveTo(getMapName(), "Mt. Chimney")
end

function MagmaHideOut:MtChimney()
	return PathFinder.moveTo(getMapName(), "Jagged Pass")
end

function MagmaHideOut:JaggedPass()
	return talkToNpcOnCell(30,35)
end

function MagmaHideOut:MagmaHideout1F()
	return PathFinder.moveTo(getMapName(), "Magma Hideout 2F1R")
end

function MagmaHideOut:MagmaHideout2F1R()
	return PathFinder.moveTo(getMapName(), "Magma Hideout 3F1R")
end

function MagmaHideOut:MagmaHideout3F1R()
	return PathFinder.moveTo(getMapName(), "Magma Hideout 4F")
end

function MagmaHideOut:MagmaHideout4F()
	if isNpcOnCell(16,31) then
		return talkToNpcOnCell(16,31)
	else
		return PathFinder.moveTo(getMapName(), "Magma Hideout 3F3R")
	end
end

return MagmaHideOut