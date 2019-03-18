-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa] @Melt


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name		  = 'Elite 4 johto'
local description = 'Train Rattata, beat Elite Johto 4 and Joey'
local level = 80
local teamManaged = false

local dialogs = {
	leagueDefeated = Dialog:new({ 
		"I am already the Champ, don't need to go in there...",
		"I see you are Champion of Johto, you may continue.",
		"Congratulations, Johto Champion!"
	}),
	guardMtSilver = Dialog:new({
		"You are not ready to go to mount Silver yet!"
	}),
	leaderDone = Dialog:new({ 
		"You defeated me, you are amazing. I wish you good luck in the league..",
		"You defeated me, you are amazing.",
		"Good luck on facing the Champion!",
		"You defeated me, you are amazing.",
		"Go, your destiny waits you!"
	})
}

local Elite4Johto = Quest:new()

function Elite4Johto:new()
	local o = Quest.new(Elite4Johto, name, description, level, dialogs)
	o.pokemon = "Rattata"
	o.forceCaught = false
	o.qnt_revive = 32
	o.qnt_hyperpot = 32
	o.autoEvolve = false
	return o
end

function Elite4Johto:isDoable()
	return self:hasMap() and not hasItem("Stone Badge")
end

function Elite4Johto:isDone()
	return getMapName() == "Littleroot Town Truck"
end

function Elite4Johto:PokecenterBlackthorn()
	self:pokecenter("Blackthorn City")
	--if not teamManaged() then
		-- TManager.manage() -- Get e4 team ready from PC
	--end
end

function Elite4Johto:BlackthornCityGym()
	moveToCell(22,115)
end

function Elite4Johto:BlackthornCity()
	if Game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Blackthorn City" then
		return PathFinder.moveTo(getMapName(), "Pokecenter Blackthorn")
	else 
		return PathFinder.moveTo(getMapName(), "Route 45")
	end
end

function Elite4Johto:Route45()
	return PathFinder.moveTo(getMapName(), "Route 46")
end

function Elite4Johto:Route46()
	return PathFinder.moveTo(getMapName(), "Route 29 Stop House")
end

function Elite4Johto:Route29StopHouse()
	return PathFinder.moveTo(getMapName(), "Route 29")
end

function Elite4Johto:Route29()
	return PathFinder.moveTo(getMapName(), "New Bark Town")
end

function Elite4Johto:NewBarkTown()
	if dialogs.leagueDefeated.state and hasItem("Escape Rope") then
		return useItem("Escape Rope") -- tp Back to indigo Plateau center
	else
		return PathFinder.moveTo(getMapName(), "Route 27")
	end
end

function Elite4Johto:Route27()
	if Game.inRectangle(0,0,62,28) then 
		return PathFinder.moveTo(getMapName(), "Tohjo Falls")
	else 
		return PathFinder.moveTo(getMapName(), "Route 26")
	end
end

function Elite4Johto:TohjoFalls()
	return moveToCell(46,32)
end

function Elite4Johto:Route26()
	return PathFinder.moveTo(getMapName(), "Pokemon League Reception Gate")
end

function Elite4Johto:PokemonLeagueReceptionGate()
	if checkRattata() or not isNpcOnCell(2,11) then -- guards mt.silver
		return PathFinder.moveTo(getMapName(), "Victory Road Kanto 1F")
	elseif dialogs.guardMtSilver.state then 
		return PathFinder.moveTo(getMapName(), "Route 22")
	else
		return talkToNpcOnCell(2,11) -- guard MtSilver
	end		
end

function Elite4Johto:Route22()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Pokemon League Reception Gate")
	else 
		return PathFinder.moveTo(getMapName(), "Viridian City")
	end
end

function Elite4Johto:ViridianCity()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Route 22")
	else 
		return PathFinder.moveTo(getMapName(), "Route 1 Stop House")
	end
end

function Elite4Johto:Route1StopHouse()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Viridian City")
	else 
		return PathFinder.moveTo(getMapName(), "Route 1")
	end
end

function Elite4Johto:Route1()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Route 1 Stop House")
	else
		return PathFinder.moveTo(getMapName(), "Pallet Town")
	end
end

function Elite4Johto:PalletTown()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Route 1")
	else
		return PathFinder.moveTo(getMapName(), "Route 21")
	end
end

function Elite4Johto:Route21()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Pallet Town")
	else
		return PathFinder.moveTo(getMapName(), "Cinnabar Island")
	end
end

function Elite4Johto:CinnabarIsland()
	if checkRattata() then 
		return PathFinder.moveTo(getMapName(), "Route 21")
	elseif hasPokemonInTeam("Rattata") then
		return PathFinder.moveTo(getMapName(), "Route 20")
	elseif self:needPokecenter() or not self.registeredPokecenter == "Pokecenter Cinnabar Island"
		or (self.forceCaught and not hasPokemonInTeam("Rattata")) then
		return PathFinder.moveTo(getMapName(), "Pokecenter Cinnabar")
	elseif self:needPokemart() and not (getItemQuantity("Great Ball") > 9)then
		return PathFinder.moveTo(getMapName(), "Cinnabar Pokemart")
	else
		return PathFinder.moveTo(getMapName(), "Cinnabar mansion 1")
	end
end

function Elite4Johto:Cinnabarmansion1()
	if self:needPokecenter() or self.forceCaught 
	or self:needPokemart() and not (getItemQuantity("Great Ball") > 9) then
		return PathFinder.moveTo(getMapName(), "Cinnabar Island")
	else
		return moveToRectangle(3,16,18,37)
	end
end

function Elite4Johto:CinnabarPokemart()
	local greatBallCount = getItemQuantity("Great Ball")
	local money         = getMoney()
	if money >= 600 and greatBallCount < 10 then
		if not isShopOpen() then
			return talkToNpcOnCell(3,5)
		else
			local greatBallToBuy = 10 - greatBallCount
			local maximumBuyableGreatBalls = money / 600
			if maximumBuyableGreatBalls < greatBallToBuy then
				greatBallToBuy = maximumBuyableGreatBalls
			end
			return buyItem("Great Ball", greatBallToBuy)
		end
	else
		return PathFinder.moveTo(getMapName(), "Cinnabar Island")
	end
end

function Elite4Johto:PokecenterCinnabar()
	self:pokecenter("Cinnabar Island")
	if self.forceCaught and not hasPokemonInTeam("Rattata") then
		return fatal("Need PC Lib Fix")-- get Rattata in PC
	end
end

function Elite4Johto:Cinnabarmansion2()
	return PathFinder.moveTo(getMapName(), "Cinnabar mansion 1")
end

function Elite4Johto:Route20()
	if not self:isTrainingOver() then
		return moveToCell(73,40) --Seafoam 1F
	else
		return PathFinder.moveTo(getMapName(), "Cinnabar Island")
	end
end

function Elite4Johto:Seafoam1F()
	if not self:isTrainingOver() then
		return moveToCell(64,8) --Seafoam B1F
	else
		return PathFinder.moveTo(getMapName(), "Route 20")
	end
end

function Elite4Johto:SeafoamB1F()
	if not self:isTrainingOver() then
		return moveToCell(64,25) --Seafoam B2F
	else
		return moveToCell(85,22)
	end
end

function Elite4Johto:SeafoamB2F()
	if not self:isTrainingOver() then
		return moveToCell(63,19) --Seafoam B3F
	else
		return moveToCell(51,27)
	end
end
function Elite4Johto:SeafoamB3F()
	if not self:isTrainingOver() then
		return moveToCell(57,26) --Seafoam B4F
	else
		return moveToCell(64,16)
	end
end

function Elite4Johto:SeafoamB4F()
	if self:isTrainingOver() then
		return moveToCell(53,28)
	elseif self:needPokecenter() and self:canUseNurse() then -- if have 1500 money
		return talkToNpcOnCell(59,13)
	elseif getUsablePokemonCount() then
	    return moveToRectangle(50,10,62,32)			
	else
		return fatal("don't have enough Pokemons for farm 1500 money and heal the team")
	end
end

function Elite4Johto:canUseNurse()
	return getMoney() > 1500
end

function Elite4Johto:VictoryRoadKanto1F()
	return PathFinder.moveTo(getMapName(), "Victory Road Kanto 2F")
end

function Elite4Johto:VictoryRoadKanto2F()
	if not self:isTrainingOver() or not self:canBuyReviveItems() then
		return moveToRectangle(12,27,28,30) -- could add zone exp
	end
	return moveToCell(14,9) 
end

function Elite4Johto:VictoryRoadKanto3F()
	if not self:isTrainingOver() or not self:canBuyReviveItems() then
		return moveToCell(29,17)
	end
	return PathFinder.moveTo(getMapName(), "Indigo Plateau")
end

function Elite4Johto:IndigoPlateau()
	if not self:needPokecenter() and not self:canBuyReviveItems() then
		return PathFinder.moveTo(getMapName(), "Victory Road Kanto 3F")
	elseif isNpcOnCell(10,13) then
		return talkToNpcOnCell(10,13)
	elseif not dialogs.leagueDefeated.state or not checkRattata() then
		return PathFinder.moveTo(getMapName(), "Indigo Plateau Center Johto")
	elseif dialogs.leagueDefeated.state and isNpcOnCell(21,10) then -- Joey
			if not (getPokemonName(1) == "Rattata") then
				return swapPokemonWithLeader("Rattata")
			else
				pushDialogAnswer(1)
				return talkToNpcOnCell(21,10)
			end
	else -- TO HOENN
		local PokemonWithLeftovers = Game.getPokemonIdWithItem("Leftovers") 
		if PokemonWithLeftovers > 0 then
			return takeItemFromPokemon(PokemonWithLeftovers)
		end
		pushDialogAnswer(1)
		return talkToNpcOnCell(21,7)
	end
end

function Elite4Johto:IndigoPlateauCenterJohto()
	dialogs.leaderDone.state = false
	self.registeredPokecenter = "Indigo Plateau Center Johto"
	if self:needPokecenter() or not Game.isTeamFullyHealed() then
		return talkToNpcOnCell(4,22)
	elseif dialogs.leagueDefeated.state or not self:canBuyReviveItems() then
		if not checkRattata() then
			return fatal("Need PC lib FIX to get Rattata From PC") -- get Rattata From PC
		else
			return PathFinder.moveTo(getMapName(), "Indigo Plateau")
		end
	elseif self:buyReviveItems() ~= false then
		return
	else
		return moveToCell(10,3) -- to League
	end
end

function Elite4Johto:EliteFourWillRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then	
		return talkToNpcOnCell(6,12) 
	else
		dialogs.leaderDone.state = false
		return moveToCell(6,3)
	end
end

function Elite4Johto:EliteFourKogaRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		return talkToNpcOnCell(20,24) 
	else
		dialogs.leaderDone.state = false
		return moveToCell(20,12)
	end
end

function Elite4Johto:EliteFourBrunoRoomJohto()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		return talkToNpcOnCell(21,24) 
	else
		dialogs.leaderDone.state = false
		return moveToCell(21,14)
	end
end


function Elite4Johto:EliteFourKarenRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		return talkToNpcOnCell(6,14) 
	else
		dialogs.leaderDone.state = false
		return moveToCell(6,3)
	end
end

function Elite4Johto:EliteFourChampionRoomJohto()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		return talkToNpcOnCell(6,15) 
	else
		dialogs.leagueDefeated.state = true
		return talkToNpcOnCell(6,4)
	end
end

function Elite4Johto:useReviveItems() --Return false if team don't need heal
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

function Elite4Johto:canBuyReviveItems()
	local bag_revive = getItemQuantity("Revive")
	local bag_hyperpot = getItemQuantity("Hyper Potion")
	local cost_revive = (self.qnt_revive - bag_revive) * 1500
	local cost_hyperpot = (self.qnt_hyperpot - bag_hyperpot) * 1200
	return getMoney() > (cost_hyperpot + cost_revive)
end

function Elite4Johto:buyReviveItems() --return false if all items are on the bag (32x Revives 32x HyperPotions)
	if getItemQuantity("Revive") < self.qnt_revive or getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
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
	else
		return false
	end
end

function checkRattata()
	local teamSize = getTeamSize()
	for i=1,teamSize,1 do
    	if getPokemonName(i) == "Rattata" and getPokemonLevel(i) >= 80 then
    		return true
		end
    end
    return false
end

return Elite4Johto