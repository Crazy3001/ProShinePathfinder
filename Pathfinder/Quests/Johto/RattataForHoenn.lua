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

local name		  = 'Rattata for Hoenn'
local description = ' Catching and leveling Rattata at Mt.Silver, fighting Joey'
local level = 80

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local RattataForHoenn = Quest:new()

function templatequest:new()
	local o =  Quest.new(RattataForHoenn, name, description, level, dialogs)
	o.JoeyDefeated = False
	return o
end

function templatequest:isDoable()
	if self:hasMap() and not hasItem("Stone Badge") and hasItem("Rising Badge") then
		return true
	end
	return false
end

function templatequest:isDone()
	return self.JoeyDefeated
end

function templatequest:MapName()
	
end

function templatequest:MapName()
	
end

function templatequest:MapName()
	
end

function templatequest:MapName()
	
end

return templatequest