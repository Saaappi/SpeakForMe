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
	[1] = { -- General NPC Gossips (without Cost)
		["names"] = {
			"Let's do battle!", -- Pet Battle
			"Begin pet battle.", -- Pet Battle
		},
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[2] = { -- Stable Masters
		["names"] = {
			"I'd like to heal and revive my battle pets.",
		},
		["confirm"] = "A small fee for supplies is required.",
		["text"] = "",
		["cost"] = 10000,
		["mod"] = "LALT",
	},
	[66824] = { -- Grand Master Obalis
		["names"] = {
			"Think you can take me in a pet battle?  Let's fight!", -- The extra space here is critical.
		},
		["confirm"] = "Come at me!",
		["text"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	["HV_Garona"] = { -- Horrific Vision of Orgrimmar: Garona
		["name"] = "You have my aid. <Help Garona up>",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Spoke with Garona to help her up.",
		["cost"] = 0,
		["targets"] = nil,
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
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q001"] = { -- Quest: Transdimensional Warfare: Chapter II
		["name"] = "<Use the Ambermill Dimensional Portal.>",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Used the Ambermill Dimensional Portal.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q002"] = { -- Quest: Mix, Mingle, and Meddle
		["name"] = "Are you enjoying yourself?",
		["confirm"] = "",
		["names"] = nil,
		["text"] = "Spoke with one of the attendees.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q003"] = { -- Quest: Welcome to the Machine
		["name"] = "",
		["names"] = nil,
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
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Spoke with Voitha to retrieve the scrolls.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q005"] = { -- Quest: Crossroads Caravan Pickup
		["name"] = "Yes, I'm ready. Let's do this thing!",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Spoke with Halga Bloodeye to escort the first caravan.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q006"] = { -- Quest: Crossroads Caravan Delivery
		["name"] = "Bring it on, Rocco.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Spoke with Rocco Whipshank to escort the second caravan.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q007"] = { -- Quest: Drag it Out of Them
		["name"] = "<Pound this chump.>",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Pounded the Razormane chump into the dirt!",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q008"] = { -- Quest: By Hook Or By Crook
		["name"] = "<Offer food.>",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Offered the Razormane food because completing quests quickly is fun.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q009"] = { -- Quest: The Baron's Demands
		["name"] = "<Break Longshore's manacles and free him.>",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Broke Baron Longshore's manacles.",
		["cost"] = 0,
		["targets"] = nil,
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
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q011"] = { -- Quest: Wenikee Boltbucket
		["name"] = "I'm ready to teleport. I think.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Teleported to another part of Northern Barrens. Oh. You don't look so good.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q012"] = { -- Quest: Return to Samophlanger
		["name"] = "Send me back to Nozzlepot's Outpost.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Teleported back to Nozzlepot's Outpost. All this teleportation is really taking its toll on your body...",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q013"] = { -- Quest: Mor'shan Caravan Pick-Up
		["name"] = "I'm ready. Let's go!",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Mounted the caravan for a long trek across Northern Barrens.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q014"] = { -- Quest: Mor'shan Caravan Delivery
		["name"] = "I'm ready to ride.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "Mounted the caravan to deliver supplies to Mor'shan Ramparts, aiding the Horde's defense against the night elves.",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q015"] = { -- Quest: Warriors' Redemption
		["name"] = "I recovered your armor and weapons. Victory or death!",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q016"] = { -- Quest: The Nightmare Scar
		["name"] = "I'm ready, Naralex.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q017"] = { -- Quest: Desolation Hold Inspection
		["name"] = "",
		["names"] = {
			"I'm here on behalf of Warlord Bloodhilt, who wants you to know he will be arriving shortly.",
			"I'll be sure to tell the Taurajo refugees that. Those that lived.",
			"Tell him yourself. He's almost here!",
		},
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q018"] = { -- Quest: Intelligence Warfare
		["name"] = "",
		["names"] = {
			"What? Who are you? What clan are you from?",
			"You're no orc. You're a spy! Alliance spy!",
		},
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q019"] = { -- Quest: The Butcher of Taurajo
		["name"] = "I am ready, Karthog. For the Horde!",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q020"] = { -- Quest: Mahka's Plea
		["name"] = "Mahka wants you to come see her, Mankrik.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q021"] = { -- Quest: Iterating Upon Success
		["name"] = "I need to take a bat to the Dawning Isles.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
	["Q022"] = { -- Quest: Twilight of the Dawn Runner
		["name"] = "Balandar sent me to get you out of here and reclaim his cargo. He's waiting for you in Brackenwall Village.",
		["names"] = nil,
		["confirm"] = "",
		["text"] = "",
		["cost"] = 0,
		["targets"] = nil,
		["mod"] = "LALT",
	},
};

t.confirms = confirms; -- Add the confirms array to the table, t.