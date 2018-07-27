-- ****************************************************
-- anticheats.lua
-- GeekRiot
-- Converted by Cody196
-- 3/25/2017 (Original Start Date)
-- 3/19/2018 (Conversion Start date)
-- 4/13/2018 (Fixing Up Date)
-- Anti Cheating Mod
--
-- Prevents players from cheating.
--
-- *****************************************************

loadoutCount = 0
fixCount = 0

Citizen.Trace("Start donations")

donated = nil
AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('donatorwhitelist')
	loadoutCount = 0
	fixCount = 0
end)
RegisterNetEvent('checkDonators')
AddEventHandler('checkDonators', function(whitelist) 

print(donated)
donated = whitelist
print('checked')



end)


-- Gives Donators Loadout, can only be used once per respawn
RegisterCommand("giveloadout", function(source,args,raw)
	if donated == nil then
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	elseif loadoutCount > 0 then
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You can only use this command once per respawn.")
	else
		loadoutCount = loadoutCount + 1
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), 1, false, false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 90, false, false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_APPISTOL"), 60, false, false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPDW"), 30, false, false)
		TriggerEvent("chatMessage", "^2SYSTEM", {255, 255, 255}, "You gave yourself the donators loadout.")
	end
end)

-- Allows to repair vehicle once per respawn
RegisterCommand("fix", function(source,args,raw)
	if donated == nil then
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	elseif fixCount > 0 then
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You can only use this command once per respawn.")
	else
		fixCount = fixCount + 1
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleFixed(vehicle)
		TriggerEvent("chatMessage", "^2SYSTEM", {255, 255, 255}, "You fixed your vehicle.")
	end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end