ymapPedTab = {}

unionworkers = {
        {1664.10034, -24.2922459, 173.77478, 16.6154327, -673538407, 'WORLD_HUMAN_WELDING', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers0'},
        {1664.65137, 0.3390081, 166.1181, 69.99993, -973145378, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers1'},
        {1672.4093, -21.6216469, 182.770462, -44.9999733, -973145378, 'WORLD_HUMAN_BINOCULARS', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers2'},
        {1660.89233, -27.844368, 182.770645, 100.99765, -673538407, 'WORLD_HUMAN_AA_SMOKE', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers3'},
        {1662.346, 21.5618019, 180.877335, -114.93853, -973145378, 'WORLD_HUMAN_DRINKING', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers4'},
        {1651.702, 24.05009, 180.881378, -4.9999733, -2039072303, 'WORLD_HUMAN_PICNIC', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers5'},
        {1656.85986, 55.311142, 172.251541, -40.3332024, 349680864, 'WORLD_HUMAN_HAMMERING', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers6'},
        {1641.35242, 18.5216045, 173.7744, -34.0499077, 349680864, 'WORLD_HUMAN_VEHICLE_MECHANIC', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers7'},
        {1665.3208, 0.730542541, 173.74852, -60.7609024, 68070371, 'Any - Warp', 0, 'WEAPON_UNARMED', 'yMapPedunionworkers8'},
}


local firstSpawn = false

    Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
				if firstSpawn == false then
					for k,v in pairs(unionworkers) do
									
						local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
						RequestModel(hash)
						while not HasModelLoaded(hash) do
							Citizen.Wait(100)
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
						table.insert(ymapPedTab, pedname)
						
						firstSpawn = true
					end
				end
		end
	end)
	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, pedname in pairs(ymapPedTab) do
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
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a san andreas union worker", 255, 255, 255, false)
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