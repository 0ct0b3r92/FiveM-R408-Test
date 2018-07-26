-- CONFIG --

-- Blacklisted vehicle models
carblacklist = {
	'MODELNAME',
	'ANOTHERMODELNAME'
	
}

-- CODE --
whitelisted = nil
AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('white')
end)
RegisterNetEvent('checkwhitelist')
AddEventHandler('checkwhitelist', function(whitelist) 

print(whitelisted)
whitelisted = whitelist
print('checked')



end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		v = GetVehiclePedIsIn(playerPed, false)
		end
		playerPed = GetPlayerPed(-1)
		if whitelisted == nil and playerPed and v then
		if GetPedInVehicleSeat(v, -1) == playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			end
		end
	end
end)
function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			sendForbiddenMessage("This vehicle is blacklisted!")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end