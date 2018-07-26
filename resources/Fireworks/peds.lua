local militiaPeds = {
	"s_m_y_blackops_01"
}

local fireworkSpots = {
	{x=1067.7434082031, y=3074.7041015625, z=46.22448348999}, 
	{x=1050.5159912109, y=3082.7536621094, z=46.22448348999}, 
	{x=1069.7387695313, y=3002.8903808594, z=46.34139251709}, 
	{x=1080.4334716797, y=3017.4916992188, z=46.34139251709}, 
	{x=1399.0668945313, y=3008.177734375, z=45.454307556152}, 
	{x=1397.1553955078, y=2988.787109375, z=45.454307556152}, 
	{x=1585.4222412109, y=3218.3596191406, z=44.083290100098}, 
	{x=1621.8673095703, y=3188.2727050781, z=43.657913208008}, 
}

local localPlayerId = PlayerId()
local serverId = GetPlayerServerId(localPlayerId)
local firstspawn = false

militiapeds = {}

-- Spawn Firework Peds
Citizen.CreateThread(function()
	for k,v in pairs(fireworkSpots) do
			if not DoesEntityExist(guardPed) then
				table.remove(militiapeds, i)
			end
			
			militiaPed = militiaPeds[math.random(1, #militiaPeds)]
			militiaPed = string.upper(militiaPed)
			RequestModel(GetHashKey(militiaPed))
			while not HasModelLoaded(GetHashKey(militiaPed)) or not HasCollisionForModelLoaded(GetHashKey(militiaPed)) do
				Citizen.Wait(100)
			end
			
			AddRelationshipGroup("fireworks")
			SetRelationshipBetweenGroups(0, GetHashKey("fireworks"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("fireworks"))
			SetRelationshipBetweenGroups(0, GetHashKey("fireworks"), GetHashKey("zombeez"))
						
			guardPed = CreatePed(4, GetHashKey(militiaPed), v.x, v.y, v.z - 1, 237, false, false)
			SetPedFleeAttributes(guardPed, 0, 0)
			SetPedCombatAttributes(guardPed, 46, 1)
			SetPedCombatAttributes(guardPed, 1424, 0)
			SetPedCombatAttributes(guardPed, 5, 1)
			SetPedCombatRange(guardPed, 2)
			SetPedRelationshipGroupHash(guardPed, GetHashKey("fireworks"))
			SetPedAccuracy(guardPed, 100)
			SetPedSeeingRange(guardPed, 5000.0)
			SetPedHearingRange(guardPed, 1000.0)
			SetEntityHeading(guardPed, 237)
			SetEntityInvincible(guardPed, true) -- Keep entity from being killed
			SetPedCanRagdoll(guardPed, false) -- Keeps ped from reacting to shots or melee
			SetEntityDynamic(guardPed, true) -- False Keeps ped static
			SetEntityAsMissionEntity(guardPed, true, true) -- Set ped as mission related
			SetEntityMaxSpeed(guardPed, 0.00) -- Freezes peds position
			GiveWeaponToPed(guardPed, GetHashKey("WEAPON_FIREWORK"), 9999, true, true)
			SetPedShootsAtCoord(guardPed, v.x, v.y, 500.00, true)
			TaskShootAtCoord(guardPed, 1585.42, 3218.35, 500.00, -1, 0x2264E5D6)
			
			table.insert(militiapeds, guardPed)
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, guardPed in pairs(militiapeds) do
			SetPedFleeAttributes(guardPed, 0, 0)
			SetPedCombatAttributes(guardPed, 46, 1)
			SetPedCombatAttributes(guardPed, 1424, 0)
			SetPedCombatAttributes(guardPed, 5, 1)
			SetPedCombatRange(guardPed, 2)
			SetPedRelationshipGroupHash(guardPed, GetHashKey("militia"))
			SetPedAccuracy(guardPed, 100)
			SetPedSeeingRange(guardPed, 100.0)
			SetPedHearingRange(guardPed, 1000.0)
			SetEntityHeading(guardPed, 237)
			SetEntityInvincible(guardPed, true) -- Keep entity from being killed
			SetPedCanRagdoll(guardPed, false) -- Keeps ped from reacting to shots or melee
			SetEntityDynamic(guardPed, true) -- False Keeps ped static
			SetEntityAsMissionEntity(guardPed, true, true) -- Set ped as mission related
			SetEntityMaxSpeed(guardPed, 0.00) -- True Freezes peds position
			GiveWeaponToPed(guardPed, GetHashKey("WEAPON_FIREWORK"), 9999, true, true)
			--SetPedShootsAtCoord(guardPed, 1700.98, 3235.42, 500.00, true)
			--TaskShootAtCoord(guardPed, 1700.98, 3235.42, 500.00, 9999, 0x7A845691)
			--TaskReloadWeapon(guardPed, true)
			--Citizen.Trace("Firing firework")
		end
	end
end)--]]