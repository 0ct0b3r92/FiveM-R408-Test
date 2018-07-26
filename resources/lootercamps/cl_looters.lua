ymapPedTab = ymapPedTab or {}
	
looters = {
        {710.66394, 120.166168, 80.7899857, 81.40775, 850468060, 'None', 5, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters0'},
        {668.430664, 105.57029, 80.75452, 0, 1032073858, 'None', 5, 'WEAPON_HEAVYPISTOL', 'yMapPedlooters1'},
        {681.9974, 96.31251, 80.75452, 0, 1330042375, 'None', 5, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters2'},
        {666.095, 136.62616, 80.75452, -119.999725, 850468060, 'None', 5, 'WEAPON_COMBATPDW', 'yMapPedlooters3'},
        {716.8257, 149.25972, 80.75452, 79.9999, 275618457, 'None', 5, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters4'},
        {703.5929, 147.978592, 80.75452, -84.99989, 2119136831, 'None', 5, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters5'},
        {722.472168, 116.759781, 81.2593842, -134.99971, -1872961334, 'WORLD_HUMAN_CLIPBOARD', 5, 'WEAPON_SNSPISTOL', 'yMapPedlooters6'},
        {702.0586, 93.99837, 80.75452, 64.99994, 2119136831, 'None', 5, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters7'},
        {716.5403, 153.166733, 83.75499, 139.999725, -984709238, 'None', 5, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters8'},
        {997.569763, -1568.30115, 35.4685059, 175.00029, 62440720, 'None', 5, 'WEAPON_MINISMG', 'yMapPedlooters9'},
        {1004.525, -1571.59949, 30.8146324, 0, 1032073858, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters10'},
        {911.972046, -1600.89954, 38.0104065, 0, 1032073858, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters11'},
        {958.8929, -1600.31873, 38.0104065, -5.00895567E-06, 1330042375, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedlooters12'},
        {970.920532, -1534.81677, 31.1821537, 174.675323, 850468060, 'None', 0, 'WEAPON_COMBATPDW', 'yMapPedlooters13'},
        {936.8369, -1517.76575, 31.0065155, 0, 1330042375, 'None', 0, 'WEAPON_SNSPISTOL', 'yMapPedlooters14'},
        {956.5212, -1492.30261, 30.9762268, 169.999649, 1032073858, 'None', 0, 'WEAPON_PISTOL50', 'yMapPedlooters15'},
        {978.6496, -1505.65845, 31.4502716, 101.550041, -44746786, 'None', 0, 'WEAPON_CARBINERIFLE', 'yMapPedlooters16'},
        {952.8362, -1512.61584, 31.0650234, 0, 1330042375, 'None', 0, 'WEAPON_ADVANCEDRIFLE', 'yMapPedlooters17'},
        {949.3063, -1548.363, 30.77051, -94.99981, 850468060, 'None', 0, 'WEAPON_COMPACTRIFLE', 'yMapPedlooters18'},
}


local looterBases = {
	{id=66, x= 686.00, y= 136.00, z= 85.00},
	{id=66, x= 970.73, y= -1559.78, z= 30.60},
}

local firstspawn = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if firstspawn == false then
			for k,v in pairs(looters) do
				local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Citizen.Wait(10)
				end
				pedname = CreatePed(-1, hash, x, y, z, h, false, false)
				relationship = tonumber(relationship)
				AddRelationshipGroup("looters")
				SetRelationshipBetweenGroups(5, GetHashKey("looters"), GetHashKey("PLAYER")) -- looters hate players
				SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("looters")) -- Player Hates looters
				SetRelationshipBetweenGroups(5, GetHashKey("looters"), GetHashKey("zombeez")) -- looters hate Zombies
				SetPedRelationshipGroupHash(pedname, GetHashKey("looters"))
				--TaskStartScenarioInPlace(pedname, action, 0, true)
				--TaskWanderInArea(pedname, 686.00, 136.00, 85.00, 100, 0, 0)
				TaskWanderStandard(pedname, 10, 10)
				SetPedKeepTask(pedname, true)
				SetPedArmour(pedname, 0)
				SetPedAccuracy(pedname, 1)
				SetPedSeeingRange(pedname, 50.0)
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
				SetEntityHealth(pedname, 200)
				SetAiMeleeWeaponDamageModifier(1.0)
				SetAiWeaponDamageModifier(0.5)
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

-- Handles the nametags
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, pedname in pairs(ymapPedTab) do
			AddRelationshipGroup("looters")
			SetRelationshipBetweenGroups(5, GetHashKey("looters"), GetHashKey("PLAYER")) -- looters hate players
			SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("looters")) -- Player Hates looters
			SetRelationshipBetweenGroups(5, GetHashKey("looters"), GetHashKey("zombeez")) -- looters hate Zombies
			SetPedRelationshipGroupHash(pedname, GetHashKey("looters"))
			SetPedKeepTask(pedname, true)
			SetPedArmour(pedname, 0)
			SetPedAccuracy(pedname, 1)
			SetPedSeeingRange(pedname, 50.0)
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
			SetEntityHealth(pedname, 200)
			SetAiMeleeWeaponDamageModifier(1.0)
			SetAiWeaponDamageModifier(0.5)
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a looter base guard", 255, 0, 0, false)
			end
		end
	end
end)

-- Creates blips
Citizen.CreateThread(function()
	for _, map in pairs(looterBases) do
		map.blip = AddBlipForCoord(map.x, map.y, map.z)
		SetBlipSprite(map.blip, map.id)
		SetBlipAsShortRange(map.blip, true)
		SetBlipColour(map.blip, 1)
		SetBlipScale(map.blip, 0.99)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Looter Base")
		EndTextCommandSetBlipName(map.blip)
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

--[[RegisterNetEvent('DeleteLooter')
AddEventHandler('DeleteLooter', function()
	Citizen.Trace("Start deleting looters")
	DeleteEntity(pedname)
	Citizen.Trace("Deleted Leftover Looters")
end)--]]

--TriggerServerEvent('looters:PlyLoaded')