ymapPedTab = ymapPedTab or {}
workers = workers or {}
	
NGFGuards = {
        {803.6949, 1270.25159, 360.352173, -89.9802551, 1581098148, 'None', 0, 'WEAPON_MINIGUN', 'yMapPedNGFGuards0'},
        {804.2059, 1281.6167, 360.3291, -99.98025, 1581098148, 'None', 0, 'WEAPON_MINIGUN', 'yMapPedNGFGuards1'},
        {739.3171, 1317.18579, 369.017273, 5.019547, 1581098148, 'None', 0, 'WEAPON_MINIGUN', 'yMapPedNGFGuards2'},
        {658.828064, 1274.07861, 368.2965, 100.017914, 1581098148, 'None', 0, 'WEAPON_RAILGUN', 'yMapPedNGFGuards3'},
        {781.256, 1274.655, 361.2877, -79.98028, 1581098148, 'None', 0, 'WEAPON_MINIGUN', 'yMapPedNGFGuards4'},
        {803.17865, 1284.63147, 370.651367, -89.98019, 1581098148, 'None', 0, 'WEAPON_RAILGUN', 'yMapPedNGFGuards5'},
        {781.179138, 1296.49036, 361.3654, -174.980072, 1581098148, 'None', 0, 'WEAPON_MINIGUN', 'yMapPedNGFGuards6'},
        {406.726379, 1228.66272, 257.284241, -174.9806, 1581098148, 'None', 0, 'WEAPON_MINIGUN', 'yMapPedNGFGuards7'},
}

NGFWorkers = {
	{750.874756, 1274.22668, 360.296661, -89.99982, -166363761, 'WORLD_HUMAN_WELDING', 0, 'WEAPON_UNARMED', 'yMapPedentities27'},
	{769.5777, 1279.952, 360.296661, -94.99987, -166363761, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities28'},
	{782.144, 1275.8512, 360.296661, -87.5511551, -166363761, 'WORLD_HUMAN_VEHICLE_MECHANIC', 0, 'WEAPON_UNARMED', 'yMapPedentities29'},
	{724.5323, 1290.29431, 360.296, 54.99996, -166363761, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities30'},
}


local firstspawn = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if firstspawn == false then
			for k,v in pairs(NGFGuards) do
				local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Citizen.Wait(100)
				end
				pedname = CreatePed(-1, hash, x, y, z - 1, h, false, false)
				relationship = tonumber(relationship)
				AddRelationshipGroup("NGF")
				SetRelationshipBetweenGroups(5, GetHashKey("NGF"), GetHashKey("PLAYER")) -- NGF hate players
				SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("NGF")) -- Player Hates NGF
				SetRelationshipBetweenGroups(5, GetHashKey("NGF"), GetHashKey("zombeez")) -- NGF hate Zombies
				SetPedRelationshipGroupHash(pedname, GetHashKey("NGF"))
				--TaskStartScenarioInPlace(pedname, action, 0, true)
				--TaskWanderInArea(pedname, 686.00, 136.00, 85.00, 100, 0, 0)
				--TaskWanderStandard(pedname, 10, 10)
				--SetPedKeepTask(pedname, true)
				SetPedArmour(pedname, 100)
				SetPedAccuracy(pedname, 100)
				SetPedSeeingRange(pedname, 500.0)
				SetPedHearingRange(pedname, 1000.0)
				SetPedFleeAttributes(pedname, 0, 0)
				SetPedCombatAttributes(pedname, 46, 1)
				SetPedCombatAttributes(pedname, 1424, 0)
				SetPedCombatAttributes(pedname, 5, 1)
				SetPedCombatAbility(pedname, 100)
				SetPedCombatMovement(pedname, 3)
				SetPedAsEnemy(pedname, true)
				SetPedCombatRange(pedname, 2)
				SetPedTargetLossResponse(pedname, 2)
				SetPedAlertness(pedname, 3)
				SetPedConfigFlag(pedname, 100, 1)
				SetEntityHealth(pedname, 500)
				SetEntityProofs(pedname, true, true, false, true, true, true, 1, false)
				SetPedInfiniteAmmoClip(pedname, true)
				SetPedInfiniteAmmo(pedname, true)
				SetEntityMaxSpeed(pedname, 0.00)
				SetAiMeleeWeaponDamageModifier(2.0)
				SetAiWeaponDamageModifier(5.0)
				
				if weapon == 'WEAPON_UNARMED' then
				else
					GiveWeaponToPed(pedname, GetHashKey(weapon), 9999, true, true)
				end
				table.insert(ymapPedTab, pedname)
				
				firstspawn = true
			end
			for k,v in pairs(NGFWorkers) do
				local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Citizen.Wait(1)
				end
				pedname = CreatePed(-1, hash, x, y, z - 1, h, false, false)
				relationship = tonumber(relationship)
				AddRelationshipGroup("scenepeds")
				SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("PLAYER")) -- guards love players
				SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("scenepeds")) -- Player Loves guards
				SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("zombeez")) -- merryweather hate Zombies
				SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("guards")) -- merryweather hate Zombies
				SetPedRelationshipGroupHash(pedname, GetHashKey("scenepeds"))
				TaskStartScenarioInPlace(pedname, action, 0, true)
				SetPedFleeAttributes(pedname, 0, 0)
				SetPedKeepTask(pedname, true)
				SetEntityInvincible(pedname, true)
				SetEntityMaxSpeed(pedname, 0.00)
				if weapon == 'WEAPON_UNARMED' then
				else
					GiveWeaponToPed(pedname, GetHashKey(weapon), 9999, true, true)
				end
				table.insert(workers, pedname)
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, pedname in pairs(ymapPedTab) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "an NGF guard", 255, 0, 0, false)
			end
						
			-- Make sure attributes are applied after spawning
			SetRelationshipBetweenGroups(5, GetHashKey("NGF"), GetHashKey("PLAYER")) -- NGF hate players
			SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("NGF")) -- Player Hates NGF
			SetRelationshipBetweenGroups(5, GetHashKey("NGF"), GetHashKey("zombeez")) -- NGF hate Zombies
			SetPedRelationshipGroupHash(pedname, GetHashKey("NGF"))
			--TaskStartScenarioInPlace(pedname, action, 0, true)
			--TaskWanderInArea(pedname, 686.00, 136.00, 85.00, 100, 0, 0)
			--TaskWanderStandard(pedname, 10, 10)
			--SetPedKeepTask(pedname, true)
			SetPedArmour(pedname, 100)
			SetPedAccuracy(pedname, 50)
			SetPedSeeingRange(pedname, 100.0)
			SetPedHearingRange(pedname, 500.0)
			SetPedFleeAttributes(pedname, 0, 0)
			SetPedCombatAttributes(pedname, 46, 1)
			SetPedCombatAttributes(pedname, 1424, 0)
			SetPedCombatAttributes(pedname, 5, 1)
			SetPedCombatAbility(pedname, 100)
			SetPedCombatMovement(pedname, 3)
			SetPedAsEnemy(pedname, true)
			SetPedCombatRange(pedname, 2)
			SetPedTargetLossResponse(pedname, 2)
			SetPedAlertness(pedname, 3)
			SetPedConfigFlag(pedname, 100, 1)
			SetEntityHealth(pedname, 500)
			SetEntityProofs(pedname, true, true, false, true, true, true, 1, false)
			SetPedInfiniteAmmoClip(pedname, true)
			SetPedInfiniteAmmo(pedname, true)
			SetEntityMaxSpeed(pedname, 0.00)
			SetAiMeleeWeaponDamageModifier(2.0)
			SetAiWeaponDamageModifier(5.0)
		end
		for i, pedname in pairs(workers) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "an NGF worker", 255, 255, 0, false)
			end
			
			AddRelationshipGroup("scenepeds")
			SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("PLAYER")) -- guards love players
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("scenepeds")) -- Player Loves guards
			SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("zombeez")) -- merryweather hate Zombies
			SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("guards")) -- merryweather hate Zombies
			SetPedRelationshipGroupHash(pedname, GetHashKey("scenepeds"))
			TaskStartScenarioInPlace(pedname, action, 0, true)
			SetPedFleeAttributes(pedname, 0, 0)
			SetPedKeepTask(pedname, true)
			SetEntityInvincible(pedname, true)
			SetEntityMaxSpeed(pedname, 0.00)
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