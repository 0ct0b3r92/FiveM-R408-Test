RegisterNetEvent("ToggleChangelog")
AddEventHandler("ToggleChangelog", function()
	ToggleChangelog()
end)

function ToggleChangelog()
	Citizen.Trace("tutorial launch")
	menuEnabled = not menuEnabled
	if (menuEnabled) then 
		SetNuiFocus( true, true ) 
		SendNUIMessage({
			showPlayerMenu = true 
		})
	else 
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end 
end 


RegisterNUICallback('close', function(data, cb)  
  ToggleChangelog()
  cb('closed')
end)




