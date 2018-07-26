PlayerMenu = {}
function PlayerMenu.Add(id)
	TriggerEvent("menu:addModuleSubMenu", id, "Player", function(id)
		TriggerEvent("menu:addModuleSubMenu", id, "Position", function(id)
			TriggerEvent("menu:addModuleItem", id, "Show Position", false, false, function(id, state)
				showPlayerPos = state
			end)
			TriggerEvent("menu:addModuleItem", id, "Print Position", nil, false, function(id, state)
				local x, y, z, heading = table.unpack(PlayerMenu.GetCurrentPos())
				print("x: " .. Util.RoundToNthDecimal(x, 1) .. " y: " .. Util.RoundToNthDecimal(y, 1) .. " z: "
					.. Util.RoundToNthDecimal(z, 1) .. " heading: " .. Util.RoundToNthDecimal(heading, 1))
			end)
		end)
		
		TriggerEvent("menu:addModuleSubMenu", id, "Health", function(id)
			TriggerEvent("menu:addModuleItem", id, "Show Health / Armor", false, false, function(id, state)
				showPlayerHealth = state
			end)
			TriggerEvent("menu:addModuleItem", id, "Print Health", nil, false, function(id, state)
				print("Health: " .. GetEntityHealth(GetPlayerPed(-1)))
			end)
			TriggerEvent("menu:addModuleItem", id, "Print Armor", nil, false, function(id, state)
				print("Armor: " .. GetPedArmour(GetPlayerPed(-1)))
			end)
			TriggerEvent("menu:addModuleItem", id, "Die", nil, false, function(id, state)
				SetEntityHealth(GetPlayerPed(-1), 0)
			end)
		end)
		
		TriggerEvent("menu:addModuleSubMenu", id, "Speed", function(id)
			TriggerEvent("menu:addModuleItem", id, "Show Speed", false, false, function(id, state)
				showPlayerSpeed = state
			end)
			TriggerEvent("menu:addModuleItem", id, "Print Speed", nil, false, function(id, state)
				print("Speed: " .. Util.RoundToNthDecimal(GetEntitySpeed(GetPlayerPed(-1)), 1))
			end)
		end)
		
		TriggerEvent("menu:addModuleItem", id, "Print Model (Hash)", nil, false, function(id, state)
			print("Model: " .. GetEntityModel(PlayerPedId()))
		end)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1)
			
			if showPlayerPos then
				local x, y, z, heading = table.unpack(PlayerMenu.GetCurrentPos())
				Drawing.AddDrawText("x: " .. Util.RoundToNthDecimal(x, 1) .. " y: " .. Util.RoundToNthDecimal(y, 1) .. " z: "
					.. Util.RoundToNthDecimal(z, 1) .. " heading: " .. Util.RoundToNthDecimal(heading, 1), 0.005, 0.01)
			end
			
			if showPlayerHealth then
				Drawing.AddDrawText("Health: " .. GetEntityHealth(PlayerPedId()) .. " Armor: " .. GetPedArmour(PlayerPedId()))
			end
			
			if showPlayerSpeed then
				Drawing.AddDrawText("Speed: " .. Util.RoundToNthDecimal(GetEntitySpeed(PlayerPedId()), 1))
			end
		end
	end)
end

function PlayerMenu.GetCurrentPos()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	local heading = GetEntityHeading(PlayerPedId())
	return {x, y, z, heading}
end