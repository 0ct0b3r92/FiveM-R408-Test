--------------------------------
--- RP Revive, Made by FAXES ---
--------------------------------

local spawnPoints = {
	{ x = 2462.17, y = 4953.68, z = 45.14 }, -- O'Neil Farm
	{ x = 2356.52, y = 3131.02, z = 48.20 }, -- Sandy Shores Junkyard
	{ x= 142.73, y= -1076.33, z= 29.19 }, -- City Spawn Base
}

local reviveWait = 30
local reviveCount = 0

-- Turn off automatic respawn here instead of updating FiveM file.
AddEventHandler('onClientMapStart', function()
	Citizen.Trace("RPRevive: Disabling le autospawn.")
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
	Citizen.Trace("RPRevive: Autospawn is disabled.")
end)

function respawnPed(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false) 

	SetPlayerInvincible(ped, false) 

	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)
	GiveWeaponToPed(ped, GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
	GiveWeaponToPed(ped, GetHashKey("WEAPON_KNIFE"), 1, false, false)
	GiveWeaponToPed(ped, 0xFBAB5776, true)
	GiveWeaponComponentToPed(ped, 0x05FC3C11, 0xA73D4664)
end

local allowRespawn = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		health = GetEntityHealth(PlayerPedId())
		if IsEntityDead(ped) or health < 102 then
			Citizen.Wait(1000)
			reviveWait = reviveWait - 1
			--Citizen.Trace("Revive Wait [" .. reviveWait .."]")
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		health = GetEntityHealth(PlayerPedId())
		if IsEntityDead(ped) or health < 102 then
			if reviveWait > 0 then
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.75)

				SetTextColour(255, 0, 0, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString('Time until you can revive or respawn: ' .. reviveWait)
				DrawText(0.25, 0.45)
			end
		end
	end
end)
	
Citizen.CreateThread(function()
	local respawnCount = 0
	local playerIndex = NetworkGetPlayerIndex(-1) or 0
	math.randomseed(playerIndex)


    while true do
    Citizen.Wait(1)
		ped = GetPlayerPed(-1)
		if IsEntityDead(ped) then
			-- ShowInfoRevive('~r~You Are Dead ~w~Please wait ~y~'.. tostring(reviveWait) ..' Seconds ~w~ before choosing an action')

            SetPlayerInvincible(ped, true)
            SetEntityHealth(ped, 1)

			ShowInfoRevive('~y~ You Are Dead. ~w~Use ~p~E ~y~ to Revive or ~p~R ~y~to Respawn')

			if reviveCount > 1 then
				reviveWait = 0
			end
			
			if reviveWait < 1 then
				if ( IsControlJustReleased( 0, 38 ) or IsDisabledControlJustReleased( 0, 38 ) ) and GetLastInputMethod( 0 ) then
					if reviveCount > 1 then
						TriggerEvent('chatMessage', "^1SYSTEM", {255, 255, 255}, "You cannot revive anymore, you must respawn first.") 
					else
						revivePed(ped)
						reviveCount = reviveCount + 1
						reviveWait = 30
					end
				end
				
				if ( IsControlJustReleased( 0, 45 ) or IsDisabledControlJustReleased( 0, 45 ) ) and GetLastInputMethod( 0 ) then
					local coords = spawnPoints[math.random(1,#spawnPoints)]

					respawnPed(ped, coords)

					allowRespawn = false
					
					if respawnCount > 2 then
						reviveCount = 0
					end
					
					reviveWait = 30
					respawnCount = respawnCount + 1
					math.randomseed( playerIndex * respawnCount )
				end
			end
        end
    end
end)

function revivePed(ped)
	local playerPos = GetEntityCoords(ped, true)

	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

function ShowInfoRevive(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(true, true)
end