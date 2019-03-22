-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local QuestManager = {}

--Kanto
local StartKantoQuest     = require('Pathfinder/Quests/Kanto/StartKantoQuest')
local PalletStartQuest    = require('Pathfinder/Quests/Kanto/PalletStartQuest')
local ViridianSchoolQuest = require('Pathfinder/Quests/Kanto/ViridianSchoolQuest')
local BoulderBadgeQuest   = require('Pathfinder/Quests/Kanto/BoulderBadgeQuest')
local MoonFossilQuest     = require('Pathfinder/Quests/Kanto/MoonFossilQuest')
local CascadeBadgeQuest   = require('Pathfinder/Quests/Kanto/CascadeBadgeQuest')
local LanceVermilionQuest = require('Pathfinder/Quests/Kanto/LanceVermilionQuest')
local SSAnneQuest         = require('Pathfinder/Quests/Kanto/SSAnneQuest')
local ThunderBadgeQuest   = require('Pathfinder/Quests/Kanto/ThunderBadgeQuest')
local HmFlashQuest        = require('Pathfinder/Quests/Kanto/HmFlashQuest')
local RockTunnelQuest     = require('Pathfinder/Quests/Kanto/RockTunnelQuest')
local RocketCeladonQuest  = require('Pathfinder/Quests/Kanto/RocketCeladonQuest')
local RainbowBadgeQuest   = require('Pathfinder/Quests/Kanto/RainbowBadgeQuest')
local PokeFluteQuest      = require('Pathfinder/Quests/Kanto/PokeFluteQuest')
local SnorlaxQuest        = require('Pathfinder/Quests/Kanto/SnorlaxQuest')
local SoulBadgeQuest      = require('Pathfinder/Quests/Kanto/SoulBadgeQuest')
local HmSurfQuest         = require('Pathfinder/Quests/Kanto/HmSurfQuest')
local ExpForSaffronQuest  = require('Pathfinder/Quests/Kanto/ExpForSaffronQuest')
local SaffronGuardQuest   = require('Pathfinder/Quests/Kanto/SaffronGuardQuest')
local MarshBadgeQuest     = require('Pathfinder/Quests/Kanto/MarshBadgeQuest')
local BuyBikeQuest        = require('Pathfinder/Quests/Kanto/BuyBikeQuest')
local SilphCoQuest        = require('Pathfinder/Quests/Kanto/SilphCoQuest')
local ToCinnabarQuest     = require('Pathfinder/Quests/Kanto/ToCinnabarQuest')
local CinnabarKeyQuest    = require('Pathfinder/Quests/Kanto/CinnabarKeyQuest')
local VolcanoBadgeQuest   = require('Pathfinder/Quests/Kanto/VolcanoBadgeQuest')
local ReviveFossilQuest   = require('Pathfinder/Quests/Kanto/ReviveFossilQuest')
local EarthBadgeQuest     = require('Pathfinder/Quests/Kanto/EarthBadgeQuest')
local ExpForElite4Kanto   = require('Pathfinder/Quests/Kanto/ExpForElite4Kanto')
local Elite4Kanto         = require('Pathfinder/Quests/Kanto/Elite4Kanto')
local GoToJohtoQuest      = require('Pathfinder/Quests/Kanto/GoToJohtoQuest')


--Johto
local StartJohtoQuest     = require('Pathfinder/Quests/Johto/StartJohtoQuest')
local ZephyrBadgeQuest    = require('Pathfinder/Quests/Johto/ZephyrBadgeQuest')
local SproutTowerQuest    = require('Pathfinder/Quests/Johto/SproutTowerQuest')
local HiveBadgeQuest      = require('Pathfinder/Quests/Johto/HiveBadgeQuest')
local IlexForestQuest     = require('Pathfinder/Quests/Johto/IlexForestQuest')
local GoldenrodCityQuest  = require('Pathfinder/Quests/Johto/GoldenrodCityQuest')
local PlainBadgeQuest     = require('Pathfinder/Quests/Johto/PlainBadgeQuest')
local FogBadgeQuest		  = require('Pathfinder/Quests/Johto/FogBadgeQuest')
local StormBadgeQuest     = require('Pathfinder/Quests/Johto/StormBadgeQuest')
local MineralBadgeQuest	  = require('Pathfinder/Quests/Johto/MineralBadgeQuest')
local GlacierBadgeQuest	  = require('Pathfinder/Quests/Johto/GlacierBadgeQuest')
local RisingBadgeQuest	  = require('Pathfinder/Quests/Johto/RisingBadgeQuest')
local Elite4Johto		  = require('Pathfinder/Quests/Johto/Elite4Johto')

--Hoenn
local FromLittlerootToWoodsQuest = require('Pathfinder/Quests/Hoenn/FromLittlerootToWoodsQuest')
local StoneBadgeQuest 			 = require('Pathfinder/Quests/Hoenn/StoneBadgeQuest')
local getSLetter 				 = require('Pathfinder/Quests/Hoenn/getSLetter')
local KnuckleBadgeQuest 		 = require('Pathfinder/Quests/Hoenn/KnuckleBadgeQuest')
local toMauville 				 = require('Pathfinder/Quests/Hoenn/toMauville')
local DynamoBadge				 = require('Pathfinder/Quests/Hoenn/DynamoBadge')
local ToLavaridgeTown	  		 = require('Pathfinder/Quests/Hoenn/ToLavaridgeTown')
local ToBalanceBadge 		     = require('Pathfinder/Quests/Hoenn/ToBalanceBadge')
local ToFortreeCity  		     = require('Pathfinder/Quests/Hoenn/ToFortreeCity')
local FeatherBadgeQuest  	     = require('Pathfinder/Quests/Hoenn/FeatherBadgeQuest')
local GetTheOrbs 				 = require('Pathfinder/Quests/Hoenn/GetTheOrbs')
local MagmaHideout			     = require('Pathfinder/Quests/Hoenn/MagmaHideout')
local ToMossdeepCity			 = require('Pathfinder/Quests/Hoenn/ToMossdeepCity')
local meetKyogre			     = require('Pathfinder/Quests/Hoenn/meetKyogre')
local beatDeoxys				 = require('Pathfinder/Quests/Hoenn/beatDeoxys')
local e4Hoenn					 = require('Pathfinder/Quests/Hoenn/e4Hoenn')

local quests = {
	-- Kanto Quests
	StartKantoQuest:new(),
	PalletStartQuest:new(),
	ViridianSchoolQuest:new(),
	BoulderBadgeQuest:new(),
	MoonFossilQuest:new(),
	CascadeBadgeQuest:new(),
	LanceVermilionQuest:new(),
	SSAnneQuest:new(),
	ThunderBadgeQuest:new(),
	HmFlashQuest:new(),
	RockTunnelQuest:new(),
	RocketCeladonQuest:new(),
	RainbowBadgeQuest:new(),
	PokeFluteQuest:new(),
	SnorlaxQuest:new(),
	SoulBadgeQuest:new(),
	HmSurfQuest:new(),
	ExpForSaffronQuest:new(),
	SaffronGuardQuest:new(),
	MarshBadgeQuest:new(),
	BuyBikeQuest:new(),
	SilphCoQuest:new(),
	ToCinnabarQuest:new(),
	CinnabarKeyQuest:new(),
	VolcanoBadgeQuest:new(),
	ReviveFossilQuest:new(),
	EarthBadgeQuest:new(),
	ExpForElite4Kanto:new(),
	Elite4Kanto:new(),
	GoToJohtoQuest:new(),
	
	-- Johto Quests 
	StartJohtoQuest:new(),
	ZephyrBadgeQuest:new(),
	SproutTowerQuest:new(),
	HiveBadgeQuest:new(),
	IlexForestQuest:new(),
	GoldenrodCityQuest:new(),
	PlainBadgeQuest:new(),
	FogBadgeQuest:new(),
	StormBadgeQuest:new(),
	MineralBadgeQuest:new(),
	GlacierBadgeQuest:new(),
	RisingBadgeQuest:new(),
	Elite4Johto:new(),
	
	--HoennQuest
	FromLittlerootToWoodsQuest:new(),
	StoneBadgeQuest:new(),
	getSLetter:new(),
	KnuckleBadgeQuest:new(),
	toMauville:new(),
	DynamoBadge:new(),
	ToLavaridgeTown:new(),
	ToBalanceBadge:new(),
	ToFortreeCity:new(),
	FeatherBadgeQuest:new(),	
	GetTheOrbs:new(),
	MagmaHideout:new(),
	ToMossdeepCity:new(),
	meetKyogre:new(),
	beatDeoxys:new(),
	e4Hoenn:new()
}

function QuestManager:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.quests = quests
	o.selected = nil
	o.isOver = false
	return o
end

function QuestManager:message()
	if self.selected != nil then
		return self.selected:message()
	end
	return nil
end

function QuestManager:pause()
	if self.selected then
        log('╔═════════════════╣ 𝐐𝐔𝐄𝐒𝐓 𝐏𝐀𝐔𝐒𝐄𝐃 ╠═════════════════╗')
        log('║')
		log('║ ' .. self:message())
        log('║')
        log('╚════════════════════════════════════════════════════╝')
	end
end

function QuestManager:next()
	for _, quest in pairs(self.quests) do
		if quest:isDoable() == true then
			self.selected = quest
			return quest
		end
	end
	self.selected = nil
	return nil
end

function QuestManager:isQuestOver()
	if not self.selected or self.selected:isDone() then
		return true
	end
	return false
end

function QuestManager:updateQuest()
	if getMapName() == "" then
		return false
	end
	if self:isQuestOver() then
		if self.selected then
            log('╔═════════════════╣ 𝐐𝐔𝐄𝐒𝐓 𝐂𝐎𝐌𝐏𝐋𝐄𝐓𝐄𝐃 ╠═════════════════╗')
            log('║')
            log('║ ' .. self.selected.name)
            log('║')
            log('╚════════════════════════════════════════════════════════╝')
		end
		if not self:next() then
			self.isOver = true
			return false
		end
        log('╔═════════════════╣ 𝐐𝐔𝐄𝐒𝐓 𝐒𝐓𝐀𝐑𝐓𝐈𝐍𝐆 ╠═════════════════╗')
        log('║')
		log('║ ' .. self.selected:message())
        log('║')
        log('╚══════════════════════════════════════════════════════╝')
	end
	return true
end

function QuestManager:path()
	if not self:updateQuest() then
		return false
	end
	return self.selected:path()
end

function QuestManager:battle()
	if not self:updateQuest() then
		return false
	end
	return self.selected:battle()
end

function QuestManager:dialog(message)
	if self.selected == nil then
		return false
	end
	return self.selected:dialog(message)
end

function QuestManager:battleMessage(message)
	if not self:updateQuest() then
		return false
	end
	return self.selected:battleMessage(message)
end

function QuestManager:systemMessage(message)
	if message == nil or not self.selected then
		return false
	end
	return self.selected:systemMessage(message)
end

function QuestManager:learningMove(moveName, pokemonIndex)
	if not self:updateQuest() then
		return false
	end
	return self.selected:learningMove(moveName, pokemonIndex)
end

return QuestManager
