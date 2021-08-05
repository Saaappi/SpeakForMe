--[[
	The purpose of the addon is to automatically accept specific gossip confirmations.
]]--

--[[ TODO
]]--

--[[
	These variables are provided to the addon by Blizzard.
		addonName	: This is self explanatory, but it's the name of the addon.
		t			: This is an empty table. This is how the addon can communicate between files or local functions, sort of like traditional classes.
]]--
local addonName, t = ...;
local e = CreateFrame("Frame"); -- This is the invisible frame that will listen for registered events.
local modKeyPressed = false; -- If the mod key is pressed, then automation should be disabled.
local unusedCreatures = {
	1,
	2,
}

-- Loop over the t.events array from the Events.lua file and register each event to the ScriptHandler.
for _, event in ipairs(t.events) do
	e:RegisterEvent(event);
end

-- Functions
local function GossipFrameOptionsUpdate(npcID)
	local gossipOptions = C_GossipInfo.GetOptions() -- Get all information about the available options.
	local index = 1
	
	for index, optionInfoTable in ipairs(gossipOptions) do -- Iterate over the Options table.
		for key, _ in pairs(t.confirms) do -- Iterate over the t.confirms table, checking the "name" field to match against the available options.
			if key == npcID then -- The target's ID is in the table, so use its configuration.
				for i = 1, #t.confirms[key]["names"] do
					if (string.find(optionInfoTable["name"], t.confirms[key]["names"][i])) then -- If the current gossip option is in the names subtable.
						C_GossipInfo.SelectOption(index); -- Select the option since we found a match.
					end
				end
			else -- The target isn't in the table on its own, so check other options.
				for i = 1, #unusedCreatures do
					for j = 1, #t.confirms[i]["names"] do
						if (string.find(optionInfoTable["name"], t.confirms[i]["names"][j])) then -- If the current gossip option is in the names subtable.
							C_GossipInfo.SelectOption(index); -- Select the option since we found a match.
						end
					end
				end
			end
		end
	end
end

e:SetScript("OnEvent", function(self, event, ...) -- This adds an 'OnEvent' ScriptHandler to the frame to listen for events, and then call a function.
	if (event == "GOSSIP_CONFIRM" or event == "GOSSIP_CONFIRM_CANCEL") then
		StaticPopup1Button1:Click()
	end
	
	if event == "GOSSIP_SHOW" then
		if modKeyPressed then -- Do nothing...
		else
			local unitGUID = UnitGUID("target") or UnitGUID("mouseover");
			if unitGUID then
				local _, _, _, _, _, npcID = strsplit("-", unitGUID);
				npcID = tonumber(npcID); -- npcID is a string first. The key is a number.
				GossipFrameOptionsUpdate(npcID);
			end
		end
	end
	
	if event == "MODIFIER_STATE_CHANGED" then
		local button, state = ...;
		for key, _ in pairs(t.confirms) do -- Iterate over the t.confirms table, checking the "name" field to match against the available options.
			if button == t.confirms[key]["mod"] and state == 1 then
				modKeyPressed = true;
			else
				modKeyPressed = false;
			end
		end
	end
end);