RegisterNetEvent("ToogleZSRMap")
AddEventHandler("ToogleZSRMap", function()
	ToogleZSRMap()
end)

function ToogleZSRMap()
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
  ToogleZSRMap()
  cb('closed')
end)




