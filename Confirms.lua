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
		["mod"] = "LSHIFT",
	},
	[2] = { -- General NPC Gossips (with Cost)
		["names"] = {
			"I'd like to heal and revive my battle pets.",
		},
		["confirm"] = "A small fee for supplies is required.",
		["cost"] = 10000,
		["mod"] = "LSHIFT",
	},
	[3467] = { -- Baron Longshore
		["names"] = {
			"<Break Longshore's manacles and free him.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[9316] = { -- Wenikee Boltbucket
		["names"] = {
			"Send me back to Nozzlepot's Outpost.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[17119] = { -- Ithania
		["names"] = {
			"Balandar sent me to get you out of here and reclaim his cargo. He's waiting for you in Brackenwall Village.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[34258] = { -- Halga Bloodeye
		["names"] = {
			"Yes, I'm ready. Let's do this thing!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[34503] = { -- Razormane Pillager
		["names"] = {
			"<Pound this chump.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[34523] = { -- Captured Razormane
		["names"] = {
			"<Offer food.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[34578] = { -- Rocco Whipshank
		["names"] = {
			"Bring it on, Rocco.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[34674] = { -- Brak Blusterpipe
		["names"] = {
			"I'm ready to teleport. I think.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[34754] = { -- Chief Engineer Foote
		["names"] = {
			"<Club him unconscious.>",
			"<Rifle through his pockets.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[37167] = { -- Stonetalon Prisoner
		["names"] = {
			"I recovered your armor and weapons. Victory or death!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[37570] = { -- Naralex
		["names"] = {
			"I'm ready, Naralex.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[37811] = { -- Warlord Gar'dul
		["names"] = {
			"I'm here on behalf of Warlord Bloodhilt, who wants you to know he will be arriving shortly.",
			"I'll be sure to tell the Taurajo refugees that. Those that lived.",
			"Tell him yourself. He's almost here!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[37847] = { -- Mankrik
		["names"] = {
			"Mahka wants you to come see her, Mankrik.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[38015] = { -- Karthog
		["names"] = {
			"I am ready, Karthog. For the Horde!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[38033] = { -- Awkward Gangly Orc
		["names"] = {
			"What? Who are you? What clan are you from?",
			"You're no orc. You're a spy! Alliance spy!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[44825] = { -- Bat Handler Maggotbreath
		["names"] = {
			"I need to take a bat to the Dawning Isles.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[45752] = { -- Ambermill Dimensional Portal
		["names"] = {
			"<Use the Ambermill Dimensional Portal.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[47442] = { -- Johnny Awesome
		["names"] = {
			"Well, we are having some problems at the Sludge Fields, located northeast of here. Warden Stillwater could use your help.",
			"That's all.",
			"THAT'S ALL, JOHNNY AWESOME. TAKE IT OR LEAVE IT!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[47443] = { -- Kingslayer Orkus
		["names"] = {
			"Um... Apparently there is some trouble at Southshore. Something about worgen insurgents. Maybe you could help with them?",
			"None.",
			"Right, thanks. Just go ahead and head southeast. More south than east. Probably off the coast.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[47444] = { -- Dumass
		["names"] = {
			"Maybe you should go take a nap or something.",
			"Wait a minute.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[48218] = { -- Kingslayer Orkus
		["names"] = {
			"Your feet are touching the ground, Orkus. This is shallow water. Just stand up and walk to shore.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[52207] = { -- Nagala Whipshank
		["names"] = {
			"I'm ready to ride.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[52220] = { -- Rocco Whipshank
		["names"] = {
			"I'm ready. Let's go!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[61348] = { -- Lorewalker Cho (Mogu'shan Vaults)
		["names"] = {
			"What are you waiting for? Let's go investigate!",
			"Go ahead and turn this thing on.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[66824] = { -- Grand Master Obalis
		["names"] = {
			"Think you can take me in a pet battle?  Let's fight!", -- The extra space here is critical.
		},
		["confirm"] = "Come at me!",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[88228] = { -- Sergeant Grimjaw
		["names"] = {
			"Prepare to battle the Gorens.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[152993] = { -- Garona Halforcen (Vision of Orgrimmar)
		["names"] = {
			"You have my aid. <Help Garona up>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[156327] = { -- Voitha
		["names"] = {
			"I will retrieve the scrolls.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[158765] = { -- Pelodis
		["names"] = {
			"I'm ready for formation training.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[169027] = { -- Helpful Steward (for the fixes)
		["names"] = {
			"Can you help with this problem?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[169078] = { -- Helpful Steward (to get them to follow you)
		["names"] = {
			"Can you help me with something?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[141488] = { -- Zidormi (Tirisfal Glades)
		["names"] = {
			"Can you show me what Tirisfal Glades was like before the Battle for Lordaeron?",
			"Can you return me to the present time?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160272] = { -- Kynthia
		["names"] = {
			"Let us begin.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[171747] = { -- Project Lead Allen
		["names"] = {
			"I will assist you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[166148] = { -- Sawn
		["names"] = {
			"I will assist you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[152418] = { -- Gallath
		["names"] = {
			"Yes, I will help.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[172259] = { -- Duskleaf
		["names"] = {
			"Yes, I will help.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[165966] = { -- Khaliiq
		["names"] = {
			"Hide me in the shadows, Khaliiq.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[172714] = { -- Trapped Caretaker
		["names"] = {
			"I've cleared a path for you. You should leave.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[170928] = { -- Amberfoot
		["names"] = {
			"I'm ready for the disguise.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[169917] = { -- Avowed Ritualist
		["names"] = {
			"I have a soul for you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[165419] = { -- Grand Marshal Mudrag
		["names"] = {
			"I'm ready.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160917] = { -- Grimshadow
		["names"] = {
			"<Ride Grimshadow.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[171946] = { -- Lady Moonberry
		["names"] = {
			"I'm ready to rain sparkly terror.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160998] = { -- Altar of the Daredevil
		["names"] = {
			"Put on the Faceless Mask of the Daredevil.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160961] = { -- Altar of the Dark Imagination
		["names"] = {
			"Put on the Faceless Mask of the Dark Imagination.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[161000] = { -- Altar of the Pained
		["names"] = {
			"Put on the Faceless Mask of the Pained.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160967] = { -- Altar of the Burned Bridge
		["names"] = {
			"Put on the Faceless Mask of the Burned Bridge.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160999] = { -- Altar of the Long Night
		["names"] = {
			"Put on the Faceless Mask of the Long Night.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159504] = { -- Sparring Aspirant
		["names"] = {
			"",
			"I would like to challenge both of you to a spar.",
			"Will you spar with me?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159505] = { -- Sparring Aspirant
		["names"] = {
			"I would like to challenge both of you to a spar.",
			"Will you spar with me?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[161279] = { -- Sparring Aspirant
		["names"] = {
			"I would like to challenge both of you to a spar.",
			"Will you spar with me?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[78423] = { -- Archmage Khadgar
		["names"] = {
			"FOR AZEROTH!",
		},
		["confirm"] = "You are about to embark on a dangerous mission, and you may not be able to return immediately. Are you sure?",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[78556] = { -- Ariok
		["names"] = {
			"Khadgar has asked us to go distract the Eye of Kilrogg.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[78568] = { -- Ariok
		["names"] = {
			"Yes. I need you to help me operate that enormous tank.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[80225] = { -- Skaggit
		["names"] = {
			"Get the peons back to work.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[86775] = { -- Senior Peon II
		["names"] = {
			"Gazlowe needs you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[169273] = { -- Silkstrider Caretaker
		["names"] = {
			"You're safe now.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[73629] = { -- Hopswift
		["names"] = {
			"Use the mail service.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[69565] = { -- Scout Captain Elsia
		["names"] = {
			"Here are the explosives, Elsia.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[69810] = { -- Taoshi
		["names"] = {
			"Alright. Let's go.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[70297] = { -- Taoshi
		["names"] = {
			"I'm with you. Let's break into that shipyard! [Queue for solo instance.]",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[67990] = { -- Lor'themar Theron
		["names"] = {
			"I am ready to launch the assault [Queue for solo instance.]",
			"I'm ready to tear down the wall! [Queue for solo instance.]",
			"I am ready! [Queue for solo instance.]",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[69620] = { -- Scout Captain Elsia
		["names"] = {
			"I am ready.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[70358] = { -- Scout Captain Elsia
		["names"] = {
			"I'm ready to go.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[70371] = { -- Lor'themar Theron
		["names"] = {
			"I am ready! [Queue for solo instance.]",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[149626] = { -- Vanguard Battlemage (Alliance)
		["names"] = {
			"I must help Khadgar. Send me to the Blasted Lands!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[79243] = { -- Baros Alexston
		["names"] = {
			"We have everything we need. It's time to build the garrison.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[84455] = { -- Assistant Brightstone
		["names"] = {
			"Time to get back to work.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[81441] = { -- Shelly Hamby
		["names"] = {
			"Gather Shelly's report.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[72871] = { -- All-Seeing Eye
		["names"] = {
			"Begin the compulsion of the All-Seeing Eye.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167032] = { -- Chromie
		["names"] = {
			"Select a different timeline.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[42383] = { -- Transient
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LSHIFT",
	},
	[42384] = { -- Homeless Stormwind Citizen
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LSHIFT",
	},
	[42386] = { -- Homeless Stormwind Citizen
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LSHIFT",
	},
	[42391] = { -- West Plains Drifter
		["names"] = {
			"Maybe a couple copper will loosen your tongue. Now tell me, did you see who killed the Furlbrows?",
		},
		["confirm"] = "Are you sure you want to give this hobo money?",
		["cost"] = 50,
		["mod"] = "LSHIFT",
	},
	[160121] = { -- Master Sha'lor
		["names"] = {
			"I need a flute.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
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
		["mod"] = "LSHIFT",
	},
	[165918] = { -- Highlord Darion Mograine
		["names"] = {
			"Make it talk.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[174871] = { -- Fatescribe Roh-Tahl
		["names"] = {
			"I am ready to choose my fate in the Shadowlands.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159478] = { -- Tal-Inara
		["names"] = {
			"Show me how I can help the Shadowlands.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[158765] = { -- Pelodis
		["names"] = {
			"Everything is in place for the repair.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[157696] = { -- Nemea
		["names"] = {
			"I choose the larion.",
		},
		["confirm"] = "Are you sure? You will not be able to change your decision on this character.",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[165052] = { -- Vial Master Lurgy
		["names"] = {
			"Is there any way I can help?",
			"O.K.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[157313] = { -- Foul-Tongue Cyrlix
		["names"] = {
			"Is there any way I can help?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[157945] = { -- Boil Master Yetch
		["names"] = {
			"Is there any way I can help?",
			"O.K.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159824] = { -- Gunn Gorgebone
		["names"] = {
			"Is there anything you need?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159827] = { -- Scrapper Minoire
		["names"] = {
			"Is there anything you need?",
			"Here are the enhancers you wanted.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159696] = { -- Rencissa the Dynamo
		["names"] = {
			"Is there anything you need?",
			"Here--this is the biggest rock I could find.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[161710] = { -- Marcel Mullby
		["names"] = {
			"I have some bloodtusk skulls for you.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[163084] = { -- Tester Sahaari
		["names"] = {
			"Very well. Let us fight.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[163083] = { -- Valuator Malus
		["names"] = {
			"Very well. Let us fight.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[164492] = { -- Arena Spectator
		["names"] = {
			"Au'narim claims you owe her anima.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[164507] = { -- Arena Spectator
		["names"] = {
			"Au'narim claims you owe her anima.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[164508] = { -- Arena Spectator
		["names"] = {
			"Au'narim claims you owe her anima.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[166657] = { -- Ta'eran
		["names"] = {
			"Tell me about this opportunity.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[157130] = { -- Recruitable Animate
		["names"] = {
			"Maldraxxus needs your service. Will you fight?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[157168] = { -- Stubborn Animate
		["names"] = {
			"Maldraxxus needs your service. Will you fight?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[166129] = { -- Specialist Entra
		["names"] = {
			"What should I do?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159427] = { -- Elder Finnan
		["names"] = {
			"The Lady of the Falls wanted to make sure you were safe.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159465] = { -- Elder Gwenna
		["names"] = {
			"The Lady of the Falls wanted to make sure you were safe.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159428] = { -- Groonoomcrooek
		["names"] = {
			"The Lady of the Falls wanted to make sure you were safe.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167918] = { -- Bela
		["names"] = {
			"<Ask about suspicious activity>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167849] = { -- Soul of Keltesh
		["names"] = {
			"<Ask about suspicious activity>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[156295] = { -- Courier Rokalai
		["names"] = {
			"<Ask about suspicious activity>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167838] = { -- Globknob
		["names"] = {
			"<Ask about suspicious activity>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167717] = { -- Darkhaven Villager
		["names"] = {
			"<Request tithe>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167744] = { -- Darkhaven Villager
		["names"] = {
			"<Request tithe>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[167746] = { -- Darkhaven Villager
		["names"] = {
			"<Request tithe>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[168237] = { -- Ilka
		["names"] = {
			"<Present Lajos's invitation>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[168238] = { -- Samu
		["names"] = {
			"<Present Lajos's invitation>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[169238] = { -- Courier Araak
		["names"] = {
			"Dimwiddle sent me.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[166541] = { -- Cobwobble
		["names"] = {
			"What are you all doing?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[166543] = { -- Dobwobble
		["names"] = {
			"Why are the ones with scribbles interesting?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[166542] = { -- Slobwobble
		["names"] = {
			"Where does the Taskmaster keep the sinstones?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[165921] = { -- Courier Araak
		["names"] = {
			"We are ready. Please tell the Taskmaster the Maw Walker is here.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[164420] = { -- Laurent
		["names"] = {
			"I am ready.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160163] = { -- The Accuser
		["names"] = {
			"I'm ready. Begin the ritual.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160233] = { -- The Accuser
		["names"] = {
			"I'm ready. Begin the ritual.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[172431] = { -- Lady Moonberry
		["names"] = {
			"Lead on.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[158543] = { -- Attendant Sparkledew
		["names"] = {
			"Take me to the Queen's audience chamber, please.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[165550] = { -- Attendant Shimmerwing
		["names"] = {
			"I would like to leave the Queen's audience chamber, please.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[172677] = { -- Niya
		["names"] = {
			"I am ready to begin.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[164079] = { -- Highlord Bolvar Fordragon
		["names"] = {
			"Skip ahead to finish the Torghast chapter and have Torghast, Ve'nari, and the Runecarver unlocked.",
			"Skip ahead to Korthia.",
		},
		["confirm"] = "Are you sure? This action cannot be undone.",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[177136] = { -- Polemarch Adrestes
		["names"] = {
			"<Ask Adrestes what happened in Elysian Hold.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159946] = { -- The Countess
		["names"] = {
			"House Darkvein",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[165662] = { -- The Countess
		["names"] = {
			"<Deliver Prince Renathal's invitation.>",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[159883] = { -- Chancellor Codrin
		["names"] = {
			"You stand accused of conspiring to overthrow The Countess.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160941] = { -- The Curator
		["names"] = {
			"What happened to the Medallion of Avarice?",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[161056] = { -- Guard Captain Elizabeta
		["names"] = {
			"The Curator sent me. I'm looking for Watcher Emil.",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
	[160956] = { -- Watcher Emil
		["names"] = {
			"Let's go!",
		},
		["confirm"] = "",
		["cost"] = 0,
		["mod"] = "LSHIFT",
	},
};

t.confirms = confirms; -- Add the confirms array to the table, t.