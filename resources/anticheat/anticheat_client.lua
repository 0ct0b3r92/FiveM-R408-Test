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

Citizen.Trace("Start anticheat")

-- counts how many times a player got caught for cheating
local cheatcount = 0
-- maximum cheat counts allowed before kicking
local maxcheats = 10

weaponblacklist = {
	"WEAPON_MINIGUN",
	"WEAPON_RPG",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_STICKYBOMB",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_RAILGUN",
}

carBlacklist = {
	"khanjali",
	"rhino",
	"buzzard",
	"polmav",
	"savage",
	"hydra",
	"valkyrie",
	"annihilator",
	"lazer",
	"besra",
	"police",
	"boxville5",
	"firetruk",
	"thruster",
	"barrage",
	"volatol",
	"starling",
	"mogul",
	"vigilante",
	"fav",
	"halftrack",
	"tampa3",
	"technical2",
	"insurgent",
	"ruiner2",
	--"apc", -- Demon Corps Vehicle
	--"bombushka",
	--"hunter",
	--"pyro",
	--"molotok", -- Demon Corps Vehicle
	--"avenger", -- Demon Corps Vehicle
	--"chernobog", -- Demon Corps Vehicle
	--"akula", -- Demon Corps Vehicle
}

whitelisted = nil
AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('white')
end)
RegisterNetEvent('checkwhitelist')
AddEventHandler('checkwhitelist', function(whitelist) 

print(whitelisted)
whitelisted = whitelist
print('checked')



end)

-- determines if the player can go invisible
canbeinvisible = false
-- determines if the player can be invincible
canbeinvincible = false
-- Disables all weapons if true
disableallweapons = false
-- Sound volume (0.0 - 1.0)
volume = 1.0

newplayer = true

local greenZones = {
	{name="Junkyard Base", id=40, x= 2384.00, y= 3090.00, z= 48.00},
	{name="Grapeseed Base", id=40, x= 2447.10, y= 4977.18, z= 46.82},
	{name="City Spawn", id=40, x= 142.73, y= -1076.33, z= 29.19},
}

Citizen.Trace("Tables loaded")

-- Resets hunger
RegisterCommand("maxhunger", function(source,args,raw)
	if whitelisted == nil then
		PlaySound()
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	else
		DecorSetFloat(PlayerPedId(), "hunger", 100.0)
		TriggerEvent("chatMessage", "^2SYSTEM", {255, 255, 255}, "You have reset your hunger.")
	end
end)

-- Resets thirst
RegisterCommand("maxthirst", function(source,args,raw)
	if whitelisted == nil then
		PlaySound()
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	else
		DecorSetFloat(PlayerPedId(), "thirst", 100.0)
		TriggerEvent("chatMessage", "^2SYSTEM", {255, 255, 255}, "You have reset your thirst.")
	end
end)

-- Cures infection
RegisterCommand("cureinfection", function(source,args,raw)
	if whitelisted == nil then
		PlaySound()
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	else
		DecorSetFloat(PlayerPedId(), "infection", 0.0)
		ClearEntityLastWeaponDamage(GetPlayerPed(-1))
		infected = false
		TriggerEvent("chatMessage", "^2SYSTEM", {255, 255, 255}, "Your infection has been cured.")
	end
end)

-- Cures illness
RegisterCommand("cureillness", function(source,args,raw)
	if whitelisted == nil then
		PlaySound()
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	else
		DecorSetFloat(PlayerPedId(), "illness", 0.0)
		TriggerEvent("chatMessage", "^2SYSTEM", {255, 255, 255}, "Your illness has been cured.")
	end
end)

-- Starts Free For All
RegisterCommand("ffa", function(source,args,raw)
	if whitelisted == nil then
		PlaySound()
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	else
		TriggerServerEvent("ShowFFA")
	end
end)

-- Plays mysterious aignal
RegisterCommand("signal", function(source,args,raw)
	if whitelisted == nil then
		PlaySound()
		TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "You are not allowed to use this command.")
	else
		TriggerServerEvent("Playsignal")
		PlaySignal()
	end
end)

-- Check for godmode outside of safezones
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		for k,v in ipairs(greenZones) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			if(Vdist(playerX, playerY, playerZ, v.x, v.y, v.z) > 100.0)then
				SetPedCanSwitchWeapon(PlayerPedId(), true)
				TurnOffGodmode()
				canbeinvincible = false
			end
		end
	end
end)

-- Greenzone Protection Thread
Citizen.CreateThread(function()
	for _, map in pairs(greenZones) do
		map.blip = AddBlipForCoord(map.x, map.y, map.z)
		SetBlipSprite(map.blip, map.id)
		SetBlipAsShortRange(map.blip, true)
		SetBlipAlpha(map.blip, 255)
		SetBlipColour(map.blip, 2)
		SetBlipScale(map.blip, 0.99)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Safezone")
		EndTextCommandSetBlipName(map.blip)
	end
	while true do
		Citizen.Wait(1)
		
		for k,v in ipairs(greenZones) do
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			health = GetEntityHealth(PlayerPedId())
			if(Vdist(playerX, playerY, playerZ, v.x, v.y, v.z) < 100.0) and health > 100 then
				--Citizen.Trace("Player entered greenzone")
				--Citizen.Trace("Godmode Allowed")
				--DisplayHelpText("You have entered the safezone")
				DrawRect(0.025, 0.75, 0.025, 0.035, 0, 255, 0, 150)
				SetEntityHealth(PlayerPedId(), 200)
				--SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
				--SetPedCanSwitchWeapon(PlayerPedId(), false)
				DisablePlayerFiring(PlayerId(), true)
				canbeinvincible = true
				AllowGodmode()
				--SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
			end
		end
	end
end)

Citizen.Trace("Starting cheat sniffing")
-- create a new tick listener/function
Citizen.CreateThread(function()
	--Citizen.Trace("Sniffing")
	-- get the player info
		playerPed = GetPlayerPed(-1)
		playerid = PlayerId()
		playername = GetPlayerName(playerid)
	while true do	
		
		Citizen.Wait(5000)
		
		if canbeinvincible == false then
			Citizen.Wait(1000) -- Wait 1 second before checking to prevent false alarm upon join.
			--Citizen.Trace("Invincible checking")
			CheckInvincible()
		end
		
		--CheckInvincible()
		--CheckVehicle()
		--CheckPlayerCar()
		Citizen.Trace("Invisible checking")
		--CheckInvisible()
		Citizen.Trace("Check weapons")
		CheckWeapons()
		CheckTeleporting()
		-- infinite stamina
		Citizen.Trace("Infinite stam")
		ResetPlayerStamina(playerid)
		RestorePlayerStamina(playerid, 1)
		Wait(25000)
	end
end)

-- Check if player is whitelisted for vehicles
Citizen.CreateThread(function()
	while true do
		Wait(100)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			v = GetVehiclePedIsIn(playerPed, false)
		end
		playerPed = GetPlayerPed(-1)
		if whitelisted == nil and playerPed and v then
			if GetPedInVehicleSeat(v, -1) == playerPed then
				checkCar(GetVehiclePedIsIn(playerPed, false))
			end
		end
	end
end)

--[[function CheckVehicle()
	if PlayerPedId() then
		checkCar(GetVehiclePedIsIn(PlayerPedId(), false))

		x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
		for _, blacklistedCar in pairs(carBlacklist) do
			checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
		end
	end
end--]]

function TurnOffGodmode()
	--Citizen.Trace("Keep godmode off")
	SetPlayerInvincible(PlayerId(), false)
	SetEntityInvincible(PlayerPedId(), false)
	SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
end

function StarterWeapons()
	--Citizen.Trace("Anticheat gave starter weapons")
	-- give starter weapons
	GiveWeaponToPed(playerPed, GetHashKey("WEAPON_KNIFE"), 9999, true, false)
	GiveWeaponToPed(playerPed, GetHashKey("WEAPON_FLASHLIGHT"), 9999, true, false)
	GiveWeaponToPed(playerPed, GetHashKey("GADGET_PARACHUTE"), 9999, true, false)
end

function AllowGodmode()
	if canbeinvincible then
		Citizen.Trace("Allow godmode")
		SetEntityInvincible(PlayerPedId(), true)
		canbeinvincible = true
	end
end

function CheckInvincible()
	-- see if player has invincible on
	Citizen.Trace("See if invincible on")
	isinvincible = GetPlayerInvincible(PlayerId())
	Citizen.Trace("Invincible? " .. tostring(isinvincible))
	if canbeinvincible == false then
		if whitelisted == nil and isinvincible then
			--Citizen.Trace("turn off and kill player")
			-- kill the player
			KillPlayer("was caught with godmode.")
			-- turn off invincible
			SetEntityInvincible(PlayerPedId(), false)
		end
	end
end

function CheckInvisible()
	-- see if player is visible
	isvisible = IsEntityVisible(playerPed)
	--Citizen.Trace("Player visible? " .. tostring(isvisible))
	if whitelisted == nil and isvisible == false then
		-- turn off invincible
		SetEntityVisible(playerPed, true, 0)
		-- kill the player
		KillPlayer("was caught using his Harry Potter invisible blanket.")
	end
end

function CheckWeapons()
	-- no infinite ammo clips
	SetPedInfiniteAmmoClip(playerPed, false)
	SetPedInfiniteAmmo(playerPed, false)
		
	playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)
			if whitelisted == nil and isWeaponBlacklisted(weapon) then
				RemoveWeaponFromPed(playerPed, weapon)
				KillPlayer("thought he was Rambo.")
			end
		end
end

function isWeaponBlacklisted(model)
	local wepstring = tostring(model)
	
	if wepstring == "324215364" or wepstring == "2982836145" then
		return true
	end
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		local hash = GetHashKey(blacklistedWeapon)
		if model == GetHashKey(blacklistedWeapon) then
	--for _, blacklistedWeapon in pairs(weaponhashlist) do
		--if model == blacklistedWeapon then
			return true
		end
	end

	return false
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carBlacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

function CheckPlayerCar()
	--inVehicle = IsPedInAnyVehicle( ped, false )
    inVehicle = IsPedSittingInAnyVehicle(playerPed)
    -- If the player is in a car 
    if ( inVehicle ) then 
        vehicle = GetVehiclePedIsIn( playerPed, false )
		CheckCar(vehicle)
    end 
	
	x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	CheckCar(GetClosestVehicle(x, y, z, 100.0, 0, 70))
			
end

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			DeleteEntity(car)
			KillPlayer("was caught in a booby trapped vehicle")
		end
	end
end

function CheckTeleporting()
	teleporting = IsPlayerTeleportActive()
	if whitelisted == nil and teleporting then
		StopPlayerTeleport()
		KillPlayer("has been caught teleporting.")
	end
end

-- destroys a vehicle
function DestroyVehicle(vehicle, message)
	-- destroy the car
	--Citizen.InvokeNative(0x301A42153C9AD707, vehicle, true, true, true)
	PlaySound()
	killmessage = playername .. " " .. message
	TriggerServerEvent("ZA:BroadcastMessage", killmessage)
	-- set vehicle as mission entity so it can be deleted
	SetEntityAsMissionEntity(vehicle, true, true )
	-- delete the vehicle
	Citizen.Trace("Deleted Vehicle")
	DeleteVehicle(vehicle)
	Wait(1000)
	vehicle = nil
end

function PlaySound()
	SendNUIMessage({
		playsound = "cheater.ogg",
		soundvolume = volume
	})
end

function PlaySignal()
	SendNUIMessage({
		playsound = "signal.ogg",
		soundvolume = volume
	})
end

-- kills the player along with plays a terminated voice
function KillPlayer(message)
	cheatcount = cheatcount + 1
	local onelesscheat = maxcheats - 1
	
	if cheatcount == maxcheats then
		message = message .. ". FINAL WARNING BEFORE BEING KICKED"
	end
	
	playerid = PlayerId()
	playername = GetPlayerName(playerid)
	
	killmessage = playername .. " " .. message .. ".\n"
	TriggerServerEvent("ZA:BroadcastMessage", killmessage) 
	
	PlaySound()
	SetEntityHealth(GetPlayerPed(-1), -100)
	
	if cheatcount > maxcheats then
		TriggerServerEvent("kickCheater", source)
	end
	
	Citizen.Wait(3000)
end


-- force max speed to be 7.1 so they can't magically run faster, only exclusion is when parachuting
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local fallin = IsPedFalling(PlayerPedId())
		local ragg = IsPedRagdoll(PlayerPedId())
		local parac = GetPedParachuteState(PlayerPedId())
		if parac >= 0 or ragg or fallin then
			SetEntityMaxSpeed(PlayerPedId(), 80.0)
		else
			SetEntityMaxSpeed(PlayerPedId(), 7.1)
		end
	end
end)

-- Prevents invisibility with alpha
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		ResetEntityAlpha(PlayerPedId())
	end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end