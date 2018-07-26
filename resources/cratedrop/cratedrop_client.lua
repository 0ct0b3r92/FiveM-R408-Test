weaponList = {
    ["carbine"] = "PICKUP_WEAPON_CARBINERIFLE",
    ["flaregun"] = "PICKUP_WEAPON_FLAREGUN",
    ["landmine"] = "PICKUP_WEAPON_PROXMINE",
    ["heavysniper"] = "PICKUP_WEAPON_HEAVYSNIPER",
    ["combatpdw"] = "PICKUP_WEAPON_COMBATPDW",
    ["medkit"] = "PICKUP_HEALTH_STANDARD",
    ["armor"] = "PICKUP_ARMOUR_STANDARD",
    ["handcuffkey"] = "PICKUP_HANDCUFF_KEY",
    ["gusenberg"] = "PICKUP_WEAPON_GUSENBERG",
    ["rpg"] = "PICKUP_WEAPON_RPG",
}

-- feel free to expand the weaponList, I can't be bothered to add everything there, format is as follows: ["chat command argument"] = "pickup model name"
-- http://web.archive.org/web/20170909034953/http://gtaforums.com/topic/883160-dlc-weapons-pickup-hashes/

local dropCount = 0
local dropRadius = 500

-- Reset the drop count after a while
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60 * 60000)
		dropCount = 0
	end
end)

RegisterCommand("drop", function(source,args,raw)
	dropCount = dropCount + 1
	if dropCount <= 1 then
		if weaponList[args[1]] == nil then
			if tonumber(args[2]) == nil then
				print("cratedrop failed: weapon and ammo count unrecognized")
				TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "Weapon or ammo not recognized. Weapons are: armor, carbine, combatpdw, flaregun, gusenberg, handcuffkey, heavysniper, landmine, and medkit.")
			else
				print("cratedrop failed: weapon unrecognized, ammo count: " .. args[2])
				TriggerEvent("chatMessage", "^1SYSTEM", {255, 255, 255}, "Weapon not recognized. Weapons are: armor, carbine, combatpdw, flaregun, gusenberg, handcuffkey, heavysniper, landmine, and medkit.")
			end
		elseif weaponList[args[1]] ~= nil and tonumber(args[2]) == nil then
			TriggerEvent("Cratedrop:Execute", args[1], 250)
			TriggerServerEvent("HighSupplyInbound")
			print("cratedrop succeeded: weapon: " .. args[1] .. ", ammo count unrecognized, defaulting to 250")
		elseif weaponList[args[1]] ~= nil and tonumber(args[2]) ~= nil then
			TriggerEvent("Cratedrop:Execute", args[1], tonumber(args[2]))
			TriggerServerEvent("HighSupplyInbound")
			print("cratedrop succeeded: weapon: " .. args[1] .. ", ammo count: " .. args[2])
		end
	elseif dropCount > 1 then
		TriggerEvent("chatMessage", "^2MERRYWEATHER", {255, 255, 255}, "There are no supply drops at this time.")
	end
end, false)

RegisterNetEvent("Cratedrop:Execute")

AddEventHandler("Cratedrop:Execute", function(weapon, ammo)
    Citizen.CreateThread(function()
        local requiredModels = {"p_parachute1_mp_dec", "ex_prop_adv_case_sm", "bombushka", "s_m_m_pilot_02", "prop_box_wood02a_pu"}
		
        for i = 1, #requiredModels do
            RequestModel(GetHashKey(requiredModels[i]))
            while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                Wait(100)
            end
        end

        --[[

        local requiredPtfx = {"scr_crate_drop_flare", "scr_crate_drop_smoke"}

        for i = 1, #requiredPtfx do
            RequestNamedPtfxAsset(GetHashKey(requiredPtfx[i])) -- script gets stuck if attempted to load
            while not HasNamedPtfxAssetLoaded(GetHashKey(requiredPtfx[i])) do
                Wait(100)
            end
        end

        UseParticleFxAssetNextCall("scr_crate_drop_flare")
        UseParticleFxAssetNextCall("scr_crate_drop_smoke")

        RequestAnimDict("p_parachute1_mp_dec")
        while not HasAnimDictLoaded("p_parachute1_mp_dec") do -- wasn't able to get animations working
            Wait(1)
        end

        ]]

        RequestWeaponAsset(GetHashKey("weapon_flare"))
        while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
            Wait(100)
        end

        local playerPed = GetPlayerPed(-1)
        local fx, fy, fz = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 15.0, 0))
        local px, py, pz = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -400.0, 500.0))
        local playerHeading = GetEntityHeading(playerPed)

        aircraft = CreateVehicle(GetHashKey("bombushka"), px, py, pz, playerHeading, true, true)
        SetEntityHeading(aircraft, playerHeading)
        SetVehicleDoorsLocked(aircraft, 2)
        FreezeEntityPosition(aircraft, false)
        SetEntityDynamic(aircraft, true)
        ActivatePhysics(aircraft)
        SetVehicleForwardSpeed(aircraft, 60.0)
        SetHeliBladesFullSpeed(aircraft)
        SetVehicleEngineOn(aircraft, true, true, false)
        SetVehicleEngineCanDegrade(aircraft, false)
        ControlLandingGear(aircraft, 3)
        OpenBombBayDoors(aircraft)
        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)

        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
        SetBlockingOfNonTemporaryEvents(pilot, true)
        SetPedRandomComponentVariation(pilot, false)
        SetPedKeepTask(pilot, true)
        SetEntityHealth(pilot, 200)
        SetPlaneMinHeightAboveTerrain(aircraft, 50)
        TaskVehicleDriveToCoord(pilot, aircraft, fx, fy, fz + 200, 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0);

        local hx, hy = table.unpack(GetEntityCoords(aircraft))
        while not IsEntityDead(pilot) and not (((fx - 5) < hx) and (hx < (fx + 5)) and ((fy - 5) < hy) and (hy < (fy + 5))) do
            Wait(100)
            hx, hy = table.unpack(GetEntityCoords(aircraft))
        end

        if IsEntityDead(pilot) == true then 
            do return end
        end

        cx, cy, cz = table.unpack(GetEntityCoords(playerPed))
		
		-- Use these to change the radius of where the crate can drop at from the player
		randomX = cx + math.random(-dropRadius, dropRadius)
		randomY = cy + math.random(-dropRadius, dropRadius)
		
		-- This determines how highabove the ground or players position to start the drop
		dropHeight = 250
		
        TaskVehicleDriveToCoord(pilot, aircraft, 0, 0, 500, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0)
        SetEntityAsNoLongerNeeded(pilot)
        SetEntityAsNoLongerNeeded(aircraft)

        advancedCrate = CreateObject(GetHashKey("prop_box_wood02a_pu"), randomX, randomY, cz + dropHeight, true, true, true)
        SetEntityLodDist(advancedCrate, 1000)
        SetEntityInvincible(advancedCrate, false)
        SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(advancedCrate, true)
        SetEntitySomething(advancedCrate, true)
        ActivatePhysics(advancedCrate)
        SetDamping(advancedCrate, 2, 0.1)
        SetEntityVelocity(advancedCrate, 0.0, 0.0, -0.2)

        --cx, cy, cz = table.unpack(GetEntityCoords(playerPed))
		
        crateParachute = CreateObject(GetHashKey("p_parachute1_mp_dec"), randomX, randomY, cz + dropHeight, true, true, true)
        SetEntityLodDist(crateParachute, 1000)
        SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(crateParachute, true)
        SetEntityVelocity(crateParachute, 0.0, 0.0, -0.2)
        -- PlayEntityAnim(crateParachute, "p_parachute1_mp_dec_deploy", "p_parachute1_mp_dec", 1000.0, false, false, false, 0, 0) -- disabled since animations don't work
        -- ForceEntityAiAndAnimationUpdate(crateParachute) -- pointless if animations aren't working

        weaponInsideCrate = CreateAmbientPickup(GetHashKey(weaponList[weapon]), randomX, randomY, cz + dropHeight, 0, ammo, GetHashKey("ex_prop_adv_case_sm"), true, true)
        SetEntityInvincible(weaponInsideCrate, true)
        SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(weaponInsideCrate, true)
        ActivatePhysics(weaponInsideCrate)
        SetDisableBreaking(weaponInsideCrate, false)
        SetDamping(weaponInsideCrate, 2, 0.0245)
        SetEntityVelocity(weaponInsideCrate, 0.0, 0.0, -0.2)

        soundID = GetSoundId()
        PlaySoundFromEntity(soundID, "Crate_Beeps", weaponInsideCrate, "MP_CRATE_DROP_SOUNDS", true, 0)

        local blip = AddBlipForEntity(weaponInsideCrate)
        SetBlipSprite(blip, 351) -- or 408
        SetBlipNameFromTextFile(blip, "AMD_BLIPN")
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        SetBlipAlpha(blip, 120)

        -- crateBeacon = StartParticleFxLoopedOnEntity_2("scr_crate_drop_beacon", weaponInsideCrate, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 1.0, false, false, false) -- no idea how to make it work, weapon_flare will do for now
        -- SetParticleFxLoopedColour(crateBeacon, 0.8, 0.18, 0.19, false)

        AttachEntityToEntity(crateParachute, weaponInsideCrate, 0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        AttachEntityToEntity(weaponInsideCrate, advancedCrate, 0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0, false, false, true, false, 2, true)

        while HasObjectBeenBroken(advancedCrate) == false do
            Wait(100)
        end

        local jx, jy, jz = table.unpack(GetEntityCoords(crateParachute))
        ShootSingleBulletBetweenCoords(jx, jy, jz, jx, jy + 0.0001, jz - 0.0001, 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0)
        DetachEntity(crateParachute, true, true)
        SetEntityCollision(crateParachute, false, true)
        -- PlayEntityAnim(crateParachute, "p_parachute1_mp_dec_crumple", "p_parachute1_mp_dec", 1000.0, false, false, false, 0, 0) -- disabled since animations don't work
        DeleteEntity(crateParachute)
        DetachEntity(weaponInsideCrate)
        SetBlipAlpha(blip, 255)

        while DoesEntityExist(weaponInsideCrate) do
            Wait(100)
        end

        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end

        StopSound(soundID)
        ReleaseSoundId(soundID)

        for i = 1, #requiredModels do
            Wait(100)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end

        RemoveWeaponAsset(GetHashKey("weapon_flare"))
    end)
end)