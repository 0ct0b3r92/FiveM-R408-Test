local ids = {}

ClosestVehicleMenu = {}
function ClosestVehicleMenu.Add(id)
	table.insert(ids, id)
	
	TriggerEvent("menu:addModuleSubMenu", id, "Health", function(id)
		table.insert(ids, id)
		
		TriggerEvent("menu:addModuleItem", id, "Print Health", nil, function(id) table.insert(ids, id) end, function(id)
			print("Health: " .. GetEntityHealth(closestVehicle))
		end)
		TriggerEvent("menu:addModuleItem", id, "Print Engine Health", nil, function(id) table.insert(ids, id) end, function(id)
			print("Engine Health: " .. GetVehicleEngineHealth(closestVehicle))
		end)
	end)
	
	TriggerEvent("menu:addModuleItem", id, "Print Model", nil, function(id) table.insert(ids, id) end, function(id)
		local model = GetEntityModel(closestVehicle)
		print("Model: " .. GetDisplayNameFromVehicleModel(model) .. " (Hash: " .. model .. ")")
	end)
	TriggerEvent("menu:addModuleItem", id, "Print Position", nil, function(id) table.insert(ids, id) end, function(id)
		local x, y, z = table.unpack(GetEntityCoords(closestVehicle, false))
		local heading = GetEntityHeading(closestVehicle)
		print("x: " .. Util.RoundToNthDecimal(x, 1) .. " y: " .. Util.RoundToNthDecimal(y, 1) .. " z: " .. Util.RoundToNthDecimal(z, 1)
			.. " heading: " .. Util.RoundToNthDecimal(heading, 1))
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			
			if PlayerPedId() then
				local tempClosestVehicle
				local minDistance = 99999999.0
				for vehicle in EnumerateVehicles() do
					local distance = GetDistanceBetweenCoords(table.unpack(GetEntityCoords(PlayerPedId(), true)),
						table.unpack(GetEntityCoords(vehicle, true)), true)
					if distance < minDistance then
							tempClosestVehicle = vehicle
							minDistance = distance
					end
				end

				closestVehicle = tempClosestVehicle
				ClosestVehicleMenu.GreyingOut()
			end
		end
	end)
end

function ClosestVehicleMenu.GreyingOut()
	for _, id in ipairs(ids) do
		if not DoesEntityExist(closestVehicle) then
			TriggerEvent("menu:setGreyedOut", true, id)
		else
			TriggerEvent("menu:setGreyedOut", false, id)
		end
	end
end