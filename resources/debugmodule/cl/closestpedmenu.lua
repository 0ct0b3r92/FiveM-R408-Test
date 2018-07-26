local ids = {}

ClosestPedMenu = {}
function ClosestPedMenu.Add(id)
	TriggerEvent("menu:addModuleSubMenu", id, "Closest Ped", function(id)
		table.insert(ids, id)
		
		TriggerEvent("menu:addModuleSubMenu", id, "Health", function(id)
			table.insert(ids, id)
			
			TriggerEvent("menu:addModuleItem", id, "Print Health", nil, function(id) table.insert(ids, id) end, function(id)
				print("Health: " .. GetEntityHealth(closestPed))
			end)
			TriggerEvent("menu:addModuleItem", id, "Print Armor", nil, function(id) table.insert(ids, id) end, function(id)
				print("Armor: " .. GetPedArmour(closestPed))
			end)
		end)
		
		TriggerEvent("menu:addModuleItem", id, "Print Model (Hash)", nil, function(id) table.insert(ids, id) end, function(id)
			local model = GetEntityModel(closestPed)
			print("Model: " .. model)
		end)
		TriggerEvent("menu:addModuleItem", id, "Print Position", nil, function(id) table.insert(ids, id) end, function(id)
			local x, y, z = table.unpack(GetEntityCoords(closestPed, false))
			local heading = GetEntityHeading(closestPed)
			print("x: " .. Util.RoundToNthDecimal(x, 1) .. " y: " .. Util.RoundToNthDecimal(y, 1) .. " z: " .. Util.RoundToNthDecimal(z, 1)
				.. " heading: " .. Util.RoundToNthDecimal(heading, 1))
		end)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			
			if PlayerPedId() then
				local tempClosestPed
				local minDistance = 99999999.0
				for ped in EnumeratePeds() do
					if ped ~= PlayerPedId() then
						local distance = GetDistanceBetweenCoords(table.unpack(GetEntityCoords(PlayerPedId(), true)),
							table.unpack(GetEntityCoords(ped, true)), true)
						if distance < minDistance then
								tempClosestPed = ped
								minDistance = distance
						end
					end
				end

				closestPed = tempClosestPed
				ClosestPedMenu.GreyingOut()
			end
		end
	end)
end

function ClosestPedMenu.GreyingOut()
	for _, id in ipairs(ids) do
		if not DoesEntityExist(closestPed) then
			TriggerEvent("menu:setGreyedOut", true, id)
		else
			TriggerEvent("menu:setGreyedOut", false, id)
		end
	end
end