Citizen.CreateThread(function()
    while true do
		Citizen.Wait(2000)
		StopResource('sessionmanager')
		StartResource('sessionmanager')
		return
    end
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30 * 60000) -- 60000 = 1 minute, 300000 = 5 minutes
		StopResource('NewLoot')
		StartResource('NewLoot')
    end
end)--]]

-- Resets Placed Looters at Looter camps every 5 minutes
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15 * 60000) -- 60000 = 1 minute
		StopResource('lootercamps')
		StartResource('lootercamps')
    end
end)

-- Resets car spawns every 5 minutes
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30 * 60000) -- 60000 = 1 minute
		StopResource('carspawns')
		StartResource('carspawns')
    end
end)

-- Resets Zombies resource every 2 hours to keep it from bugging out (temporary n*g*er rig)
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120 * 60000) -- 60000 = 1 minute
		StopResource('Zombies')
		StartResource('Zombies')
    end
end)--]]