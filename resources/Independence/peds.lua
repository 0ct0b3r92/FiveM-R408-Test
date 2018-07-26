local ngfPeds = {
	"ngf"
}

local guardSpots = {
	{x=1725.5321044922, y=3265.6208496094, z=45.053516387939}, 
	{x=1733.0692138672, y=3239.3481445313, z=45.054195404053}, 
	{x=1670.5369873047, y=3174.5646972656, z=55.371444702148}, 
	{x=1574.8771972656, y=3362.578125, z=48.634986877441}, 
	{x=1573.0554199219, y=3360.8059082031, z=42.126541137695}, 
	{x=1775.9339599609, y=3324.6469726563, z=45.604541778564}, 
	{x=1407.0450439453, y=3007.1501464844, z=40.540557861328}, 
}

local localPlayerId = PlayerId()
local serverId = GetPlayerServerId(localPlayerId)
local firstspawn = false

NGF = {}

-- Spawn NGF Peds
Citizen.CreateThread(function()
	for k,v in pairs(guardSpots) do
			if not DoesEntityExist(NGFPed) then
				table.remove(NGF, i)
			end
			
			NGFped = ngfPeds[math.random(1, #ngfPeds)]
			NGFped = string.upper(NGFped)
			RequestModel(GetHashKey(NGFped))
			while not HasModelLoaded(GetHashKey(NGFped)) or not HasCollisionForModelLoaded(GetHashKey(NGFped)) do
				Citizen.Wait(1)
			end
			
			AddRelationshipGroup("NGFGuards")
			SetRelationshipBetweenGroups(0, GetHashKey("NGFGuards"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("NGFGuards"))
			SetRelationshipBetweenGroups(5, GetHashKey("NGFGuards"), GetHashKey("zombeez"))
						
			NGFPed = CreatePed(4, GetHashKey(NGFped), v.x, v.y, v.z - 1, 237, false, false)
			SetPedFleeAttributes(NGFPed, 0, 0)
			SetPedCombatAttributes(NGFPed, 46, 1)
			SetPedCombatAttributes(NGFPed, 1424, 0)
			SetPedCombatAttributes(NGFPed, 5, 1)
			SetPedCombatRange(NGFPed, 2)
			SetPedRelationshipGroupHash(NGFPed, GetHashKey("NGFGuards"))
			SetPedAccuracy(NGFPed, 100)
			SetPedSeeingRange(NGFPed, 500.0)
			SetPedHearingRange(NGFPed, 1000.0)
			SetEntityHeading(NGFPed, 237)
			SetEntityInvincible(NGFPed, true) -- Keep entity from being killed
			SetPedCanRagdoll(NGFPed, false) -- Keeps ped from reacting to shots or melee
			SetEntityDynamic(NGFPed, true) -- False Keeps ped static
			SetEntityAsMissionEntity(NGFPed, true, true) -- Set ped as mission related
			SetEntityMaxSpeed(NGFPed, 0.00) -- Freezes peds position
			GiveWeaponToPed(NGFPed, GetHashKey("WEAPON_RAILGUN"), 9999, true, true)
			
			table.insert(NGF, NGFPed)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetDisableAmbientMeleeMove(PlayerId(), true)
		for i, NGFPed in pairs(NGF) do
			AddRelationshipGroup("NGFGuards")
			SetRelationshipBetweenGroups(0, GetHashKey("NGFGuards"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("NGFGuards"))
			SetRelationshipBetweenGroups(5, GetHashKey("NGFGuards"), GetHashKey("zombeez"))
			SetPedFleeAttributes(NGFPed, 0, 0)
			SetPedCombatAttributes(NGFPed, 46, 1)
			SetPedCombatAttributes(NGFPed, 1424, 0)
			SetPedCombatAttributes(NGFPed, 5, 1)
			SetPedCombatRange(NGFPed, 2)
			SetPedRelationshipGroupHash(NGFPed, GetHashKey("NGFGuards"))
			SetPedAccuracy(NGFPed, 100)
			SetPedSeeingRange(NGFPed, 500.0)
			SetPedHearingRange(NGFPed, 1000.0)
			SetEntityHeading(NGFPed, 237)
			SetEntityInvincible(NGFPed, true) -- Keep entity from being killed
			SetPedCanRagdoll(NGFPed, false) -- Keeps ped from reacting to shots or melee
			SetEntityDynamic(NGFPed, true) -- False Keeps ped static
			SetEntityAsMissionEntity(NGFPed, true, true) -- Set ped as mission related
			SetEntityMaxSpeed(NGFPed, 0.00) -- Freezes peds position
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(NGFPed, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0)then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "an NGF guard", 255, 255, 255, false)
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