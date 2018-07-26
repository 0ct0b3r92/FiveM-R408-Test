canbeinvincible = false

-- Keeps the player visible at all times regardless
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1) -- Always put a wait if you're looping to avoid crashing.
		SetEntityVisible(GetPlayerPed(-1), true)
		-- Checks if player is still visible and if not then kill them
		Citizen.Wait(3000) -- 1000 equals 1 second
		if not IsEntityVisible(GetPlayerPed(-1)) then
		SetEntityHealth(GetPlayerPed(-1), 0)
		sendForbiddenMessage("Stop hiding like a cowardly chicken")
		end
    end
end)

-- Keeps the player from using godmode ingame at all times
-- Citizen.CreateThread(function()
    -- while true do
		-- Citizen.Wait(1)  -- Always put a wait if you're looping to avoid crashing.
		-- isinvincible = Citizen.InvokeNative(0xB721981B2B939E07, playerid)
		-- if isinvincible then
		-- Citizen.Wait(10000)
		-- SetEntityInvincible(GetPlayerPed(-1), false)
		-- SetPlayerInvincible(PlayerId(), false)
		-- SetEntityHealth(GetPlayerPed(-1), 0)
		-- sendForbiddenMessage("Stop pretending to be robocop")
		-- end
    -- end
-- end)

-- Keeps infinite ammo off for the player regardless
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1) -- Always put a wait if you're looping to avoid crashing.
    SetPedInfiniteAmmoClip(GetPlayerPed(-1), false)
    end
end)

-- Keeps player from setting alpha level of their skin
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
	ResetEntityAlpha(GetPlayerPed(-1))
	end
end)

-- Keeps players from bypassing godmode and adding extra health
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
		health = GetEntityHealth(GetPlayerPed(-1))
			if health > 205 then
			SetEntityHealth(GetPlayerPed(-1), 0)
			sendForbiddenMessage("Stop making yourself super human.")
		end
	end
end)


function sendForbiddenMessage(message)
	TriggerEvent("chatMessage", "^1BUSTED: ", {0, 0, 0}, "^0" .. message)
end