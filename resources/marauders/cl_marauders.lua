ymapPedTab = {}

marauders = {
        {498.727661, 5589.73633, 794.765869, 89.99988, 1787764635, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedmarauders0'},
        {488.957123, 5587.73047, 794.1507, -55.7280426, 390939205, 'None', 0, 'WEAPON_SNSPISTOL', 'yMapPedmarauders1'},
        {501.982819, 5604.66357, 797.9121, 124.991035, 32417469, 'None', 0, 'WEAPON_VINTAGEPISTOL', 'yMapPedmarauders2'},
        {487.178467, 5595.128, 793.4742, -69.99993, 62440720, 'None', 0, 'WEAPON_SAWNOFFSHOTGUN', 'yMapPedmarauders3'},
        {495.66275, 5594.0083, 795.0432, 174.999634, 193817059, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedmarauders4'},
        {454.297638, 5566.979, 781.1841, -19.0232925, 193817059, 'None', 0, 'WEAPON_MARKSMANPISTOL', 'yMapPedmarauders5'},
        {493.544281, 5579.36865, 792.442932, 11.5456133, 131961260, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedmarauders6'},
}

local firstSpawn = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if firstSpawn == false then
			for k,v in pairs(marauders) do
				local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Citizen.Wait(100)
				end
				marauder = CreatePed(-1, hash, x, y, z, h, false, false)
				relationship = tonumber(relationship)
				AddRelationshipGroup("marauders")
				SetRelationshipBetweenGroups(5, GetHashKey("marauders"), GetHashKey("PLAYER")) -- marauders hate players
				SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("marauders")) -- Player Hates marauders
				SetRelationshipBetweenGroups(5, GetHashKey("marauders"), GetHashKey("zombeez")) -- marauders hate Zombies
				SetPedRelationshipGroupHash(marauder, GetHashKey("marauders"))
				--TaskStartScenarioInPlace(marauder, action, 0, true)
				TaskWanderInArea(pedname, x, y, z, 100, 10, 10)
				--TaskWanderStandard(marauder, 10, 10)
				SetPedKeepTask(marauder, true)
				SetPedArmour(marauder, 0)
				SetPedAccuracy(marauder, 1)
				SetPedSeeingRange(marauder, 10.0)
				SetPedHearingRange(marauder, 100.0)
				SetPedFleeAttributes(marauder, 0, 0)
				SetPedCombatAttributes(marauder, 46, 1)
				SetPedCombatAttributes(marauder, 1424, 0)
				SetPedCombatAttributes(marauder, 5, 1)
				SetPedCombatAbility(marauder, 100)
				SetPedCombatMovement(marauder, 3)
				SetPedAsEnemy(marauder, true)
				SetPedCombatRange(marauder, 2)
				SetPedTargetLossResponse(marauder, 2)
				SetPedAlertness(marauder, 3)
				SetPedConfigFlag(marauder, 100, 1)
				SetEntityHealth(marauder, 200)
				SetAiMeleeWeaponDamageModifier(1.0)
				SetAiWeaponDamageModifier(0.5)
				if weapon == 'WEAPON_UNARMED' then
				else
					GiveWeaponToPed(marauder, GetHashKey(weapon), 9999, true, true)
				end
				table.insert(ymapPedTab, marauder)
				
				firstSpawn = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, marauder in pairs(ymapPedTab) do
				AddRelationshipGroup("marauders")
				SetRelationshipBetweenGroups(5, GetHashKey("marauders"), GetHashKey("PLAYER")) -- marauders hate players
				SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("marauders")) -- Player Hates marauders
				SetRelationshipBetweenGroups(5, GetHashKey("marauders"), GetHashKey("zombeez")) -- marauders hate Zombies
				SetPedRelationshipGroupHash(marauder, GetHashKey("marauders"))
				--TaskStartScenarioInPlace(marauder, action, 0, true)
				SetPedKeepTask(marauder, true)
				SetPedArmour(marauder, 0)
				SetPedAccuracy(marauder, 1)
				SetPedSeeingRange(marauder, 10.0)
				SetPedHearingRange(marauder, 100.0)
				SetPedFleeAttributes(marauder, 0, 0)
				SetPedCombatAttributes(marauder, 46, 1)
				SetPedCombatAttributes(marauder, 1424, 0)
				SetPedCombatAttributes(marauder, 5, 1)
				SetPedCombatAbility(marauder, 100)
				SetPedCombatMovement(marauder, 3)
				SetPedAsEnemy(marauder, true)
				SetPedCombatRange(marauder, 2)
				SetPedTargetLossResponse(marauder, 2)
				SetPedAlertness(marauder, 3)
				SetPedConfigFlag(marauder, 100, 1)
				SetEntityHealth(marauder, 200)
				SetAiMeleeWeaponDamageModifier(1.0)
				SetAiWeaponDamageModifier(0.5)
				
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(marauder, true))
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
					DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a marauder", 255, 0, 0, false)
				end
		end
	end
end)


-- Handles 3D Text above AI
function DrawText3d(x,y,z, size, font, text, r, g, b, outline)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	
	if onScreen then
		SetTextScale(size*scale, size*scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		if not outline then
			SetTextDropshadow(0, 0, 0, 0, 55)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
		end
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end