local ids = {}

VehicleMenu = {}
function VehicleMenu.Add(id)
	TriggerEvent("menu:addModuleSubMenu", id, "Vehicle", function(id)
		TriggerEvent("menu:addModuleSubMenu", id, "Closest Vehicle", function(id)
			ClosestVehicleMenu.Add(id)
		end)

		TriggerEvent("menu:addModuleSubMenu", id, "Health", function(id)
			table.insert(ids, id)
			
			TriggerEvent("menu:addModuleItem", id, "Print Health", nil, function(id) table.insert(ids, id) end, function(id)
				print("Health: " .. GetEntityHealth(vehicle))
			end)
			TriggerEvent("menu:addModuleItem", id, "Print Engine Health", nil, function(id) table.insert(ids, id) end, function(id)
				print("Engine Health: " .. GetVehicleEngineHealth(vehicle))
			end)
		end)
		
		TriggerEvent("menu:addModuleItem", id, "Print Model", nil, function(id) table.insert(ids, id) end, function(id)
			print("Model: " .. GetEntityModel(vehicle))
		end)
		TriggerEvent("menu:addModuleItem", id, "Print Position", nil, function(id) table.insert(ids, id) end, function(id)
			local x, y, z = table.unpack(GetEntityCoords(vehicle, false))
			local heading = GetEntityHeading(vehicle)
			print("x: " .. Util.RoundToNthDecimal(x, 1) .. " y: " .. Util.RoundToNthDecimal(y, 1) .. " z: " .. Util.RoundToNthDecimal(z, 1)
				.. " heading: " .. Util.RoundToNthDecimal(heading, 1))
		end)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			
			if PlayerPedId() then
				vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				VehicleMenu.VehicleGreyingOut()
			end
		end
	end)
end

function VehicleMenu.VehicleGreyingOut()
	for _, id in ipairs(ids) do
		if not DoesEntityExist(vehicle) then
			TriggerEvent("menu:setGreyedOut", true, id)
		else
			TriggerEvent("menu:setGreyedOut", false, id)
		end
	end
end