--Addon "Swarley Healer Focus" created by Swarley (Swarley-Twisting Nether)
--Based on the code from "Arena Focus Swap" created by Humerx (Humerx-Stormscale)

local f = CreateFrame("Frame")

f:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

f:SetScript("OnEvent",function(self, event, ...)

	isArena, isRegistered = IsActiveBattlefieldArena();
	
	if (event == "PLAYER_ENTERING_WORLD") and (isArena == false) then
		healernumber = 0
		healerpresent = false
	end

	if event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" then
		numOpps = GetNumArenaOpponentSpecs()
		for i=1, numOpps do
			local specID = GetArenaOpponentSpec(i)        
			local _, _, _, _, role, _, _ = GetSpecializationInfoByID(specID) 
			if role == "HEALER" then
				healernumber = i
				healerpresent = true
			end
		end
	end

	--Setup clickable frame we will use to set focus
	text = "/focus arena".. healernumber

	----------------------------------------------------------------
	if AHF == nil then
		AHF = CreateFrame("Button","focushealer", UIParent,"SecureActionButtonTemplate")
		AHF:SetAttribute("type", "macro")
	end
	
	AHF:SetAttribute("macrotext", text)

end)