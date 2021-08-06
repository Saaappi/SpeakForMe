local addonName, t = ...
local events = {
	"GOSSIP_CONFIRM",
	"GOSSIP_CONFIRM_CANCEL",
	"GOSSIP_SHOW",
	"MODIFIER_STATE_CHANGED",
}

t.events = events