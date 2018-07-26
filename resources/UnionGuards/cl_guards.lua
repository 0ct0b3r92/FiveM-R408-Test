ymapPedTab = {}

unionguards = {
        {1662.28149, 49.2783356, 174.913147, -50.9951935, 1644266841, 'None', 0, 'WEAPON_COMBATPDW', 'yMapPedunionguards0'},
        {1679.27991, -64.20749, 176.4004, -119.202026, 349680864, 'None', 0, 'WEAPON_COMBATPDW', 'yMapPedunionguards1'},
        {1673.82837, -75.34056, 176.320816, -109.999832, -2039072303, 'None', 0, 'WEAPON_COMBATPDW', 'yMapPedunionguards2'},
}

local firstspawn = false


    Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
				if firstspawn == false then
					for k,v in pairs(unionguards) do
							
						local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
						RequestModel(hash)
						while not HasModelLoaded(hash) do
							Citizen.Wait(100)
						end
						pedname = CreatePed(-1, hash, x, y, z - 1, h, false, false)
						relationship = tonumber(relationship)
						AddRelationshipGroup("guards")
						SetRelationshipBetweenGroups(0, GetHashKey("guards"), GetHashKey("PLAYER")) -- guards love players
						SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("guards")) -- Player Loves guards
						SetRelationshipBetweenGroups(5, GetHashKey("guards"), GetHashKey("zombeez")) -- merryweather hate Zombies
						SetRelationshipBetweenGroups(5, GetHashKey("guards"), GetHashKey("looters")) -- merryweather hate looters
						SetPedRelationshipGroupHash(pedname, GetHashKey("guards"))
						TaskStartScenarioInPlace(pedname, action, 0, true)
						SetPedArmour(pedname, 100)
						SetPedAccuracy(pedname, 75)
						SetPedFleeAttributes(pedname, 0, 0)
						SetPedCombatAttributes(pedname, 46, 1)
						SetPedCombatAttributes(pedname, 1424, 0)
						SetPedCombatAttributes(pedname, 5, 1)
						SetPedCombatAbility(pedname, 100)
						SetPedCombatMovement(pedname, 3)
						SetPedCombatRange(pedname, 2)
						SetPedTargetLossResponse(pedname, 2)
						SetPedAlertness(pedname, 3)
						SetPedConfigFlag(pedname, 100, 1)
						SetEntityInvincible(pedname, true)
						SetEntityMaxSpeed(pedname, 0.00)
						if weapon == 'WEAPON_UNARMED' then
						else
							GiveWeaponToPed(pedname, GetHashKey(weapon), 9999, true, true)
						end
						table.insert(ymapPedTab, pedname)
						
						firstspawn = true
					end
				end
		end
	end)

	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, pedname in pairs(ymapPedTab) do
			AddRelationshipGroup("guards")
			SetRelationshipBetweenGroups(0, GetHashKey("guards"), GetHashKey("PLAYER")) -- guards love players
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("guards")) -- Player Loves guards
			SetRelationshipBetweenGroups(5, GetHashKey("guards"), GetHashKey("zombeez")) -- merryweather hate Zombies
			SetRelationshipBetweenGroups(5, GetHashKey("guards"), GetHashKey("looters")) -- merryweather hate looters
			TaskStartScenarioInPlace(pedname, action, 0, true)
			SetPedArmour(pedname, 100)
			SetPedAccuracy(pedname, 75)
			SetPedFleeAttributes(pedname, 0, 0)
			SetPedCombatAttributes(pedname, 46, 1)
			SetPedCombatAttributes(pedname, 1424, 0)
			SetPedCombatAttributes(pedname, 5, 1)
			SetPedCombatAbility(pedname, 100)
			SetPedCombatMovement(pedname, 3)
			SetPedCombatRange(pedname, 2)
			SetPedTargetLossResponse(pedname, 2)
			SetPedAlertness(pedname, 3)
			SetPedConfigFlag(pedname, 100, 1)
			SetEntityInvincible(pedname, true)
			SetEntityMaxSpeed(pedname, 0.00)
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a san andreas union guard", 255, 255, 255, false)
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