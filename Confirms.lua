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
			"Are you enjoying yourself?", -- Quest: Mix, Mingle, and Meddle
			"Begin pet battle.", -- Pet Battle
			"Let's do battle!", -- Pet Battle
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[2] = { -- General NPC Gossips (with Cost)
		["names"] = {
			"I'd like to heal and revive my battle pets.",
		},
		["confirm"] = "A small fee for supplies is required.",
		["cost"] = 10000,
		["mod"] = "LALT",
	},
	[3467] = { -- Baron Longshore
		["names"] = {
			"<Break Longshore's manacles and free him.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[9316] = { -- Wenikee Boltbucket
		["names"] = {
			"Send me back to Nozzlepot's Outpost.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[17119] = { -- Ithania
		["names"] = {
			"Balandar sent me to get you out of here and reclaim his cargo. He's waiting for you in Brackenwall Village.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[34258] = { -- Halga Bloodeye
		["names"] = {
			"Yes, I'm ready. Let's do this thing!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[34503] = { -- Razormane Pillager
		["names"] = {
			"<Pound this chump.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[34523] = { -- Captured Razormane
		["names"] = {
			"<Offer food.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[34578] = { -- Rocco Whipshank
		["names"] = {
			"Bring it on, Rocco.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[34674] = { -- Brak Blusterpipe
		["names"] = {
			"I'm ready to teleport. I think.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[34754] = { -- Chief Engineer Foote
		["names"] = {
			"<Club him unconscious.>",
			"<Rifle through his pockets.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[37167] = { -- Stonetalon Prisoner
		["names"] = {
			"I recovered your armor and weapons. Victory or death!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[37570] = { -- Naralex
		["names"] = {
			"I'm ready, Naralex.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[37811] = { -- Warlord Gar'dul
		["names"] = {
			"I'm here on behalf of Warlord Bloodhilt, who wants you to know he will be arriving shortly.",
			"I'll be sure to tell the Taurajo refugees that. Those that lived.",
			"Tell him yourself. He's almost here!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[37847] = { -- Mankrik
		["names"] = {
			"Mahka wants you to come see her, Mankrik.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[38015] = { -- Karthog
		["names"] = {
			"I am ready, Karthog. For the Horde!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[38033] = { -- Awkward Gangly Orc
		["names"] = {
			"What? Who are you? What clan are you from?",
			"You're no orc. You're a spy! Alliance spy!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[44825] = { -- Bat Handler Maggotbreath
		["names"] = {
			"I need to take a bat to the Dawning Isles.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[45752] = { -- Ambermill Dimensional Portal
		["names"] = {
			"<Use the Ambermill Dimensional Portal.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[47442] = { -- Johnny Awesome
		["names"] = {
			"Well, we are having some problems at the Sludge Fields, located northeast of here. Warden Stillwater could use your help.",
			"That's all.",
			"THAT'S ALL, JOHNNY AWESOME. TAKE IT OR LEAVE IT!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[47443] = { -- Kingslayer Orkus
		["names"] = {
			"Um... Apparently there is some trouble at Southshore. Something about worgen insurgents. Maybe you could help with them?",
			"None.",
			"Right, thanks. Just go ahead and head southeast. More south than east. Probably off the coast.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[47444] = { -- Dumass
		["names"] = {
			"Maybe you should go take a nap or something. I don't know if I have any work for you.",
			"Wait a minute. It looks like something just came up. Yes, right here on this sheet of paper. You need to head southeast to the Azurelode Mine and report to Captain Keyton. Southeast is that way *you point southeast*.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[48218] = { -- Kingslayer Orkus
		["names"] = {
			"Your feet are touching the ground, Orkus. This is shallow water. Just stand up and walk to shore.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[52207] = { -- Nagala Whipshank
		["names"] = {
			"I'm ready to ride.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[52220] = { -- Rocco Whipshank
		["names"] = {
			"I'm ready. Let's go!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[61348] = { -- Lorewalker Cho (Mogu'shan Vaults)
		["names"] = {
			"What are you waiting for? Let's go investigate!",
			"Go ahead and turn this thing on.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[66824] = { -- Grand Master Obalis
		["names"] = {
			"Think you can take me in a pet battle?  Let's fight!", -- The extra space here is critical.
		},
		["confirm"] = "Come at me!",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[88228] = { -- Sergeant Grimjaw
		["names"] = {
			"Prepare to battle the Gorens.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[152993] = { -- Garona Halforcen (Vision of Orgrimmar)
		["names"] = {
			"You have my aid. <Help Garona up>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[156327] = { -- Voitha
		["names"] = {
			"I will retrieve the scrolls.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[158765] = { -- Pelodis
		["names"] = {
			"I'm ready for formation training.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[169027] = { -- Helpful Steward (for the fixes)
		["names"] = {
			"Can you help with this problem?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[169078] = { -- Helpful Steward (to get them to follow you)
		["names"] = {
			"Can you help me with something?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[141488] = { -- Zidormi (Tirisfal Glades)
		["names"] = {
			"Can you show me what Tirisfal Glades was like before the Battle for Lordaeron?",
			"Can you return me to the present time?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[160272] = { -- Kynthia
		["names"] = {
			"Let us begin.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[171747] = { -- Project Lead Allen
		["names"] = {
			"I will assist you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[166148] = { -- Sawn
		["names"] = {
			"I will assist you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[152418] = { -- Gallath
		["names"] = {
			"Yes, I will help.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[172259] = { -- Duskleaf
		["names"] = {
			"Yes, I will help.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[165966] = { -- Khaliiq
		["names"] = {
			"Hide me in the shadows, Khaliiq.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[172714] = { -- Trapped Caretaker
		["names"] = {
			"I've cleared a path for you. You should leave.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[170928] = { -- Amberfoot
		["names"] = {
			"I'm ready for the disguise.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[169917] = { -- Avowed Ritualist
		["names"] = {
			"I have a soul for you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[165419] = { -- Grand Marshal Mudrag
		["names"] = {
			"I'm ready.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[160917] = { -- Grimshadow
		["names"] = {
			"<Ride Grimshadow.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[171946] = { -- Lady Moonberry
		["names"] = {
			"I'm ready to rain sparkly terror.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[160998] = { -- Altar of the Daredevil
		["names"] = {
			"Put on the Faceless Mask of the Daredevil.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[160961] = { -- Altar of the Dark Imagination
		["names"] = {
			"Put on the Faceless Mask of the Dark Imagination.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[161000] = { -- Altar of the Pained
		["names"] = {
			"Put on the Faceless Mask of the Pained.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[160967] = { -- Altar of the Burned Bridge
		["names"] = {
			"Put on the Faceless Mask of the Burned Bridge.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[160999] = { -- Altar of the Long Night
		["names"] = {
			"Put on the Faceless Mask of the Long Night.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[159504] = { -- Sparring Aspirant
		["names"] = {
			"",
			"I would like to challenge both of you to a spar.",
			"Will you spar with me?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[159505] = { -- Sparring Aspirant
		["names"] = {
			"I would like to challenge both of you to a spar.",
			"Will you spar with me?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[161279] = { -- Sparring Aspirant
		["names"] = {
			"I would like to challenge both of you to a spar.",
			"Will you spar with me?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[78423] = { -- Archmage Khadgar
		["names"] = {
			"FOR AZEROTH!",
		},
		["confirm"] = "You are about to embark on a dangerous mission, and you may not be able to return immediately. Are you sure?",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[78556] = { -- Ariok
		["names"] = {
			"Khadgar has asked us to go distract the Eye of Kilrogg.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[78568] = { -- Ariok
		["names"] = {
			"Yes. I need you to help me operate that enormous tank.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[80225] = { -- Skaggit
		["names"] = {
			"Get the peons back to work.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[86775] = { -- Senior Peon II
		["names"] = {
			"Gazlowe needs you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[169273] = { -- Silkstrider Caretaker
		["names"] = {
			"You're safe now.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[73629] = { -- Hopswift
		["names"] = {
			"Use the mail service.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[69565] = { -- Scout Captain Elsia
		["names"] = {
			"Here are the explosives, Elsia.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[69810] = { -- Taoshi
		["names"] = {
			"Alright. Let's go.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[70297] = { -- Taoshi
		["names"] = {
			"I'm with you. Let's break into that shipyard! [Queue for solo instance.]",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[67990] = { -- Lor'themar Theron
		["names"] = {
			"I am ready to launch the assault [Queue for solo instance.]",
			"I'm ready to tear down the wall! [Queue for solo instance.]",
			"I am ready! [Queue for solo instance.]",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[69620] = { -- Scout Captain Elsia
		["names"] = {
			"I am ready.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[70358] = { -- Scout Captain Elsia
		["names"] = {
			"I'm ready to go.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[70371] = { -- Lor'themar Theron
		["names"] = {
			"I am ready! [Queue for solo instance.]",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[149626] = { -- Vanguard Battlemage (Alliance)
		["names"] = {
			"I must help Khadgar. Send me to the Blasted Lands!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[79243] = { -- Baros Alexston
		["names"] = {
			"We have everything we need. It's time to build the garrison.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[84455] = { -- Assistant Brightstone
		["names"] = {
			"Time to get back to work.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[81441] = { -- Shelly Hamby
		["names"] = {
			"Gather Shelly's report.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[72871] = { -- All-Seeing Eye
		["names"] = {
			"Begin the compulsion of the All-Seeing Eye.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[167032] = { -- Chromie
		["names"] = {
			"Select a different timeline.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[42383] = { -- Transient
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LALT",
	},
	[42384] = { -- Homeless Stormwind Citizen
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LALT",
	},
	[42386] = { -- Homeless Stormwind Citizen
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LALT",
	},
	[42391] = { -- West Plains Drifter
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LALT",
	},
	[160121] = { -- Master Sha'lor
		["names"] = {
			"I need a flute.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[166980] = { -- Lady Jaina Proudmoore
		["names"] = {
			"I am ready.",
			"Tell me about this place.",
			"Tell me more of the Jailer.",
			"What about the others who were taken?",
			"<Lie low and observe.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[165918] = { -- Highlord Darion Mograine
		["names"] = {
			"Make it talk.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[174871] = { -- Fatescribe Roh-Tahl
		["names"] = {
			"I am ready to choose my fate in the Shadowlands.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[159478] = { -- Tal-Inara
		["names"] = {
			"Show me how I can help the Shadowlands.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[158765] = { -- Pelodis
		["names"] = {
			"Everything is in place for the repair.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[157696] = { -- Nemea
		["names"] = {
			"I choose the larion.",
		},
		["confirm"] = "Are you sure? You will not be able to change your decision on this character.",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[165052] = { -- Vial Master Lurgy
		["names"] = {
			"Is there any way I can help?",
			"O.K.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[157313] = { -- Foul-Tongue Cyrlix
		["names"] = {
			"Is there any way I can help?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[157945] = { -- Boil Master Yetch
		["names"] = {
			"Is there any way I can help?",
			"O.K.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[159824] = { -- Gunn Gorgebone
		["names"] = {
			"Is there anything you need?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[159827] = { -- Scrapper Minoire
		["names"] = {
			"Is there anything you need?",
			"Here are the enhancers you wanted.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[159696] = { -- Rencissa the Dynamo
		["names"] = {
			"Is there anything you need?",
			"Here--this is the biggest rock I could find.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[161710] = { -- Marcel Mullby
		["names"] = {
			"I have some bloodtusk skulls for you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[163084] = { -- Tester Sahaari
		["names"] = {
			"Very well. Let us fight.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[163083] = { -- Valuator Malus
		["names"] = {
			"Very well. Let us fight.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[164492] = { -- Arena Spectator
		["names"] = {
			"Au'narim claims you owe her anima.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[164507] = { -- Arena Spectator
		["names"] = {
			"Au'narim claims you owe her anima.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[164508] = { -- Arena Spectator
		["names"] = {
			"Au'narim claims you owe her anima.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
	[166657] = { -- Ta'eran
		["names"] = {
			"Tell me about this opportunity.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LALT",
	},
};

t.confirms = confirms; -- Add the confirms array to the table, t.