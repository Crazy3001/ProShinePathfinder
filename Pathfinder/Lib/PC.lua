-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local PC = {}

local Lib = require("Pathfinder/Lib/Lib")

function PC.isValidIndex(boxIndex, pokemonIndex)
	if getCurrentBoxId() == boxIndex and pokemonIndex <= getCurrentBoxSize() then
		return true
	end
	return false
end

function PC.isReady()
	if isPCOpen() and isCurrentPCBoxRefreshed() then
			return true
	end
	return false
end

function PC.use()
	if isPCOpen() then
		if isCurrentPCBoxRefreshed() then
			return
		else
			-- we wait
			return
		end
	else
		if not usePC() then
			Lib.error("libPC.use", "Tried to use the PC in a zone without PC")
		end
	end
end

-- this function needs to be called multiple time
-- returns true once the swap is done
function PC.swap(boxIndex, boxPokemonIndex, teamIndex)
	if not PC.isReady() then
		PC.use()
		return false
	else
		if not swapPokemonFromPC(boxIndex, boxPokemonIndex, teamIndex) then
			return Lib.error("libPC.swap", "Failed to swap")
		else
			return true
		end
	end
	return false
end

-- this function needs to be called multiple time
-- returns true once deposit is done
function PC.deposit(teamIndex)
	if not PC.isReady() then
		PC.use()
		return false
	else
		if not depositPokemonToPC(__teamIndex) then
			return Lib.error("libPC.deposit", "Failed to deposit")
		end
		return true
	end
	return false
end

-- this function needs to be called multiple time
-- returns true once withdraw is done
function PC.withdraw(boxIndex, boxPokemonIndex)
	if not PC.isReady() then
		PC.use()
		return false
	else
		if getTeamSize() == 6 then
			return Lib.error("libPC.withdraw", "Team full. Could not withdraw the pokemon "
				.. getPokemonNameFromPC(boxIndex, boxPokemonIndex))
		end
		if not withdrawPokemonFromPC(boxIndex, boxPokemonIndex, teamIndex) then
			return Lib.error("libPC.deposit", "Failed to deposit")
		end
		return true
	end
	return false
end

function PC.gatherDatas(sortingFunction)
	
end

-- sortingFunction must take 2 pokemons  as parameters (id + box) and return a bool
-- i.e.: 
--[[
	function sortByUniqueId(boxIndexA, boxPokemonIndexA, boxIndexB, boxPokemonIndexB)
		if (getPokemonUniqueIdFromPC(boxIndexA, boxPokemonIndexA) >
			getPokemonUniqueIdFromPC(boxIndexB, boxPokemonIndexB)
		then
			return true
		end
		return false
	end
	
	PC.sort(sortByUniqueId)
--]]
function PC.sort(sortingFunction)

end

return pc