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

local name		  = 'Silph Co'
local description = 'Rocket Team Quest'
local level = 60

local dialogs = {
	silphCoDone = Dialog:new({ 
		"saving this building"
	})
}

local SilphCoQuest = Quest:new()

function SilphCoQuest:new()
	return Quest.new(SilphCoQuest, name, description, level, dialogs)
end

function SilphCoQuest:isDoable()
	if self:hasMap() and not hasItem("Volcano Badge") then
		return true
	end
	return false
end

function SilphCoQuest:isDone()
    return dialogs.silphCoDone.state
end
function SilphCoQuest:PokecenterCeladon()
    if self:needPokecenter() then
        return usePokecenter()
    else
        return moveToRectangle(8, 22, 9, 22)
    end
end
function SilphCoQuest:Route16()
    if not self:isTrainingOver() then
        if self:needPokecenter() then
            return moveToRectangle(90, 19, 90, 20)
        else
            return moveToGrass()
        end
    else
        return moveToRectangle(90, 19, 90, 20)
    end
end
function SilphCoQuest:CeladonCity()
    if not self:isTrainingOver() then
        if self:needPokecenter() then
            return moveToCell(52, 19)
        else
            return moveToRectangle(0, 41, 0, 43) -- Route 16_B
        end
    else
        return moveToRectangle(71, 23, 71, 25) -- Route 7
    end
end
function SilphCoQuest:Route7()
    if not self:isTrainingOver() then
        return moveToRectangle(0, 23, 0, 25) -- Celadon City
    else
        return moveToRectangle(21, 24, 21, 25) -- Route 7 Stop House
    end
end
function SilphCoQuest:Route7StopHouse()
    if not self:isTrainingOver() then
        return moveToRectangle(0, 6, 0, 7) -- Route 7
    else
        return moveToRectangle(10, 6, 10, 7) -- Saffron City
    end
end
function SilphCoQuest:SaffronCity()
    if not self:isTrainingOver() then
        return moveToRectangle(5, 38, 5, 39) -- Route 7
    else
        if needPokeCenter() then
            return moveToCell(19, 45)
        else
            return moveToRectangle(33, 36, 34, 36) -- Silph Co 1F
        end
    end
end
function PokecenterSaffron()
    if self:needPokecenter() then
        return usePokecenter()
    else
        return moveToRectangle(8, 22, 9, 22) -- Saffron City
    end
end
function SilphCoQuest:SilphCo1F()
    if not self:isTrainingOver() then
        return PathFinder.moveTo(getMapName(), "Route 16_B")
    end
	if (isNpcOnCell(19,7) and isNpcOnCell(19,7)) or dialogs.silphCoDone.state then
		return PathFinder.moveTo(getMapName(), "Saffron City")
	else
		return PathFinder.moveTo(getMapName(), "Silph Co 2F")
	end
end

function SilphCoQuest:SilphCo2F()
	if not dialogs.silphCoDone.state then
		return PathFinder.moveTo(getMapName(), "Silph Co 3F")
	else
		return PathFinder.moveTo(getMapName(), "Silph Co 1F")
	end
end

function SilphCoQuest:SilphCo3F()
	if not dialogs.silphCoDone.state then
		return moveToCell(16,18) --Silph Co 7F
	else
		if Game.inRectangle(16,15,16,17) then --Fixed moving on TPCell
			return moveToCell(18,14) 
		else
			return moveToCell(29,5) --Silph Co 2F
		end
	end
end

function SilphCoQuest:SilphCo7F()
	if not dialogs.silphCoDone.state then
		return moveToCell(6,11) --Silph Co 11F
	else
		return moveToCell(6,6) --Silph Co 3F
	end
end

function SilphCoQuest:SilphCo11F()
	if isNpcOnCell(3,13) then
		return talkToNpcOnCell(3,13)
	elseif isNpcOnCell(6,15) then
		return talkToNpcOnCell(6,15)
	elseif not dialogs.silphCoDone.state then
		return talkToNpcOnCell(9,11)
	else
		return moveToCell(3,7) --Silph Co 7F
	end
end

return SilphCoQuest