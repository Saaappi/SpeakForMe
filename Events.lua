--[[
	These variables are provided to the addon by Blizzard.
		addonName	: This is self explanatory, but it's the name of the addon.
		t			: This is an empty table. This is how the addon can communicate between files or local functions, sort of like traditional classes.
]]--
local addonName, t = ...;

local events = { -- An integer-indexed array of the events that should be registered to the addon's ScriptHandler.
	"GOSSIP_CONFIRM",
	"GOSSIP_CONFIRM_CANCEL",
	"GOSSIP_SHOW",
	"MODIFIER_STATE_CHANGED",
};

t.events = events; -- Add the events array to the table, t, to be used in FindDuplicates.lua.