ymapPedTab = {}

bandits = {
        {2669.8225097656, 3539.3908691406, 51.792877197266, 89.99988, -1275859404, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedbandits0'},
        {2682.0942382813, 3535.35546875, 52.09489059448, -55.7280426, -1275859404, 'None', 0, 'WEAPON_SNSPISTOL', 'yMapPedbandits1'},
        {2680.7036132813, 3528.2368164063, 52.432411193848, 124.991035, -1275859404, 'None', 0, 'WEAPON_VINTAGEPISTOL', 'yMapPedbandits2'},
        {2680.4538574219, 3509.2429199219, 53.303291320801, -69.99993, -1275859404, 'None', 0, 'WEAPON_SAWNOFFSHOTGUN', 'yMapPedbandits3'},
        {2664.5700683594, 3511.4587402344, 53.140003204346, 0.0000000, -1275859404, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedbandits4'},
        {2649.3176269531, 3514.2531738281, 53.289009094238, -19.0232925, -1275859404, 'None', 0, 'WEAPON_MARKSMANPISTOL', 'yMapPedbandits5'},
        {2648.3972167969, 3526.1196289063, 52.84644317627, 11.5456133, -1275859404, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedbandits6'},
		{2669.8225097656, 3539.3908691406, 51.792877197266, 89.99988, -1275859404, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedbandits0'},
        {2682.0942382813, 3535.35546875, 52.09489059448, -55.7280426, -1275859404, 'None', 0, 'WEAPON_SNSPISTOL', 'yMapPedbandits1'},
        {2680.7036132813, 3528.2368164063, 52.432411193848, 124.991035, -1275859404, 'None', 0, 'WEAPON_VINTAGEPISTOL', 'yMapPedbandits2'},
        {2680.4538574219, 3509.2429199219, 53.303291320801, -69.99993, -1275859404, 'None', 0, 'WEAPON_SAWNOFFSHOTGUN', 'yMapPedbandits3'},
        {2664.5700683594, 3511.4587402344, 53.140003204346, 0.0000000, -1275859404, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedbandits4'},
        {2649.3176269531, 3514.2531738281, 53.289009094238, -19.0232925, -1275859404, 'None', 0, 'WEAPON_MARKSMANPISTOL', 'yMapPedbandits5'},
        {2648.3972167969, 3526.1196289063, 52.84644317627, 11.5456133, -1275859404, 'None', 0, 'WEAPON_ASSAULTRIFLE', 'yMapPedbandits6'},
}

local banditChats = {
	"Either do what you need to do here or get the fuck out!",
	"What are you doing here?",
	"You don't have any business here.",
	"Why are you here?",
	"Get the hell out of here.",
}

local firstSpawn = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if firstSpawn == false then
			for k,v in pairs(bandits) do
				local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Citizen.Wait(1)
				end
				bandit = CreatePed(-1, hash, x, y, z, h, false, false)
				relationship = tonumber(relationship)
				AddRelationshipGroup("bandits")
				SetRelationshipBetweenGroups(2, GetHashKey("bandits"), GetHashKey("PLAYER")) -- bandits hate players
				SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("bandits")) -- Player Hates bandits
				SetRelationshipBetweenGroups(0, GetHashKey("bandits"), GetHashKey("zombeez")) -- bandits hate Zombies
				SetPedRelationshipGroupHash(bandit, GetHashKey("bandits"))
				--TaskStartScenarioInPlace(bandit, action, 0, true)
				--TaskWanderInArea(pedname, x, y, z, 100, 10, 10)
				TaskWanderStandard(bandit, 10, 10)
				SetPedKeepTask(bandit, true)
				SetPedArmour(bandit, 0)
				SetPedAccuracy(bandit, 1)
				SetPedSeeingRange(bandit, 10.0)
				SetPedHearingRange(bandit, 100.0)
				SetPedFleeAttributes(bandit, 0, 0)
				SetPedCombatAttributes(bandit, 46, 1)
				SetPedCombatAttributes(bandit, 1424, 0)
				SetPedCombatAttributes(bandit, 5, 1)
				SetPedCombatAbility(bandit, 100)
				SetPedCombatMovement(bandit, 3)
				SetPedAsEnemy(bandit, true)
				SetPedCombatRange(bandit, 2)
				SetPedTargetLossResponse(bandit, 2)
				SetPedAlertness(bandit, 3)
				SetPedConfigFlag(bandit, 100, 1)
				SetEntityHealth(bandit, 200)
				SetAiMeleeWeaponDamageModifier(1.0)
				SetAiWeaponDamageModifier(0.5)
				if weapon == 'WEAPON_UNARMED' then
				else
					GiveWeaponToPed(bandit, GetHashKey(weapon), 9999, true, true)
				end
				table.insert(ymapPedTab, bandit)
				
				firstSpawn = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, bandit in pairs(ymapPedTab) do
				AddRelationshipGroup("bandits")
				SetRelationshipBetweenGroups(2, GetHashKey("bandits"), GetHashKey("PLAYER")) -- bandits hate players
				SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("bandits")) -- Player Hates bandits
				SetRelationshipBetweenGroups(0, GetHashKey("bandits"), GetHashKey("zombeez")) -- bandits hate Zombies
				SetPedRelationshipGroupHash(bandit, GetHashKey("bandits"))
				--TaskStartScenarioInPlace(bandit, action, 0, true)
				SetPedKeepTask(bandit, true)
				SetPedArmour(bandit, 0)
				SetPedAccuracy(bandit, 1)
				SetPedSeeingRange(bandit, 10.0)
				SetPedHearingRange(bandit, 100.0)
				SetPedFleeAttributes(bandit, 0, 0)
				SetPedCombatAttributes(bandit, 46, 1)
				SetPedCombatAttributes(bandit, 1424, 0)
				SetPedCombatAttributes(bandit, 5, 1)
				SetPedCombatAbility(bandit, 100)
				SetPedCombatMovement(bandit, 3)
				SetPedAsEnemy(bandit, true)
				SetPedCombatRange(bandit, 2)
				SetPedTargetLossResponse(bandit, 2)
				SetPedAlertness(bandit, 3)
				SetPedConfigFlag(bandit, 100, 1)
				SetEntityHealth(bandit, 200)
				SetAiMeleeWeaponDamageModifier(1.0)
				SetAiWeaponDamageModifier(0.5)
				
				
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(bandit, true))
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
					DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a bandit", 255, 255, 0, false)
				end
		end
	end
end)

-- Handles NPC Interaction
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, bandit in pairs(ymapPedTab) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(bandit, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 4.0) then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                if IsControlJustReleased(1, 51) then
					TaskTurnPedToFaceEntity(bandit, PlayerPedId(), 10000)
					TriggerEvent('chatMessage', "^3Bandit(NPC)", {255, 255, 255}, banditChats[math.random(1, #banditChats)])
					Citizen.Wait(5000)
					TaskWanderStandard(bandit, 10, 10)
				end
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

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end