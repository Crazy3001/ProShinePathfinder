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

local name		  = 'Saffron Guard'
local description = 'Route 15 to Saffron City'
local level = 55
local dialogs = {
	questDittoAccept = Dialog:new({ 
        "I have a confession to make, ever since",
        "Have you found a Ditto yet? If so, show it to me!"
	})
}
local SaffronGuardQuest = Quest:new()
function SaffronGuardQuest:new()
	local o = Quest.new(SaffronGuardQuest, name, description, level, dialogs)
	o.BUY_BIKE = true
	return o
end
function SaffronGuardQuest:isDoable()
	if self:hasMap() and not hasItem("Marsh Badge") then
		return true
	end
	return false
end

function SaffronGuardQuest:isDone()
	if getMapName() == "Saffron City" or getMapName() == "Pokecenter Fuchsia" then --Fix Blackout
		return true
	end
	return false
end

function SaffronGuardQuest:Route15()
	return PathFinder.moveTo(getMapName(), "Route 14")
end

function SaffronGuardQuest:Route14()
	return PathFinder.moveTo(getMapName(), "Route 13")
end

function SaffronGuardQuest:Route13()
	return PathFinder.moveTo(getMapName(), "Route 12")
end

function SaffronGuardQuest:Route12()
	return PathFinder.moveTo(getMapName(), "Route 11 Stop House")
end

function SaffronGuardQuest:Route11StopHouse()
	return PathFinder.moveTo(getMapName(), "Route 11")
end

function SaffronGuardQuest:Route11()
	return PathFinder.moveTo(getMapName(), "Vermilion City")
end

function SaffronGuardQuest:VermilionPokemart()
	self:pokemart("Vermilion City")
end

function SaffronGuardQuest:VermilionCity()
	if not self.dialogs.questDittoAccept.state and self.BUY_BIKE and getMoney() > 75000 and not hasItem("Bike Voucher") and not hasItem("Bicycle") then
		return moveToCell(32,21)
	elseif self:needPokemart() and getMoney() > 200 then
		return PathFinder.moveTo(getMapName(), "Vermilion Pokemart")
	elseif not hasItem("Old Rod") then
		return PathFinder.moveTo(getMapName(), "Fisherman House - Vermilion")
	else
		return PathFinder.moveTo(getMapName(), "Route 6")
	end
end

function SaffronGuardQuest:VermilionHouse2Bottom()
    if not self.dialogs.questDittoAccept.state and self.BUY_BIKE and getMoney() > 75000 and not hasItem("Bike Voucher") and not hasItem("Bicycle") then
        return talkToNpcOnCell(6,6)
    end
    return PathFinder.moveTo(getMapName(), "Vermilion City")
end

function SaffronGuardQuest:FishermanHouseVermilion()
	if not hasItem("Old Rod") then
		return talkToNpcOnCell(0,6)
	else
		return PathFinder.moveTo(getMapName(), "Vermilion City")
	end
end

function SaffronGuardQuest:Route6()
	return PathFinder.moveTo(getMapName(), "Route 6 Stop House")
end

function SaffronGuardQuest:Route6StopHouse()
	return PathFinder.moveTo(getMapName(), "Saffron City")
end

return SaffronGuardQuest