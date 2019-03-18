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

local name		  = 'Beat Deoxys'
local description = 'Will earn the 8th Badge and beat Deoxys on the moon.'
local level = 80
local deoxys = false
local dialogs = {
	goSky = Dialog:new({ 
		"He is currently at Sky Pillar"
	}),
	firstChamp = Dialog:new({ 
		"He is somewhere in this Gym..."
	})
}

local beatDeoxys = Quest:new()

function beatDeoxys:new()
	return Quest.new(beatDeoxys, name, description, level, dialogs)
end

function beatDeoxys:isDoable()
	return self:hasMap() and not hasItem("Blue Orb") and not  hasItem("Rain Badge")
end

function beatDeoxys:isDone()
	return hasItem("Rain Badge") and getMapName() == "Sootopolis City Gym B1F"
end

function beatDeoxys:Route128()
	if not dialogs.goSky.state then 
		return PathFinder.moveTo(getMapName(), "Route 127")
	else
		return PathFinder.moveTo(getMapName(), "Route 129")
	end
end

function beatDeoxys:PokecenterMossdeepCity()
	self:pokecenter("Mossdeep City")
end

function beatDeoxys:MossdeepCity()
	return PathFinder.moveTo(getMapName(), "Route 127")
end

function beatDeoxys:Route127()
	if not dialogs.goSky.state then
		return PathFinder.moveTo(getMapName(), "Route 126")
	else
		return PathFinder.moveTo(getMapName(), "Route 128")
	end
end

function beatDeoxys:Route126()
	if not dialogs.goSky.state and Game.tryTeachMove("Dive", "HM06 - Dive") then
		for i=1, getTeamSize(), 1 do
			if hasMove(i, "Dive") then
				pushDialogAnswer(1)
				pushDialogAnswer(i)
				return moveToCell(15,71)
			end
		end
	else
		return PathFinder.moveTo(getMapName(), "Route 127")
	end
end

function beatDeoxys:Route126Underwater()
	if isNpcOnCell(58,97) then 
		return talkToNpcOnCell(58,97)
	elseif not dialogs.goSky.state then 
		return PathFinder.moveTo(getMapName(), "Sootopolis City Underwater")
	elseif Game.tryTeachMove("Dive", "HM06 - Dive") then
		for i=1, getTeamSize(), 1 do
			if hasMove(i, "Dive") then
				pushDialogAnswer(1)
				pushDialogAnswer(i)
				return moveToCell(15,71)
			end
		end
	end
end

function beatDeoxys:SootopolisCityUnderwater()
	if dialogs.goSky.state then 
		return PathFinder.moveTo(getMapName(), "Route 126 Underwater")
	elseif Game.tryTeachMove("Dive", "HM06 - Dive") then
		for i=1, getTeamSize(), 1 do
			if hasMove(i, "Dive") then
				pushDialogAnswer(1)
				pushDialogAnswer(i)
				return moveToCell(17,11)
			end
		end
	end
end

function beatDeoxys:SootopolisCity()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Sootopolis City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Sootopolis City")
	elseif isNpcOnCell(48,68) and not dialogs.goSky.state then 
		return talkToNpcOnCell(50,17)
	elseif dialogs.goSky.state and Game.tryTeachMove("Dive", "HM06 - Dive") then
		for i=1, getTeamSize(), 1 do
			if hasMove(i, "Dive") then
				pushDialogAnswer(1)
				pushDialogAnswer(i)
				return moveToCell(50,91)
			end
		end
	elseif not isNpcOnCell(48,68) and not hasItem("Rain Badge") then
		return PathFinder.moveTo(getMapName(), "Sootopolis City Gym 1F")
	end
end

function beatDeoxys:Route129()
	return PathFinder.moveTo(getMapName(), "Route 130")
end

function beatDeoxys:Route130()
	return PathFinder.moveTo(getMapName(), "Route 131")
end

function beatDeoxys:Route131()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Pacifidlog Town" then
		return PathFinder.moveTo(getMapName(), "Pacifidlog Town")
	else
		return PathFinder.moveTo(getMapName(), "Sky Pillar Entrance")
	end
end

function beatDeoxys:PacifidlogTown()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Pacifidlog Town" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Pacifidlog Town")
	else
		return PathFinder.moveTo(getMapName(), "Route 131")
	end
end

function beatDeoxys:SkyPillarEntrance()
	if not Game.inRectangle(25,7,36,26) then
		if self:needPokecenter() then 
			return PathFinder.moveTo(getMapName(), "Route 131")
		else
			return PathFinder.moveTo(getMapName(), "Sky Pillar Entrance Cave 1F")
		end
	else 
		 if isNpcOnCell(27,7) then	
			return talkToNpcOnCell(27,7)
		 elseif self:needPokecenter() then
			return PathFinder.moveTo(getMapName(), "Sky Pillar Entrance Cave 1F")
		else
			return PathFinder.moveTo(getMapName(), "Sky Pillar 1F")
		 end
	end
		
end

function beatDeoxys:SkyPillar1F()
	if self:needPokecenter() then	
		return PathFinder.moveTo(getMapName(), "Sky Pillar Entrance")
	else
		-- return moveToRectangle(3,6,11,12)
		return moveToCell(13,5)
	end
end

function beatDeoxys:SkyPillarEntranceCave1F()
	if self:needPokecenter() then 
		return moveToCell(7,17)
	else
		return moveToCell(17,6)
	end
end

function beatDeoxys:PacifidlogTown()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Pacifidlog Town" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Pacifidlog Town")
	else
		return PathFinder.moveTo(getMapName(), "Route 131")
	end
end


function beatDeoxys:PokecenterPacifidlogTown()
	return self:pokecenter("Pacifidlog Town")
end


function beatDeoxys:PokecenterSootopolisCity()
	return self:pokecenter("Sootopolis City")
end


function beatDeoxys:SkyPillar2F()
	if self:needPokecenter() then	
		return PathFinder.moveTo(getMapName(), "Sky Pillar 1F")
	else
		return moveToCell(7,5)
	end
end

function beatDeoxys:SkyPillar3F()
	if self:needPokecenter() then	
		return PathFinder.moveTo(getMapName(), "Sky Pillar 2F")
	else
		return moveToCell(4,12)
	end
end

function beatDeoxys:SkyPillar4F()
	if self:needPokecenter() then
		return PathFinder.moveTo(getMapName(), "Sky Pillar 3F")
	else
		return moveToCell(8,12)
	end
end

function beatDeoxys:SkyPillar5F()
	if self:needPokecenter() then
		return PathFinder.moveTo(getMapName(), "Sky Pillar 4F")
	if not self:isTrainingOver() then
		moveToRectangle(2,5,12,5)
	else
		return moveToCell(13,12)
	end
end

function beatDeoxys:SkyPillar6F()
	if self:needPokecenter() then
		return PathFinder.moveTo(getMapName(), "Sky Pillar 5F")
	else
		return talkToNpcOnCell(25,19)
	end
end

function beatDeoxys:Moon()
	if Game.inRectangle(25,48,8,33) then
		return moveToCell(7,40)
	elseif Game.inRectangle(8,31,26,11) then
		return moveToCell(15,10)
	elseif Game.inRectangle(39,11,52,41) and deoxys then
		return moveToCell(53,19)
	elseif Game.inRectangle(39,11,52,41) and not deoxys then
		return moveToCell(53,40)
	elseif isNpcOnCell(30,28) then
		return talkToNpcOnCell(30,28)
	else deoxys = true
		return PathFinder.moveTo(getMapName(), "Moon 2F")
		
	end
end

function beatDeoxys:Moon1F()
	if Game.inRectangle(4,24,9,45) or Game.inRectangle(3,31,11,33)  then
		return moveToCell(8,24)
	elseif Game.inRectangle(16,4,47,14) then
		return moveToCell(47,15)
	elseif Game.inRectangle(57,43,61,47) then
		return moveToCell(59,45)
	elseif Game.inRectangle(5,3,8,3) then
		return moveToCell(6,8)
	elseif Game.inRectangle(57,23,61,25) then
		return moveToCell(59,23)
	end
end

function beatDeoxys:MoonB1F()
	if Game.inRectangle(55,15,60,23) then
		dialogs.goSky.state = false
		return talkToNpcOnCell(60,23)
	elseif not deoxys then
		return moveToCell(32,19)
	else
		return moveToCell(5,32)
	end
end

function beatDeoxys:Moon2F()
	if not deoxys then
		if Game.inRectangle(6,3,6,3) then 
			return moveToCell(5,3)
		elseif Game.inRectangle(5,3,5,3) then 
			return moveToCell(5,4)
		elseif Game.inRectangle(5,4,5,4) then 
			return moveToCell(5,5)
		else
			return PathFinder.moveTo(getMapName(), "Moon")
		end
	else
		return moveToCell(6,4)
	end
end

function beatDeoxys:SootopolisCityGym1F()
	if Game.inRectangle(22,38,22,38)  then
		return moveToCell(22,47)
	elseif Game.inRectangle(21,38,23,47) then
		return moveToCell(22,38)
	elseif Game.inRectangle(22,38,22,38)  then
		return moveToCell(22,47)
	elseif Game.inRectangle(19,27,25,34) then
		return moveToCell(22,29)
	elseif Game.inRectangle(17,5,25,23) and not dialogs.firstChamp.state then
		return talkToNpcOnCell(22,6)
	elseif Game.inRectangle(17,4,27,16) and dialogs.firstChamp.state then
		return moveToCell(22,17)
	end
end

function beatDeoxys:SootopolisCityGymB1F()
	if Game.inRectangle(10,34,15,42) then
		return moveToCell(13,34)
	elseif Game.inRectangle(13,21,22,28) then
		return moveToCell(13,21)
	elseif Game.inRectangle(10,5,16,14) then
		return talkToNpcOnCell(13,6)
	end
end

function beatDeoxys:isCustomBattle()
	return getOpponentName() == "Deoxys" and Game.hasPokemonWithMove("Sucker Punch")
end

function beatDeoxys:customBattle() -- Custom battle for deoxys using Sucker Punch
	log("CUSTOM BATTLE")
	local ppItem = hasItem("Elexir") or hasItem("Max Elexir") or nil
	local sweepMove = "Sucker Punch"
	local active = getActivePokemonNumber()
	local sweeper = Game.getPokemonNumberWithMove(sweepMove)
	local sweepMovePP = getRemainingPowerPoints(sweeper, sweepMove)
	local activeHP = getPokemonHealth(active)
	local sweeperHP = getPokemonHealth(sweeper)


	if activeHP == 0 then
		if active == sweeper then
			log("active sweeper fainted, sending anyone")
			return sendAnyPokemon()
		elseif sweepMovePP > 0 and sweeperHP > 0 then
			log("active fainted, sweeper ready, attempting to send sweeper")
			return sendPokemon(sweeper)
		else -- Attempt to switch on any Pokemon alive expet sweeper.
			for i=1, getTeamSize(), 1 do
				if getPokemonHealth(i) > 0 and i ~= sweeper then
					if sendPokemon(i) then
						return true
					end
				end	
			end
			log("Switching to " .. sweeper .. " as it is the last Pokemon alive.") 
		end
	elseif active == sweeper then
		log("active is sweeper, sending attack request, using priority for move : " .. sweepMove)
		return useMove(sweepMove) or attack() or Game.useAnyMove()
	else -- active pokemon alive
		log("active alive and not sweeper")
		if sweepMovePP == 0 then
			if not ppItem then
				log(sweepMove .. " has no more PP and no items available to refill.")
				return attack() or Game.useAnyMove()
			else -- refill PP
				log("attempting to refill PP") -- Need API function to handle 2step use Item
				return useItemOnPokemon(ppItem, sweeper)
			end
		elseif sweeperHP == 0 then
			log("attempting to revive sweeper")
			if useItemOnPokemon("Revive", sweeper) then
				return true
			else
				log("No Revive for pokemon : " .. sweeper)
				return attack() or Game.useAnyMove()				
			end
		else -- if sweeper is ready and pokemon active is not fainted
			return attack() or Game.useAnyMove()
		end
	end
end

return beatDeoxys