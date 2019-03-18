-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa] @Melt


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name		  = 'ToLavaridgeTown'
local description = ' Questing up to Heat Badge'
local level = 37

local dialogs = {
	rocket1 = Dialog:new({"Sure.. Just try to mess with us, we will make you regret!"
	}),
	rocket2 = Dialog:new({"You are pretty good, kid."
	}),
	rocket3 = Dialog:new({"You're strong, kid."
	}),
	rocket4 = Dialog:new({"I lost to a kid like you.."
	}),
	rocket5 = Dialog:new({"Maxie will crush you"
	}),
	shoji = Dialog:new({"please don't disturb me!"
	}),
	zane = Dialog:new({"still gathering the heat.."
	}),
	axle = Dialog:new({"get a headache..."
	}),
	cole = Dialog:new({"That battle cooled me off a bit."
	}),
	andy = Dialog:new({"but I cannot leave the Gym for now."
	}),
	sadie = Dialog:new({"My life is filled with battle"
	}),
	
}

local ToLavaridgeTown = Quest:new()

function ToLavaridgeTown:new()
	return Quest.new(ToLavaridgeTown, name, description, level, dialogs)
end

function ToLavaridgeTown:isDoable()
	return self:hasMap() and hasItem("Dynamo Badge") and not hasItem("Heat Badge")
end

function ToLavaridgeTown:isDone()
	return hasItem("Heat Badge")
end

function ToLavaridgeTown:MauvilleCityGym()
	return PathFinder.moveTo(getMapName(), "Mauville City")
end

function ToLavaridgeTown:MauvilleCity()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Mauville City")
	else
		return PathFinder.moveTo(getMapName(), "Mauville City Stop House 3")
	end
end

function ToLavaridgeTown:MauvilleCityStopHouse3()
	return PathFinder.moveTo(getMapName(), "Route 111 South")
	
end

function ToLavaridgeTown:Route111South()
	if isNpcOnCell(23,51) then
		return talkToNpcOnCell(23,51)
	else 
		return PathFinder.moveTo(getMapName(), "Route 112")
	end
	
end

function ToLavaridgeTown:Route112()
	if isNpcOnCell(29,34) and not  Game.inRectangle(11,0,48,18) then
		return PathFinder.moveTo(getMapName(), "Fiery Path")
	elseif Game.inRectangle(11,0,48,18) then 
		return PathFinder.moveTo(getMapName(), "Route 111 North")
	elseif Game.inRectangle(0,53,15,63) then 
		return PathFinder.moveTo(getMapName(), "Lavaridge Town")
	else 
		return PathFinder.moveTo(getMapName(), "Cable Car Station 1")
	end
end

function ToLavaridgeTown:CableCarStation1()
	return talkToNpcOnCell(10,6)
end

function ToLavaridgeTown:CableCarStation2()
	return PathFinder.moveTo(getMapName(), "Mt. Chimney")
end

function ToLavaridgeTown:FieryPath()
	return moveToCell(38,8)
end



function ToLavaridgeTown:Route111North()
	return PathFinder.moveTo(getMapName(), "Route 113")
end

function ToLavaridgeTown:Route113()
	--if not self:isTrainingOver() and not self:needPokecenter() and self.registeredPokecenter == "Pokecenter Fallarbor Town"  then
	--	return moveToGrass() -- Bad xp zone
	--else
	return PathFinder.moveTo(getMapName(), "Fallarbor Town")
	--end
end

function ToLavaridgeTown:FallarborTown()
	if self:needPokecenter() or not Game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fallarbor Town" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Fallarbor Town")
--	elseif not self:isTrainingOver() then -- Bad xp zone
--		return PathFinder.moveTo(getMapName(), "Route 113")
	else
		return PathFinder.moveTo(getMapName(), "Route 114")
	end
end

function ToLavaridgeTown:Route114()
	return PathFinder.moveTo(getMapName(), "Meteor falls 1F 1R")
end

function ToLavaridgeTown:Meteorfalls1F1R()
	if isNpcOnCell(31,23) then
		return talkToNpcOnCell(31,23)
	else
		return PathFinder.moveTo(getMapName(), "Route 115")
	end	
end		

function ToLavaridgeTown:Route115()
	return PathFinder.moveTo(getMapName(), "Rustboro City")
end

function ToLavaridgeTown:RustboroCity()
	return PathFinder.moveTo(getMapName(), "Route 116")
end

function ToLavaridgeTown:Route116()
	return PathFinder.moveTo(getMapName(), "Rusturf Tunnel")	
end

function ToLavaridgeTown:RusturfTunnel()
	if isNpcOnCell(25,9) then
		return talkToNpcOnCell(25,9)
	else
		return PathFinder.moveTo(getMapName(), "Verdanturf Town")
	end
end

function ToLavaridgeTown:MauvilleCityStopHouse2()
	return PathFinder.moveTo(getMapName(), "Mauville City")
end


function ToLavaridgeTown:VerdanturfTown()
	return PathFinder.moveTo(getMapName(), "Route 117")
end

function ToLavaridgeTown:Route117()
	return PathFinder.moveTo(getMapName(), "Mauville City Stop House 2")
end

function ToLavaridgeTown:PokecenterMauvilleCity()
	self:pokecenter("Mauville City")
end

function ToLavaridgeTown:PokecenterFallarborTown()
	self:pokecenter("Fallarbor Town")
end

function ToLavaridgeTown:MtChimney() -- rockets are very good xp source
	if not dialogs.rocket1.state then
		return talkToNpcOnCell(44,25)
	elseif not isTrainingOver() and not dialogs.rocket2.state then
		return talkToNpcOnCell(39,21)
	elseif not isTrainingOver() and not dialogs.rocket3.state then
		return talkToNpcOnCell(29,20)
	elseif not isTrainingOver() and not dialogs.rocket4.state then
		return talkToNpcOnCell(24,16)
	elseif not isTrainingOver() and not dialogs.rocket5.state then
		return talkToNpcOnCell(17,15)
	elseif isNpcOnCell(26,9) then -- maxie
		return talkToNpcOnCell(26,9)
	else
		return PathFinder.moveTo(getMapName(), "Jagged Pass")
	end
end

function ToLavaridgeTown:JaggedPass()
	return PathFinder.moveTo(getMapName(), "Route 112")
end

function ToLavaridgeTown:PokecenterLavaridgeTown()
	self:pokecenter("Lavaridge Town")
end

function ToLavaridgeTown:LavaridgeTown()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Lavaridge Town" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Lavaridge Town")
	else
		return PathFinder.moveTo(getMapName(), "Lavaridge Town Gym 1F")
	end
end

function ToLavaridgeTown:LavaridgeTownGym1F()
	if (Game.inRectangle(21,35,32,40) or  Game.inRectangle(21,25,23,40)) then
		if not self:needPokecenter() and not self:isTrainingOver() and not dialogs.shoji.state then
			return talkToNpcOnCell(21,30)
		else
			return moveToCell(21,26)
		end
	elseif Game.inRectangle(17,27,18,40) or Game.inRectangle(4,38,18,40) then
		log("m")
		return moveToCell(6,35)
	elseif Game.inRectangle(7,26,13,40) then
		if not self:needPokecenter() and not self:isTrainingOver() and not dialogs.axle.state then
			return talkToNpcOnCell(12,31)
		else
			return moveToCell(7,28)
		end
	elseif Game.inRectangle(7,4,30,13) and not Game.inRectangle(19,4,25,12) then
		return moveToCell(11,8)
	elseif Game.inRectangle(19,4,25,12) and not Game.inRectangle(25,5,25,5)    then
		if not self:needPokecenter() and not self:isTrainingOver() and not dialogs.andy.state then
			if getPlayerX() == 19 and getPlayerY() == 4 then -- dodge tp back
				return moveToCell(25,4)
			else
				return talkToNpcOnCell(19,9)
			end
		else
			return moveToCell(25,5)
		end
	elseif Game.inRectangle(19,4,25,12)   then
		return moveToCell(25,13)
	elseif Game.inRectangle(26,25,32,33) then 
		if self:needPokecenter() then
			return PathFinder.moveTo(getMapName(), "LavaridgeTown")
		else
			return talkToNpcOnCell(29,26)
		end	
	end	
end

function ToLavaridgeTown:LavaridgeTownGymB1F()
	if Game.inRectangle(17,27,18,40) or Game.inRectangle(4,38,18,40) or Game.inRectangle(4,32,10,40) then
		if not self:needPokecenter() and not self:isTrainingOver() and not dialogs.zane.state then
			return talkToNpcOnCell(16,38)
		else
			return moveToCell(6,35)
		end
	elseif Game.inRectangle(4,12,10,30) and not Game.inRectangle(10,29,10,29) then
		if not self:needPokecenter() and not self:isTrainingOver() and not dialogs.cole.state then
			return talkToNpcOnCell(5,22)
		else
			return moveToCell(10,29)
		end
	elseif Game.inRectangle(4,12,10,30)   then
		return moveToCell(4,13)
	elseif Game.inRectangle(7,0,26,11) then	
		return moveToCell(16,5)
	elseif Game.inRectangle(22,13,25,36) then
		if not self:needPokecenter() and not self:isTrainingOver() and not dialogs.sadie.state then
			return talkToNpcOnCell(25,31)
		else
			return moveToCell(25,33)
		end
	end
end

return ToLavaridgeTown