-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Melt


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local level = 50
local name		  = 'Feather Badge'
local description = " Level to " .. level .. " and clean Fortree Gym"

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local FeatherBadgeQuest = Quest:new()

function FeatherBadgeQuest:new()
	return Quest.new(FeatherBadgeQuest, name, description, level, dialogs)
end

function FeatherBadgeQuest:isDoable()
	return self:hasMap() and not hasItem("Feather Badge")
end

function FeatherBadgeQuest:isDone()
	return hasItem("Feather Badge")
end

function FeatherBadgeQuest:Route120()
    if self:isTrainingOver() or self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Fortree City" then
        return PathFinder.moveTo(getMapName(), "Fortree City")
    else
        return moveToWater()
    end
end

function FeatherBadgeQuest:FortreeCity()
    if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fortree City" then
        return PathFinder.moveTo(getMapName(), "Pokecenter Fortree City")
    elseif not self:isTrainingOver() then
        return PathFinder.moveTo(getMapName(), "Route 120")
    else
        return PathFinder.moveTo(getMapName(), "Fortree Gym")
    end
end

function FeatherBadgeQuest:PokecenterFortreeCity()
	self:pokecenter("Fortree City")
end

function FeatherBadgeQuest:FortreeGym()
	if isNpcOnCell(19,7) then
        return talkToNpcOnCell(19,7)
    end
end

return FeatherBadgeQuest