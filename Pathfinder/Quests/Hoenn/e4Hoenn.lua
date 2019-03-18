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

local name		  = 'e4Hoenn'
local description = ' Hoenn Elite 4'
local level = 80

local dialogs = {
	sidney = Dialog:new({ 
		"It looks like You are stronger than I expected."
	}),
	glacia = Dialog:new({ 
		"You and your Pokemon... How hot your spirits burn!"
	}),
	drake = Dialog:new({ 
		"You indeed have what is needed as a Pokemon Trainer."
	}),
	phoebe = Dialog:new({ 
		"There's definitely a bond between you and your Pokemons too, I didn't recognize that fact."
	}),
	steven = Dialog:new({ 
		"Now you may go on and continue your journey, champ. I wish you luck!"
	})
}

local e4Hoenn = Quest:new()

function e4Hoenn:new()
	local o = Quest.new(e4Hoenn, name, description, level, dialogs)
	o.qnt_revive = 32
	o.qnt_hyperpot = 32
	return o
end

function e4Hoenn:isDoable()
	if self:hasMap() and  hasItem("Rain Badge") then
		return true
	end
	return false
end

function e4Hoenn:isDone()
	if hasItem("xxx") and getMapName() == "xxx" then
		return true
	else
		return false
	end
end



function e4Hoenn:SootopolisCityGymB1F()
	moveToCell(13,41)
end

function e4Hoenn:SootopolisCityGym1F()
	if Game.inRectangle(22,39,22,39) then
		moveToCell(21,39)
	else PathFinder.moveTo(getMapName(), "Sootopolis City")
	end
end

function e4Hoenn:SootopolisCity()
	local diveId = Game.getPokemonNumberWithMove("Dive")
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Sootopolis City" then
		PathFinder.moveTo(getMapName(), "Pokecenter Sootopolis City")
	elseif diveId > 0 then
		pushDialogAnswer(1)
		pushDialogAnswer(diveId)
		return moveToCell(50,91)
	end
end

function e4Hoenn:SootopolisCityUnderwater()
	PathFinder.moveTo(getMapName(), "Route 126 Underwater")
end

function e4Hoenn:Route126Underwater()
	local diveId = Game.getPokemonNumberWithMove("Dive")
	if diveId > 0 then
		pushDialogAnswer(1)
		pushDialogAnswer(6)
		moveToCell(15,71)
	end
end

function e4Hoenn:Route126()
	PathFinder.moveTo(getMapName(), "Route 127")
end

function e4Hoenn:Route127()
	PathFinder.moveTo(getMapName(), "Route 128")
end

function e4Hoenn:Route128()
	PathFinder.moveTo(getMapName(), "Ever Grande City")
end

function e4Hoenn:EverGrandeCity()
	if Game.inRectangle(0,59,51,114) or Game.inRectangle(26,57,35,76) then
		if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Ever Grande City" then
			PathFinder.moveTo(getMapName(), "Pokecenter Ever Grande City")
		elseif isNpcOnCell(27,57) then
			talkToNpcOnCell(27,57)
		else PathFinder.moveTo(getMapName(), "Victory Road Hoenn 1F")
		end
	elseif isNpcOnCell(30,35) then
		talkToNpcOnCell(30,35)
	else PathFinder.moveTo(getMapName(), "Pokemon League Hoenn")
	end
end

function e4Hoenn:PokecenterEverGrandeCity()
	return self:pokecenter("Ever Grande City")
end

function e4Hoenn:VictoryRoadHoenn1F()
	if Game.inRectangle(4,16,24,54) then
		moveToCell(9,17)
	else PathFinder.moveTo(getMapName(), "Ever Grande City")
	end
end

function e4Hoenn:VictoryRoadHoennB1F()
	moveToCell(46,7)
end

function e4Hoenn:PokemonLeagueHoenn()
	if self:needPokecenter() or not Game.isTeamFullyHealed() then
		return talkToNpcOnCell(4,22)
	elseif getItemQuantity("Revive") < self.qnt_revive or getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
		if not isShopOpen() then
			return talkToNpcOnCell(16,22)
		else
			if getItemQuantity("Revive") < self.qnt_revive then
				return buyItem("Revive", (self.qnt_revive - getItemQuantity("Revive")))
			end
			if getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
				return buyItem("Hyper Potion", (self.qnt_hyperpot - getItemQuantity("Hyper Potion")))
			end
		end
	--elseif not self.isTeamManaged() then -- NEED PC LIB FIX
		-- manage team 
	else
		return moveToCell(10,3)
	end
		
end

function e4Hoenn:PokecenterSootopolisCity()
	return self:pokecenter("Sootopolis City")
end

function e4Hoenn:EliteFourSidneyRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.sidney.state then
		talkToNpcOnCell(18,17) 
	else
		dialogs.sidney.state = false
		return moveToCell(18,3) 
	end
end

function e4Hoenn:EliteFourPhoebeRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.phoebe.state then
		talkToNpcOnCell(17,22) 
	else
		dialogs.phoebe.state = false
		return moveToCell(17,12) 
	end
end

function e4Hoenn:EliteFourGlaciaRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.glacia.state then
		talkToNpcOnCell(15,16) 
	else
		dialogs.glacia.state = false
		return moveToCell(15,3) 
	end
end

function e4Hoenn:EliteFourDrakeRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.drake.state then
		talkToNpcOnCell(17,16) 
	else
		dialogs.drake.state = false
		return moveToCell(17,2) 
	end
end

function e4Hoenn:EliteFourChampionRoomHoenn()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.steven.state then
		talkToNpcOnCell(6,16) 
	else
		return talkToNpcOnCell(6,4)
	end
end


function e4Hoenn:useReviveItems() --Return false if team don't need heal
	if not hasItem("Revive") or not hasItem("Hyper Potion") then
		return false
	end
	for pokemonId=1, getTeamSize(), 1 do
		if getPokemonHealth(pokemonId) == 0 then
			return useItemOnPokemon("Revive", pokemonId)
		end
		if getPokemonHealthPercent(pokemonId) < 70 then
			return useItemOnPokemon("Hyper Potion", pokemonId)
		end		
	end
	return false
end


return e4Hoenn