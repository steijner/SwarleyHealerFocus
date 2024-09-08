--Addon "Swarley Healer Focus" created by Swarley (Swarley-Twisting Nether)

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

	macrosChanged = 0;

	--Loop all macros
	for i=1,150 do 
		body = GetMacroBody(i)
		if body ~= nil then
			-- Only edit macros that has /click focushealer inside
			if string.find(body, "/click focushealer") then
				-- If anything with arena is inside, replace the first char after arena to current healernumber
				if string.find(body, "arena") then
					idx = string.find(body, "arena")
					-- Replace first char after arena in macro body
					body = body:sub(1, idx+4) .. healernumber .. body:sub(idx+6)
					EditMacro(i,nil,nil,body,nil)

					macrosChanged = macrosChanged + 1;
				end
			end
		end
	end
	if macrosChanged > 0 then
		print("Updated \124cffFF0000" .. macrosChanged .. "\124r macros to: \124cFF00FF00arena" .. healernumber .. "\124r")
	end
end)