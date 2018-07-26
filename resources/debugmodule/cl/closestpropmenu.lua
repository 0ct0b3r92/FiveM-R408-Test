local ids = {}

ClosestPropMenu = {}
function ClosestPropMenu.Add(id)
	TriggerEvent("menu:addModuleSubMenu", id, "Closest Prop", function(id)
		table.insert(ids, id)
		
		TriggerEvent("menu:addModuleSubMenu", id, "Health", function(id)
			table.insert(ids, id)
			
			TriggerEvent("menu:addModuleItem", id, "Print Health", nil, function(id) table.insert(ids, id) end, function(id)
				print("Health: " .. GetEntityHealth(closestProp))
			end)
		end)
		
		TriggerEvent("menu:addModuleItem", id, "Print Model (Hash)", nil, function(id) table.insert(ids, id) end, function(id)
			local model = GetEntityModel(closestProp)
			print("Model: " .. model)
		end)
		TriggerEvent("menu:addModuleItem", id, "Print Position", nil, function(id) table.insert(ids, id) end, function(id)
			local x, y, z = table.unpack(GetEntityCoords(closestProp, false))
			local heading = GetEntityHeading(closestProp)
			print("x: " .. Util.RoundToNthDecimal(x, 1) .. " y: " .. Util.RoundToNthDecimal(y, 1) .. " z: " .. Util.RoundToNthDecimal(z, 1)
				.. " heading: " .. Util.RoundToNthDecimal(heading, 1))
		end)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			
			if PlayerPedId() then
				local tempClosestProp
				local minDistance = 99999999.0
				for prop in EnumerateObjects() do
					local distance = GetDistanceBetweenCoords(table.unpack(GetEntityCoords(PlayerPedId(), true)),
						table.unpack(GetEntityCoords(prop, true)), true)
					if distance < minDistance then
							tempClosestProp = prop
							minDistance = distance
					end
				end

				closestProp = tempClosestProp
				ClosestPropMenu.GreyingOut()
			end
		end
	end)
end

function ClosestPropMenu.GreyingOut()
	for _, id in ipairs(ids) do
		if not DoesEntityExist(closestProp) then
			TriggerEvent("menu:setGreyedOut", true, id)
		else
			TriggerEvent("menu:setGreyedOut", false, id)
		end
	end
end