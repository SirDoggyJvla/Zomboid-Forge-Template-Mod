--[[ ================================================ ]]--
--[[  /~~\'      |~~\                  ~~|~    |      ]]--
--[[  '--.||/~\  |   |/~\/~~|/~~|\  /    | \  /|/~~|  ]]--
--[[  \__/||     |__/ \_/\__|\__| \/   \_|  \/ |\__|  ]]--
--[[                     \__|\__|_/                   ]]--
--[[ ================================================ ]]--
--[[

This file defines the core of the mod of The Last of Us Infected Fork

]]--
--[[ ================================================ ]]--

--- import module from ZomboidForge
local ZomboidForge = require "ZomboidForge_module"

--- Create zombie types
local function Initialize_ZF_Template()
    -- Strong Zomboid
	if SandboxVars.ZF_Template.StrongZomboid then
		ZomboidForge.ZTypes.StrongZomboid = {
			-- base informations
			name = "IGUI_ZF_StrongZomboid",
			chance = SandboxVars.ZF_Template.StrongZomboid_SpawnWeight,

			-- UI
			color = {255, 0, 255,},
			outline = {0, 0, 0,},

			-- stats
			walktype = 1,
			strength = 1,
			toughness = 1,
			cognition = 1,
			memory = 1,
			sight = 1,
			hearing = 1,
			HP = 20,
		}
	end
end

Events.OnGameStart.Add(Initialize_ZF_Template)

