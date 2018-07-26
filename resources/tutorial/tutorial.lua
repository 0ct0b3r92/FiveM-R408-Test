local spawnTutorials = {
	{ x = 2462.17, y = 4953.68, z = 45.14 },
	{ x = 2356.52, y = 3131.02, z = 48.20 },
	{ x= 142.73, y= -1076.33, z= 29.19 },
}


-- Kill Looter missions
incircle = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(spawnTutorials) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 0, 255,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to begin tutorial.")
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TriggerEvent("ToggleActionmenu", source)
					end
				end
			end
		end
	end
end)


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end