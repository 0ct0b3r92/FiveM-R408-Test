local ids = {}

EntityTextsMenu = {}
function EntityTextsMenu.Add(id)
	TriggerEvent("menu:addModuleSubMenu", id, "All Entities", function(id)
		TriggerEvent("menu:addModuleItem", id, "Draw Ped Information", false, false, function(id, state)
			drawPeds = state
		end)
		TriggerEvent("menu:addModuleItem", id, "Draw Vehicle Information", false, false, function(id, state)
			drawVehicles = state
		end)
		TriggerEvent("menu:addModuleItem", id, "Draw Prop Information", false, false, function(id, state)
			drawProps = state
		end)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1)
			
			if PlayerPedId() then
				local entities = {}
				if drawPeds then
					for ped in EnumeratePeds() do
						if ped ~= PlayerPedId() then
							table.insert(entities, ped)
						end
					end
				end
				if drawVehicles then
					for vehicle in EnumerateVehicles() do
						table.insert(entities, vehicle)
					end
				end
				if drawProps then
					for prop in EnumerateObjects() do
						table.insert(entities, prop)
					end
				end

				for _, entity in ipairs(entities) do
					local _, x, y = GetScreenCoordFromWorldCoord(table.unpack(GetEntityCoords(entity, true)))
					local entityCoords = GetEntityCoords(entity)
					local text = "x: " .. Util.RoundToNthDecimal(entityCoords.x, 1) .. " y: " .. Util.RoundToNthDecimal(entityCoords.y, 1) .. " z: "
						.. Util.RoundToNthDecimal(entityCoords.z, 1) .. " heading: " .. Util.RoundToNthDecimal(GetEntityHeading(entity)) .. "\nHealth: " .. GetEntityHealth(entity) .. "\nSpeed: " .. Util.RoundToNthDecimal(GetEntitySpeed(entity), 1)
						.. "\nModel: " .. GetEntityModel(entity)
					Drawing.DrawText(text, 0.3, x, y, 0, 255, 0)
				end
			end
		end
	end)
end