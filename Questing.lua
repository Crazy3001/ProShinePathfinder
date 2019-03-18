-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

name = "Questing"
author = "g0ld"
description = [[ 
╔═════════════════╣ 𝐐𝐔𝐄𝐒𝐓𝐈𝐍𝐆.𝐥𝐮𝐚 ╠════════════════╗
║ « Plays the story from the very start to
║   to as far as possible! »
║
║ 𝐓𝐡𝐚𝐧𝐤𝐬 𝐭𝐨 ..
║ g0ld, TybaIt, MeltWS, Rympex, Emuuung, Crazy3001,
║ vladslav and future GitHub.com contributers.
║
║ 𝐆𝐢𝐭𝐇𝐮𝐛: https://github.com/g0ldPRO/Questing.lua
╚═════════════════════════════════════════════════╝]]

dofile "Settings/QuestSettings.lua"

local QuestManager
local questManager = nil

function onStart()
	math.randomseed(os.time())
	QuestManager = require "Pathfinder/Quests/QuestManager"
	questManager = QuestManager:new()
end

function onPause()
	questManager:pause()
end

function onResume()
end

function onStop()
end

function onPathAction()
	questManager:path()
	if questManager.isOver then
		return fatal("No more quest to do. Script terminated.")
	end
end

function onBattleAction()
	questManager:battle()
end

function onDialogMessage(message)
    questManager:dialog(message)
end

function onBattleMessage(message)
	questManager:battleMessage(message)
end

function onSystemMessage(message)
	questManager:systemMessage(message)
end

function onLearningMove(moveName, pokemonIndex)
	questManager:learningMove(moveName, pokemonIndex)
end