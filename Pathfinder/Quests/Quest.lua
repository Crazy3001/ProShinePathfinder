-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local Lib  = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Table = require "Pathfinder/Lib/Table"
local PathFinder = require "Pathfinder/MoveToApp"

local blacklist = require "Settings/blacklist"

local Quest = {}

function Quest:new(name, description, level, dialogs)
	local o = {}
	setmetatable(o, self)
	self.__index   = self
	o.name         = name
	o.description  = description
	o.level        = level or 1
	o.dialogs      = dialogs
	o.training     = true
	o.bikeUsable   = true
	o.autoEvolve   = true
	return o
end

function Quest:isDoable()
	Lib.error("Quest:isDoable", "function is not overloaded in quest: " .. self.name)
	return nil
end

function Quest:isDone()
	return self:isDoable() == false
end

function Quest:mapToFunction()
	local mapName = getMapName()
	local mapFunction = Lib.removeCharacter(mapName, ' ')
	mapFunction = Lib.removeCharacter(mapFunction, '.')
	mapFunction = Lib.removeCharacter(mapFunction, '-') -- Map "Fisherman House - Vermilion"
	return mapFunction
end

function Quest:hasMap()
	local mapFunction = self:mapToFunction()
	if self[mapFunction] then
		return true
	end
	return false
end

function Quest:pokecenter(exitMapName) -- idealy make it work without exitMapName
	self.registeredPokecenter = getMapName()
	Lib.todo("add a moveDown() or moveToNearestLink() or getLinks() to PROShine")
	if not Game.isTeamFullyHealed() then
		return usePokecenter()
	end
	return PathFinder.moveTo(self.registeredPokecenter, exitMapName)
end

-- at a point in the Game we'll always need to buy the same things
-- use this function then
function Quest:pokemart(exitMapName)
	local pokeballCount = getItemQuantity("Pokeball")
	local money         = getMoney()
	if money >= 200 and pokeballCount < 50 then
		if not isShopOpen() then
			if isNpcOnCell(3,5) then 
				return talkToNpcOnCell(3,5)
			elseif isNpcOnCell(12,9) then
				return talkToNpcOnCell(12,9)
			end
		else
			local pokeballToBuy = 50 - pokeballCount
			local maximumBuyablePokeballs = money / 200
			if maximumBuyablePokeballs < pokeballToBuy then
				pokeballToBuy = maximumBuyablePokeballs
			end
			log("Buying " .. pokeballToBuy .. " Pokeballs")
			return buyItem("Pokeball", pokeballToBuy)
		end
	else
		return PathFinder.moveTo(getMapName(), exitMapName)
	end
end

function Quest:isTrainingOver()
	if Game.minTeamLevel() >= self.level then
		if self.training then -- end the training
			self:stopTraining()
		end
		return true
	end
	return false
end

function Quest:leftovers()
	ItemName = "Leftovers"
	local PokemonNeedLeftovers = Game.getFirstUsablePokemon()
	local PokemonWithLeftovers = Game.getPokemonIdWithItem(ItemName)
	
	if getMapName() == "Route 27" and not hasItem("Zephyr Badge") --START JOHTO
	or getMapName() == "Indigo Plateau" and not hasItem("Stone Badge") then -- START HOENN
		return false
	end
	if getTeamSize() > 0 then
		if PokemonWithLeftovers > 0 then
			if PokemonNeedLeftovers == PokemonWithLeftovers  then
				return false -- now leftovers is on rightpokemon
			else
				takeItemFromPokemon(PokemonWithLeftovers)
				return true
			end
		else
			if hasItem(ItemName) and PokemonNeedLeftovers > 0 then
				giveItemToPokemon(ItemName,PokemonNeedLeftovers)
				return true
			else
				return false-- don't have leftovers in bag and is not on pokemons
			end
		end
	else
		return false
	end
end

function Quest:useBike()
	if hasItem("Bicycle") and self.bikeUsable then
		if isOutside() and not isMounted() and not isSurfing() then
			log("Using: Bicycle")
			return useItem("Bicycle")
		else
			return false
		end
	else
		self.bikeUsable = true
		return false
	end
end

function Quest:autoEvolveSwitch()
	if self.autoEvolve == isAutoEvolve() then -- custom proshine API -> Github/MeltWS
		return true
	elseif self.autoEvolve then
		log("Enabling auto evolve.")
		return enableAutoEvolve()
	else
		log("Disabling auto evolve.")
		return disableAutoEvolve()
	end
end

function Quest:startTraining()
	self.training = true
end

function Quest:stopTraining()
	self.training = false
	self.healPokemonOnceTrainingIsOver = true
end

function Quest:needPokemart(item, amount, price)
	-- TODO: ItemManager
    if not item or not amount or not price then
        item = "Pokeball"
        amount = 50
        price = 200
    end
	if getItemQuantity(item) < amount and getMoney() >= price then
        return true
	end
	return false
end

function Quest:needPokecenter()
	if getTeamSize() == 1 then
		if getPokemonHealthPercent(1) <= 50 then
			return true
		end
	-- else we would spend more time evolving the higher level ones
	elseif not self:isTrainingOver() then
		if getUsablePokemonCount() == 1 or Game.getUsablePokemonCountUnderLevel(self.level) == 0 then
			return true
		end
	else
		if not Game.isTeamFullyHealed() then
			if self.healPokemonOnceTrainingIsOver then
				return true
			end
		else
			-- the team is healed and we do not need training
			self.healPokemonOnceTrainingIsOver = false
		end
	end
	return false
end

function Quest:message()
	return self.name .. ': ' .. self.description
end

-- I'll need a TeamManager class very soon
local moonStoneTargets = {
	"Clefairy",
	"Jigglypuff",
	"Munna",
	"Nidorino",
	"Nidorina",
	"Skitty"
}

function Quest:advanceSorting()
	local pokemonsUsable = Game.getTotalUsablePokemonCount()
	for pokemonId=1, pokemonsUsable, 1 do
		if not isPokemonUsable(pokemonId) then --Move it at bottom of the Team
			for pokemonId_ = pokemonsUsable + 1, getTeamSize(), 1 do
				if isPokemonUsable(pokemonId_) then
					swapPokemon(pokemonId, pokemonId_)
					return true
				end
			end
			
		end
	end
	if not isTeamRangeSortedByLevelAscending(1, pokemonsUsable) then --Sort the team without not usable pokemons
		return sortTeamRangeByLevelAscending(1, pokemonsUsable)
	end
	return false
end

function Quest:evolvePokemon()
	local hasMoonStone = hasItem("Moon Stone")
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonName = getPokemonName(pokemonId)
		if hasMoonStone and Table.tableHasValue(moonStoneTargets, pokemonName) then
			return useItemOnPokemon("Moon Stone", pokemonId)
		end
	end
	return false
end

function Quest:path()
	if self.inBattle then
		self.inBattle = false
		self:battleEnd()
	end
	if self:evolvePokemon() then
		return true
	end
	if self:advanceSorting() then
		return true
	end
	if self:leftovers() then
		return true
	end
	if self:useBike() then
		return true
	end
	if not self:autoEvolveSwitch() then
		return fatal("Switching auto evolve state failed.")
	end
	local mapFunction = self:mapToFunction()
	assert(self[mapFunction] ~= nil, self.name .. " quest has no method for map: " .. getMapName())
	self[mapFunction](self)
end

function Quest:isPokemonBlacklisted(pokemonName)
	return Table.tableHasValue(blacklist, pokemonName)
end

function Quest:battleBegin()
	self.canRun = true
end

function Quest:battleEnd()
	self.canRun = true
end

-- I'll need a TeamManager class very soon
local blackListTargets = { --it will kill this targets instead catch
	"Metapod",
	"Kakuna",
	"Wurmple",
	"Silcoon",
	"Cascoon",
	"Ralts",
	"Seedot",
	"Surskit",
	"Doduo",
	"Hoothoot",
	"Zigzagoon"
}

function Quest:wildBattle()
	if isOpponentShiny() then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	elseif self.pokemon ~= nil and self.forceCaught ~= nil then
		if getOpponentName() == self.pokemon and self.forceCaught == false then --try caught only if never caught in this quest
			if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
				return true
			end
		end
	elseif not isAlreadyCaught() and not Table.tableHasValue(blackListTargets, getOpponentName()) then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	end	
	-- if we do not try to catch it
	if getTeamSize() == 1 or getUsablePokemonCount() > 1 then
		local opponentLevel = getOpponentLevel()
		local myPokemonLvl  = getPokemonLevel(getActivePokemonNumber())
		if opponentLevel >= myPokemonLvl then
			local requestedId, requestedLevel = Game.getMaxLevelUsablePokemon()
			if requestedId ~= nil and requestedLevel > myPokemonLvl then
				return sendPokemon(requestedId)
			end
		end
		return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
	else
		if not self.canRun then
			return attack() or Game.useAnyMove()
		end
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end

function Quest:trainerBattle()
	-- bug: if last pokemons have only damaging but type ineffective
	-- attacks, then we cannot use the non damaging ones to continue.
	if not self.canRun then -- trying to switch while a pokemon is squeezed end up in an infinity loop
		return attack() or Game.useAnyMove()
	end
	return attack() or sendUsablePokemon() or sendAnyPokemon() -- or Game.useAnyMove()
end

function Quest:customBattle()
	Lib.error("Quest:customBattle", "function is not overloaded in quest: " .. self.name)
	return nil
end

function Quest:isCustomBattle()
	return false
end

function Quest:battle()
	if not self.inBattle then
		self.inBattle = true
		self:battleBegin()
	end
	if self:isCustomBattle() then
		return self:customBattle()
	elseif isWildBattle() then
		return self:wildBattle()
	else
		return self:trainerBattle()
	end
end

function Quest:dialog(message)
	if self.dialogs == nil then
		return false
	end
	for _, dialog in pairs(self.dialogs) do
		if dialog:messageMatch(message) then
			dialog.state = true
			return true
		end
	end
	return false
end

function Quest:battleMessage(message)
	if stringContains(message, "You can not run away!") then
		Lib.canRun = false
	elseif self.pokemon ~= nil and self.forceCaught ~= nil then
		if stringContains(message, "caught") and stringContains(message, self.pokemon) then --Force caught the specified pokemon on quest 1time
			log("Selected Pokemon: " .. self.pokemon .. " is Caught")
			self.forceCaught = true
			return true
		end
	elseif stringContains(message, "black out") and self.level < 100 and self:isTrainingOver() then
        log('╔═════════════════╣ 𝐐𝐔𝐄𝐒𝐓 𝐅𝐀𝐈𝐋𝐄𝐃 ╠═════════════════╗')
        log('║')
        log('║ « ' .. self.name .. ' »')
        log('║ Raising current quest level (' .. self.level .. ') by ' .. QUESTLEVEL_RAISE .. ' level.')
		self.level = self.level + QUESTLEVEL_RAISE
		log('║ Training team to new quest level ' .. self.level .. '...')
		self:startTraining()
        log('║')
        log('╚═══════════════════════════════════════════════════╝')
		return true
	end
	return false
end

function Quest:systemMessage(message)
	if stringContains(message, "You can't do this while surfing!") then
		self.bikeUsable = false
	end	
	return false
end

local keepMoves = { -- moves not to forget.
	"cut",
	"surf",
	"flash",
	"rock smash",
	"dive",
	"sleep powder",
	"sucker punch" -- for deoxys
}

function Quest:chooseForgetMove(moveName, pokemonIndex) -- Calc the WrostAbility ((Power x PP)*(Accuract/100))
	local ForgetMoveName = nil
	local ForgetMoveTP = 9999
	for moveId=1, 4, 1 do
		local MoveName = getPokemonMoveName(pokemonIndex, moveId)
		if MoveName and not Table.tableHasValue(keepMoves, string.lower(MoveName)) then
			local movePP = getPokemonMaxPowerPoints(pokemonIndex, moveId)
			if movePP > 10 then -- To prevent not having high power move later Game.
				movePP = 10
			end
			local CalcMoveTP = math.modf(movePP * getPokemonMovePower(pokemonIndex,moveId)*(math.abs(getPokemonMoveAccuracy(pokemonIndex,moveId)) / 100))
			if CalcMoveTP < ForgetMoveTP then
				ForgetMoveTP = CalcMoveTP
				ForgetMoveName = MoveName
			end
		elseif MoveName then
			log("[Move to keep : " .. MoveName .. "]")
		end
	end
	log("[Learning Move: " .. moveName .. "  -->  Forget Move: " .. ForgetMoveName .. "]")
	return ForgetMoveName
end

function Quest:learningMove(moveName, pokemonIndex)
	local ForgetMoveName = self:chooseForgetMove(moveName, pokemonIndex)
	if ForgetMoveName then
		return forgetMove(ForgetMoveName)
	else
		log("No move should be forgotten for Pokemon " .. pokemonIndex ..  ", unable to learn : " .. moveName)
	end
end

return Quest
