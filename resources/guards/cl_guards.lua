ymapPedTab = {}

Guards = {
        {84.2906952, 3599.07666, 41.5354271, 179.999664, 850468060, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedGuards0'},
        {74.59108, 3598.61353, 41.511837, 179.999664, 1032073858, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedGuards1'},
        {129.298859, -1028.99573, 29.3572826, -22.0260715, 1490458366, 'None', 0, 'WEAPON_CARBINERIFLE', 'yMapPedGuards2'},
        {134.433228, -1030.65613, 29.3550014, -14.5315495, 1490458366, 'None', 0, 'WEAPON_CARBINERIFLE', 'yMapPedGuards3'},
}

local firstspawn = false


    Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
				if firstspawn == false then
					for k,v in pairs(Guards) do
							
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
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a safezone guard", 255, 255, 255, false)
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