local crouched = false
crouchKey = 26

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		if ( DoesEntityExist(ped) and not IsEntityDead(ped)) then 
			DisableControlAction(0, crouchKey, true) 
			if ( not IsPauseMenuActive() ) then 
				if (IsDisabledControlJustPressed(0, crouchKey) and not proned) then 
					RequestAnimSet("move_ped_crouched")
					RequestAnimSet("MOVE_M@TOUGH_GUY@")
					
					while (not HasAnimSetLoaded("move_ped_crouched")) do 
						Citizen.Wait(100)
					end 
					
					while (not HasAnimSetLoaded("MOVE_M@TOUGH_GUY@")) do 
						Citizen.Wait(100)
					end 
					
					if (crouched and not proned) then 
						ResetPedMovementClipset(ped)
						ResetPedStrafeClipset(ped)
						SetEveryoneIgnorePlayer(PlayerId(), false)
						crouched = false 
					elseif (not crouched and not proned) then
						SetPedMovementClipset(ped, "move_ped_crouched", 0.55)
						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
						SetEveryoneIgnorePlayer(PlayerId(), true)
						crouched = true 
					end 
				end
			end
		else
			crouched = false
		end
	end
end)