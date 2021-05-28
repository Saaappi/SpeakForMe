--[[
	These variables are provided to the addon by Blizzard.
		addonName	: This is self explanatory, but it's the name of the addon.
		t			: This is an empty table. This is how the addon can communicate between files or local functions, sort of like traditional classes.
]]--
local addonName, t = ...;

--[[
	Explanations for each subfield in the tables below.
		name		: This is the name of the gossip option we want the addon to check for.
		confirm		: If a gossip option uses a confirmation as a followup, this is the text we want to check for.
		text		: A message the addon will print when the automation is complete.
		cost		: The cost of selecting the option. This value should include a buffer. (Ex: If the option costs 10 silver to select, then a buffer might be 1 gold before the automation will use it.)
		targets		: If the name is too long, it may be more appropriate to base the automation off the player's current target instead.
		mod			: The key used to disable the automation.
]]--
local confirms = { -- An integer-indexed array of the events that should be registered to the addon's ScriptHandler.
	["BattlePets_AcceptBattle1"] = { -- Accepting a battle at a pet tamer.
		["name"] = "Let's do battle!",
		["confirm"] = "",
		["text"] = "Accepted battle against a pet tamer.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["BattlePets_AcceptBattle2"] = { -- Accepting a battle at a pet tamer.
		["name"] = "Begin pet battle.",
		["confirm"] = "",
		["text"] = "Accepted battle against a pet tamer.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["BattlePets_HealPets"] = { -- Healing battle pets at a Stable Master.
		["name"] = "I'd like to heal and revive my battle pets.",
		["confirm"] = "A small fee for supplies is required.",
		["text"] = "Healed all injured battle pets.",
		["cost"] = 10000,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["HorrificVisions_Garona"] = { -- Horrific Vision of Orgrimmar: Garona
		["name"] = "You have my aid. <Help Garona up>",
		["confirm"] = "",
		["text"] = "Spoke with Garona to help her up.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Quests_001"] = { -- Quest: Transdimensional Warfare: Chapter II
		["name"] = "<Use the Ambermill Dimensional Portal.>",
		["confirm"] = "",
		["text"] = "Used the Ambermill Dimensional Portal.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Quests_002"] = { -- Quest: Mix, Mingle, and Meddle
		["name"] = "Are you enjoying yourself?",
		["confirm"] = "",
		["text"] = "Spoke with one of the attendees.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Quests_003"] = { -- Quest: Welcome to the Machine
		["name"] = "",
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = {
			"Dumass",
			"Kingslayer Orkus",
			"Johnny Awesome",
		},
		["mod"] = "LALT",
	},
	["Quests_004"] = { -- Quest: Remedial Lessons
		["name"] = "I will retrieve the scrolls.",
		["confirm"] = "",
		["text"] = "Spoke with Voitha to retrieve the scrolls.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
};

t.confirms = confirms; -- Add the confirms array to the table, t.