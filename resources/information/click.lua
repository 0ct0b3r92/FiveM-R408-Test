RegisterNetEvent("ToogleInformation")
AddEventHandler("ToogleInformation", function()
	ToogleInformation()
end)

function ToogleInformation()
	Citizen.Trace("info launch")
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
  ToogleInformation()
  cb('closed')
end)




