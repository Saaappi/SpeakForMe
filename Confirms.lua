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
	["BP_Battle1"] = { -- Accepting a battle at a pet tamer.
		["name"] = "Let's do battle!",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Accepted battle against a pet tamer.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["BP_Battle2"] = { -- Accepting a battle at a pet tamer.
		["name"] = "Begin pet battle.",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Accepted battle against a pet tamer.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["BP_Heal"] = { -- Healing battle pets at a Stable Master.
		["name"] = "I'd like to heal and revive my battle pets.",
		["names"] = {},
		["confirm"] = "A small fee for supplies is required.",
		["text"] = "Healed all injured battle pets.",
		["cost"] = 10000,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["HV_Garona"] = { -- Horrific Vision of Orgrimmar: Garona
		["name"] = "You have my aid. <Help Garona up>",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Spoke with Garona to help her up.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["MSV_Cho"] = { -- Lorewalker Cho in Mogu'shan Vaults
		["name"] = "",
		["names"] = {
			"What are you waiting for? Let's go investigate!",
			"Go ahead and turn this thing on.",
		},
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q001"] = { -- Quest: Transdimensional Warfare: Chapter II
		["name"] = "<Use the Ambermill Dimensional Portal.>",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Used the Ambermill Dimensional Portal.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q002"] = { -- Quest: Mix, Mingle, and Meddle
		["name"] = "Are you enjoying yourself?",
		["confirm"] = "",
		["names"] = {},
		["text"] = "Spoke with one of the attendees.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q003"] = { -- Quest: Welcome to the Machine
		["name"] = "",
		["names"] = {},
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
	["Q004"] = { -- Quest: Remedial Lessons
		["name"] = "I will retrieve the scrolls.",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Spoke with Voitha to retrieve the scrolls.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q005"] = { -- Quest: Crossroads Caravan Pickup
		["name"] = "Yes, I'm ready. Let's do this thing!",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Spoke with Halga Bloodeye to escort the first caravan.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q006"] = { -- Quest: Crossroads Caravan Delivery
		["name"] = "Bring it on, Rocco.",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Spoke with Rocco Whipshank to escort the second caravan.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q007"] = { -- Quest: Drag it Out of Them
		["name"] = "<Pound this chump.>",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Pounded the Razormane chump into the dirt!",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q008"] = { -- Quest: By Hook Or By Crook
		["name"] = "<Offer food.>",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Offered the Razormane food because completing quests quickly is fun.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q009"] = { -- Quest: The Baron's Demands
		["name"] = "<Break Longshore's manacles and free him.>",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Broke Baron Longshore's manacles.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q010"] = { -- Quest: Club Foote
		["name"] = "",
		["names"] = {
			"<Club him unconscious.>",
			"<Rifle through his pockets.>",
		},
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q011"] = { -- Quest: Wenikee Boltbucket
		["name"] = "I'm ready to teleport. I think.",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Teleported to another part of Northern Barrens. Oh. You don't look so good.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q012"] = { -- Quest: Return to Samophlanger
		["name"] = "Send me back to Nozzlepot's Outpost.",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Teleported back to Nozzlepot's Outpost. All this teleportation is really taking its toll on your body...",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q013"] = { -- Quest: Mor'shan Caravan Pick-Up
		["name"] = "I'm ready. Let's go!",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Mounted the caravan for a long trek across Northern Barrens.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q014"] = { -- Quest: Mor'shan Caravan Delivery
		["name"] = "I'm ready to ride.",
		["names"] = {},
		["confirm"] = "",
		["text"] = "Mounted the caravan to deliver supplies to Mor'shan Ramparts, aiding the Horde's defense against the night elves.",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
	["Q015"] = { -- Quest: Warriors' Redemption
		["name"] = "I recovered your armor and weapons. Victory or death!",
		["names"] = {},
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = {},
		["mod"] = "LALT",
	},
};

t.confirms = confirms; -- Add the confirms array to the table, t.