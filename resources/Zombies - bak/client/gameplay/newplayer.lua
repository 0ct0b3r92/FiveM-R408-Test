-- CONFIG --

local spawnWithFlashlight = true
local displayRadar = true
local bool = true

zombiekillsthislife = 0
playerkillsthislife = 0
zombiekills = 0
playerkills = 0

-- CODE --

-- Greenzone Protection Thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		for k,v in ipairs(greenZones) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			--if(Vdist(playerX, playerY, playerZ, v.x, v.y, v.z) > 100.0)then
				health = GetEntityHealth(PlayerPedId())
				--DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 200.0, 200.0, 10.0, 0, 255, 0,165, 0, 0, 0,0)
				if(Vdist(playerX, playerY, playerZ, v.x, v.y, v.z) < 100.0) and health > 100 then
					--Citizen.Trace("Player entered greenzone")
					DisplayHelpText("You have entered the safezone")
					SetEntityHealth(PlayerPedId(), 200)
					SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
					SetPedCanSwitchWeapon(PlayerPedId(), false)
					SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
					SetPlayerInvincible(PlayerPedId(), true)
					SetEntityInvincible(PlayerPedId(), true)
				elseif(Vdist(playerX, playerY, playerZ, v.x, v.y, v.z) > 100.0)then
					--Citizen.Trace("Player left greenzone")
					--DisplayHelpText("You have left the safezone")
					SetPedCanSwitchWeapon(PlayerPedId(), true)
					SetPlayerInvincible(PlayerPedId(), false)
					SetEntityInvincible(PlayerPedId(), false)
					SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
				end
			--end
		end
		
		for _, map in pairs(greenZones) do
			map.blip = AddBlipForCoord(map.x, map.y, map.z)
			SetBlipSprite(map.blip, map.id)
			SetBlipAsShortRange(map.blip, true)
			SetBlipAlpha(map.blip, 255)
			SetBlipColour(map.blip, 2)
			SetBlipScale(map.blip, 0.99)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if bool then
			TriggerServerEvent("Z:newplayer", PlayerId())
			TriggerServerEvent("Z:newplayerID", GetPlayerServerId(PlayerId()))
			bool = false
			SetBlackout(true)
		end
	end
end)

local welcomed = false
DecorRegister("hunger",1)
DecorRegister("thirst",1)
DecorRegister("humanity",1)

Citizen.CreateThread(function()
	AddEventHandler('baseevents:onPlayerKilled', function(killerId)
    local player = NetworkGetPlayerIndexFromPed(PlayerPedId())
    local attacker = killerId

		if GetPlayerFromServerId(attacker) and attacker ~= GetPlayerServerId(PlayerId()) then

			-- this is concept code for the "dropping loot when dying", no idea if it works, needs testing, hence, it hasn't been implemented yet
			-- NEEDS MUTLI ITEM PICKUP SUPPORT
			--[[
			for item,Consumable in ipairs(consumableItems) do
				if consumableItems.count[item] > 0.0 then
					local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), not IsEntityDead(PlayerPedId()) ))
					ForceCreateFoodPickupAtCoord(playerX + 1, playerY, playerZ, item, consumableItems.count[item])
				end
			end
			--]]
		end
		playerkillsthislife = 0
		zombiekillsthislife = 0
		initiateSave(true)
		if possessed then
			unPossessPlayer(PlayerPedId())
			possessed = false
		end
	end)

	AddEventHandler('baseevents:onPlayerWasted', function()
		playerkillsthislife = 0
		zombiekillsthislife = 0
		initiateSave(true)
		if possessed then
			unPossessPlayer(PlayerPedId())
			possessed = false
		end
	end)

	AddEventHandler('baseevents:onPlayerDied', function()
		playerkillsthislife = 0
		zombiekillsthislife = 0
		initiateSave(true)
		if possessed then
			unPossessPlayer(PlayerPedId())
			possessed = false
		end
	end)
end)

Citizen.CreateThread(function()
	AddEventHandler("playerSpawned", function(spawn,pid)
		if spawnWithFlashlight then
			for i,Consumable in ipairs(consumableItems) do
				consumableItems.count[i] = 0.0
			end
			GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
			GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_BAT"), 1, false, false)
			GiveWeaponToPed(PlayerPedId(), 0xFBAB5776, true)
			DecorSetFloat(PlayerPedId(), "hunger", 100.0)
			DecorSetFloat(PlayerPedId(), "thirst", 100.0)
			DecorSetFloat(PlayerPedId(), "humanity", 500.0)
			playerkillsthislife = 0
			zombiekillsthislife = 0
			infected = false
			consumableItems.count[1] = 1.0
			consumableItems.count[2] = 1.0
			StatSetInt("MP0_STAMINA", 40,1)

			-- this is debug code
			--[[
			spawnindex=0
			for i,Consumable in ipairs(consumableItems) do
				spawnindex=spawnindex+1
				consumableItems.count[spawnindex] = 99.0
				DecorSetFloat(PlayerPedId(), Consumable, 99.0)
			end
			]]

			SetPedDropsWeaponsWhenDead(PlayerPedId(),true)
			NetworkSetFriendlyFireOption(true)
			SetCanAttackFriendly(PlayerPedId(), true, true)
			TriggerEvent('showNotification', "Press 'M' to open your Interaction Menu!")
			Wait(5000)
			if pid == PlayerId() then
				initiateSave(true)
			end
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if GetEntityHeightAboveGround(PlayerPedId()) < 80 and IsPedInParachuteFreeFall(PlayerPedId()) then
			ForcePedToOpenParachute(PlayerPedId())
		end
	end
end)
