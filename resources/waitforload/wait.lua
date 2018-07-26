AddEventHandler("playerSpawned", function(spawn)
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityMaxSpeed(PlayerPedId(), 0.00)
	ShowNotification("Waiting for map to load...")
	Citizen.Wait(10000)
	FreezeEntityPosition(PlayerPedId(), false)
	SetEntityMaxSpeed(PlayerPedId(), 85.00)
	ShowNotification("Map has loaded...")
end)

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(1)
		-- FreezeEntityPosition(GetPlayerPed(-1), true)
		-- ShowNotification("Waiting for map to load...")
		-- Citizen.Wait(5000)
		-- FreezeEntityPosition(GetPlayerPed(-1), false)
		-- ShowNotification("Map has loaded...")
		-- return
	-- end
-- end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end