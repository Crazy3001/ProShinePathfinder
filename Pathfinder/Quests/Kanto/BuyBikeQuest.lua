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

local name		  = 'Exchange Voucher for the Bike'
local description = ' Cerulean City'
local level = 55

local BuyBikeQuest = Quest:new()

function BuyBikeQuest:new()
	return Quest.new(BuyBikeQuest, name, description, level, dialogs)
end

function BuyBikeQuest:isDoable()
	if self:hasMap() and hasItem("Soul Badge") and not hasItem("Volcano Badge")then
		return true
	end
	return false
end

function BuyBikeQuest:isDone()
	if getMapName() == "Route 5 Stop House" or getMapName() == "Pokecenter Saffron" then --Fix Blackout
		return true
	end
	return false
end

function BuyBikeQuest:Route5()
	if hasItem("Bike Voucher") then
		return moveToCell(13,0)
	else
		return PathFinder.moveTo(getMapName(), "Route 5 Stop House")
	end
end

function BuyBikeQuest:CeruleanCity()
	if hasItem("Bike Voucher") then
		return PathFinder.moveTo(getMapName(), "Cerulean City Bike Shop")
	else
		return PathFinder.moveTo(getMapName(), "Route 5")
	end
end

function BuyBikeQuest:CeruleanCityBikeShop()
	if hasItem("Bike Voucher") then
		return talkToNpcOnCell(11,7)
	else
		return PathFinder.moveTo(getMapName(), "Cerulean City")
	end
end

return BuyBikeQuest