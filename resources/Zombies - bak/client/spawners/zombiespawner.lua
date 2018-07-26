-- CONFIG --

-- Zombies have a 1 in 150 chance to spawn with guns
-- It will choose a gun in this list when it happens
-- Weapon list here: https://www.se7ensins.com/forums/threads/weapon-and-explosion-hashes-list.1045035/


local pedModels =
{
	"A_M_M_Hillbilly_02",
	"U_M_Y_Zombie_01",
	"u_f_m_corpse_01",
	"a_m_y_vindouche_01",
	"s_m_m_scientist_01",
	"a_m_m_golfer_01",
	"a_m_y_bevhills_01",
	"s_m_y_swat_01",
}

local walkStyles = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp"
}

local greenZones = {
	{name="Junkyard Base", x= 2384.00, y= 3090.00, z= 48.00},
	{name="Grapeseed Base", x= 2447.10, y= 4977.18, z= 46.82},
	{name="NRF Base", x= -1116.87, y= 4925.92, z= 218.23},
	{name="City Spawn", x= 142.73, y= -1076.33, z= 29.19},
}

local maxZombies = 40

-- CODE --

players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
end)

peds = {}

Citizen.CreateThread(function()
	AddRelationshipGroup("zombeez")
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("looters"))
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("badanimals"))
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("animals"))
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("friends"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("zombeez"))

	SetAiMeleeWeaponDamageModifier(2.0)

	while true do
		Citizen.Wait(1)
		if #peds < maxZombies then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

			choosenPed = pedModels[math.random(1, #pedModels)]
			choosenPed = string.upper(choosenPed)
			RequestModel(GetHashKey(choosenPed))
			while not HasModelLoaded(GetHashKey(choosenPed)) or not HasCollisionForModelLoaded(GetHashKey(choosenPed)) do
				Citizen.Wait(1)
			end

			local newX = x
			local newY = y
			local newZ = z + 999.0

			repeat
				Citizen.Wait(1)

				newX = x + math.random(-500, 500)
				newY = y + math.random(-500, 500)
				_,newZ = GetGroundZFor_3dCoord(newX+.0,newY+.0,z, 1)

				for _, player in pairs(players) do
					Citizen.Wait(1)
					playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					if newX > playerX - 35 and newX < playerX + 35 or newY > playerY - 35 and newY < playerY + 35 then
						canSpawn = false
						break
					else
						canSpawn = true
					end
				end
			until canSpawn

			ped = CreatePed(4, GetHashKey(choosenPed), newX, newY, newZ, 0.0, true, true)
			SetPedArmour(ped, 100)
			SetPedAccuracy(ped, 25)
			SetPedSeeingRange(ped, 10.0)
			SetPedHearingRange(ped, 1500.0)
			SetEntityHealth(ped, 500)
			SetEntityMaxHealth(ped, 500)
			SetPedCanBeDraggedOut(ped, false)

			SetPedFleeAttributes(ped, 0, 0)
			SetPedCombatAttributes(ped, 16, 1)
			SetPedCombatAttributes(ped, 17, 0)
			SetPedCombatAttributes(ped, 46, 1)
			SetPedCombatAttributes(ped, 1424, 0)
			SetPedCombatAttributes(ped, 5, 1)
			SetPedCombatRange(ped,2)
			SetPedAlertness(ped,3)
			SetPedTargetLossResponse(ped, 2)
			SetAmbientVoiceName(ped, "ALIENS")
			SetPedEnableWeaponBlocking(ped, true)
			SetPedRelationshipGroupHash(ped, GetHashKey("zombeez"))
			DisablePedPainAudio(ped, true)
			SetPedDiesInWater(ped, false)
			SetPedDiesWhenInjured(ped, false)
			--	PlaceObjectOnGroundProperly(ped)
			SetPedDiesInstantlyInWater(ped,true)
			SetPedIsDrunk(ped, true)
			SetPedConfigFlag(ped,100,1)
			
			walkStyle = walkStyles[math.random(1, #walkStyles)]
			
			RequestAnimSet(walkStyle)
			while not HasAnimSetLoaded(walkStyle) do
				Citizen.Wait(1)
			end
			SetPedMovementClipset(ped, walkStyle, 1.0)
			ApplyPedDamagePack(ped,"BigHitByVehicle", 0.0, 9.0)
			ApplyPedDamagePack(ped,"SCR_Dumpster", 0.0, 9.0)
			ApplyPedDamagePack(ped,"SCR_Torture", 0.0, 9.0)
			StopPedSpeaking(ped,true)
			
			blip = AddBlipForEntity(ped)
			SetBlipSprite(blip, 84)
			SetBlipAsShortRange(blip, true)

			TaskWanderStandard(ped, 1.0, 10)
			local pspeed = math.random(20,70)
			local pspeed = pspeed/10
			local pspeed = pspeed+0.01
			SetEntityMaxSpeed(ped, 5.0)

			if not NetworkGetEntityIsNetworked(ped) then
				NetworkRegisterEntityAsNetworked(ped)
			end

			table.insert(peds, ped)
		end

		for i, ped in pairs(peds) do
			if DoesEntityExist(ped) == false then
				table.remove(peds, i)
			end
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(ped, true))
			if IsPedDeadOrDying(ped, 1) == 1 then
				-- Set ped as no longer needed for despawning
				local dropChance = math.random(0,100)
				if GetPedSourceOfDeath(ped) == PlayerPedId() then
					if dropChance >= 95 then
						ForceCreateFoodPickupAtCoord(pedX,pedY,pedZ)
					end
					zombiekillsthislife = zombiekillsthislife+1
					zombiekills = zombiekills+1
				end

				Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))
				table.remove(peds, i)
			else
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				SetPedArmour(ped, 100)
				SetPedAccuracy(ped, 25)
				SetPedSeeingRange(ped, 10.0)
				SetPedHearingRange(ped, 1500.0)

				SetPedFleeAttributes(ped, 0, 0)
				SetPedCombatAttributes(ped, 16, 1)
				SetPedCombatAttributes(ped, 17, 0)
				SetPedCombatAttributes(ped, 46, 1)
				SetPedCombatAttributes(ped, 1424, 0)
				SetPedCombatAttributes(ped, 5, 1)
				SetPedCombatRange(ped,2)
				SetAmbientVoiceName(ped, "ALIENS")
				SetPedEnableWeaponBlocking(ped, true)
				SetPedRelationshipGroupHash(ped, GetHashKey("zombeez"))
				DisablePedPainAudio(ped, true)
				SetPedDiesInWater(ped, false)
				SetPedDiesWhenInjured(ped, false)
				
				-- Kill and delete zombies in greenzones
				for k,v in ipairs(greenZones) do
					--DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 200.0, 200.0, 10.0, 0, 255, 0,165, 0, 0, 0,0)
					if(Vdist(pedX, pedY, pedZ, v.x, v.y, v.z) < 200.0)then
						Citizen.Trace("Zombie entered greenzone")
						SetEntityHealth(ped, 0)
						DeleteEntity(ped)
						SetEntityAsNoLongerNeeded(ped)
						RemoveBlip(blip)
						table.remove(peds, i)
					end
				end
				
				-- Makes zombies ragdoll in vehicle but not when being shot
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					SetPedCanRagdoll(ped, true)
				elseif not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					SetPedCanRagdoll(ped, false)
				end
				
				if pedX < playerX - 600 or pedX > playerX + 600 or pedY < playerY - 600 or pedY > playerY + 600 then
					-- Set ped as no longer needed for despawning
					local model = GetEntityModel(ped)
					SetEntityAsNoLongerNeeded(ped)
					SetModelAsNoLongerNeeded(model)
					table.remove(peds, i)
				end
			end
		end
	end
end)

RegisterNetEvent("Z:cleanup")
AddEventHandler("Z:cleanup", function()
	for i, ped in pairs(peds) do
		-- Set ped as no longer needed for despawning
		local model = GetEntityModel(ped)
		SetEntityAsNoLongerNeeded(ped)
		SetModelAsNoLongerNeeded(model)

		table.remove(peds, i)
	end
end)
