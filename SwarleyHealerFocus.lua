--Addon "Swarley Healer Focus" created by Swarley (Swarley-Twisting Nether)
--Based on the code from "Arena Focus Swap" created by Humerx (Humerx-Stormscale)

--Setting up slash commands
--SLASH_Swarleyhealerfocus = "/shf"
--SlashCmdList["Swarleyhealerfocus"] = function()
--	shfdebug = true
--	print("DEBUG Swarleyhealerfocus ON")
--end

--print("korv")

local f = CreateFrame("Frame")

f:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
f:RegisterEvent("UNIT_NAME_UPDATE")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

f:SetScript("OnEvent",function(self, event, ...)

	isArena, isRegistered = IsActiveBattlefieldArena();
	
	
	--if event == "GROUP_ROSTER_UPDATE" then
		--partyMembers = GetNumPartyMembers()
		--partyMembers = 0
		--if partyMembers == nil then
			--partyMembers = 0
			--print("partMembers är nil")
		--end
		--partyMembers = partyMembers + 1
	--end

	if (event == "PLAYER_ENTERING_WORLD") and (isArena == false) then
		healernumber = 0
		--print(event)
		healerpresent = false
	end

	--if (event == "GROUP_ROSTER_UPDATE") and (isArena == false) then

		--print(event)

	--end




	if event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" then
		numOpps = GetNumArenaOpponentSpecs()
		--print(numOpps)
		for i=1, numOpps do
			local specID = GetArenaOpponentSpec(i)        
			local _, _, _, _, role, _, _ = GetSpecializationInfoByID(specID) 
			if role == "HEALER" then
				healernumber = i
				healerpresent = true
			end
		end
		
		--if (shfdebug == true) and (healerpresent == true) then
			print("Healer är arena".. healernumber)
		--end
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