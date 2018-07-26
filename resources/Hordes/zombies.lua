
-- All the coordinates where zombies can spawn at
local zombieCoords = {
	{x=443.91506958008, y=-983.49114990234, z=30.689605712891}, 
	{x=451.52655029297, y=-979.89123535156, z=30.689605712891}, 
	{x=469.35598754883, y=-984.71417236328, z=30.689615249634}, 
	{x=464.87042236328, y=-983.85925292969, z=35.891944885254}, 
	{x=465.10607910156, y=-983.39581298828, z=39.891841888428}, 
	{x=461.4714050293, y=-990.51916503906, z=43.691646575928}, 
	{x=447.38732910156, y=-995.89794921875, z=43.691646575928}, 
	{x=438.40637207031, y=-987.15838623047, z=43.691677093506}, 
	{x=442.21740722656, y=-980.52380371094, z=43.691677093506}, 
	{x=458.09390258789, y=-991.00494384766, z=30.689609527588}, 
	{x=438.56976318359, y=-992.32379150391, z=30.689609527588}, 
	{x=452.23495483398, y=-987.63555908203, z=26.674209594727}, 
	{x=463.68478393555, y=-990.67230224609, z=24.914875030518}, 
	{x=3617.2102050781, y=3721.71484375, z=29.689392089844}, 
	{x=3562.9128417969, y=3679.2180175781, z=28.121881484985}, 
	{x=3560.8032226563, y=3665.5190429688, z=28.12188911438}, 
	{x=3557.5805664063, y=3662.8073730469, z=28.121881484985}, 
	{x=3547.6345214844, y=3641.1433105469, z=28.12188911438}, 
	{x=3547.8354492188, y=3641.4370117188, z=28.121891021729}, 
	{x=3539.9560546875, y=3665.7353515625, z=28.121870040894}, 
	{x=3539.0280761719, y=3663.8557128906, z=28.121870040894}, 
	{x=3537.6000976563, y=3665.85546875, z=28.121870040894}, 
	{x=3535.6789550781, y=3664.2919921875, z=28.121870040894}, 
	{x=3535.0822753906, y=3666.4106445313, z=28.121870040894}, 
	{x=3533.2377929688, y=3660.7192382813, z=28.121868133545}, 
	{x=3527.5380859375, y=3673.3654785156, z=28.12113571167}, 
	{x=3541.8022460938, y=3671.2333984375, z=28.12113571167}, 
	{x=3546.1149902344, y=3641.4995117188, z=28.121866226196}, 
	{x=3540.5578613281, y=3676.1440429688, z=28.12113571167}, 
	{x=3545.7807617188, y=3642.7958984375, z=28.121866226196}, 
	{x=3545.9565429688, y=3641.6965332031, z=28.121866226196}, 
	{x=3554.5620117188, y=3660.0017089844, z=28.12188911438}, 
	{x=3553.3408203125, y=3660.9580078125, z=28.122137069702}, 
	{x=3562.0380859375, y=3673.673828125, z=28.121887207031}, 
	{x=3561.126953125, y=3671.3996582031, z=28.121887207031}, 
	{x=3560.4130859375, y=3668.4201660156, z=28.121887207031}, 
	{x=3566.6459960938, y=3682.5895996094, z=28.122117996216}, 
	{x=3557.9719238281, y=3669.6225585938, z=28.121887207031}, 
	{x=3559.537109375, y=3695.8833007813, z=30.121795654297}, 
}
	
-- The Zombie Skins
local zombies = {
	"A_M_M_Hillbilly_02",
	"U_M_Y_Zombie_01",
	"u_f_m_corpse_01",
	"a_m_y_vindouche_01",
	"s_m_m_scientist_01",
	"s_m_y_swat_01",
	"zombie",
	"zombie2",
	"zombie4",
	"zombie5",
	"zombie6",
	"copZ",
	"CorpZ",
	"DocZ",
	"HcopZ",
	"ParaZ",
}

local walkStyles = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

spawned = false
canspawn = false

zombiepeds = {}

playingsound = false
inRange = false


-- Spawn the Zombies
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(zombieCoords) do
			if #zombiepeds < 40 then
				x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			
				local newX = x
				local newY = y

				repeat
					Citizen.Wait(1)

					newX = x + math.random(-500, 500)
					newY = y + math.random(-500, 500)

					--for _, player in pairs(players) do
						Citizen.Wait(1)
						playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
						if newX > playerX - 25 and newX < playerX + 25 or newY > playerY - 25 and newY < playerY + 25 then
							canSpawn = false
							break
						else
							canSpawn = true
						end
					--end
				until canSpawn
						zombiePed = zombies[math.random(1, #zombies)]
						zombiePed = string.upper(zombiePed)
						RequestModel(GetHashKey(zombiePed))
						while not HasModelLoaded(GetHashKey(zombiePed)) or not HasCollisionForModelLoaded(GetHashKey(zombiePed)) do
							Citizen.Wait(100)
						end
						
						zombie = CreatePed(4, GetHashKey(zombiePed), v.x, v.y, v.z, 0, true, false)
						Citizen.Trace("Horde Zombie Spawned")
						
						SetPedAccuracy(zombie, 25)
						SetEntityHealth(zombie, 400)
						SetEntityMaxHealth(zombie, 400)
						SetPedPathCanUseClimbovers(zombie, false)
						SetPedPathCanUseLadders(zombie, false)
						SetPedPathAvoidFire(zombie, false)
						SetPedPathCanDropFromHeight(zombie, true)
						
						SetAiMeleeWeaponDamageModifier(0.1)
						AddRelationshipGroup("caged")
						SetRelationshipBetweenGroups(5, GetHashKey("caged"), GetHashKey("PLAYER"))
						SetRelationshipBetweenGroups(5, GetHashKey("caged"), GetHashKey("looters"))
						SetRelationshipBetweenGroups(5, GetHashKey("caged"), GetHashKey("badanimals"))
						SetRelationshipBetweenGroups(5, GetHashKey("caged"), GetHashKey("animals"))
						SetRelationshipBetweenGroups(5, GetHashKey("caged"), GetHashKey("friends"))
						SetRelationshipBetweenGroups(5, GetHashKey("caged"), GetHashKey("ngf"))
						SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("caged"))
						
						SetPedSeeingRange(zombie, 10.0)
						SetPedHearingRange(zombie, 1000.0)
						SetPedFleeAttributes(zombie, 0, 0)
						SetPedCombatAttributes(zombie, 16, 1)
						SetPedCombatAttributes(zombie, 17, 0)
						SetPedCombatAttributes(zombie, 46, 1)
						SetPedCombatAttributes(zombie, 1424, 0)
						SetPedCombatAttributes(zombie, 5, 1)
						SetPedCombatRange(zombie,2)
						SetPedAlertness(zombie,3)
						SetPedTargetLossResponse(zombie, 2)
						SetAmbientVoiceName(zombie, "ALIENS")
						SetPedEnableWeaponBlocking(zombie, false)
						SetPedRelationshipGroupHash(zombie, GetHashKey("caged"))
						DisablePedPainAudio(zombie, true)
						SetPedDiesInWater(zombie, false)
						SetPedDiesWhenInjured(zombie, false)
						SetPedDiesInstantlyInWater(zombie,true)
						SetPedIsDrunk(zombie, true)
						SetPedConfigFlag(zombie,100,1)
							
						walkStyle = walkStyles[math.random(1, #walkStyles)]
						
						RequestAnimSet(walkStyle)
						while not HasAnimSetLoaded(walkStyle) do
							Citizen.Wait(100)
						end
						SetPedMovementClipset(zombie, walkStyle, 1.0)
						ApplyPedDamagePack(zombie,"BigHitByVehicle", 0.0, 9.0)
						ApplyPedDamagePack(zombie,"SCR_Dumpster", 0.0, 9.0)
						ApplyPedDamagePack(zombie,"SCR_Torture", 0.0, 9.0)
						StopPedSpeaking(zombie,true)
							
						blip = AddBlipForEntity(zombie)
						SetBlipSprite(blip, 84)
						SetBlipAsShortRange(blip, true)
						
						TaskWanderStandard(zombie, 1.0, 10)
						--TaskWanderInArea(zombie, v.x, v.y, v.z, 25, 1.0, 10)
						local pspeed = math.random(20,70)
						local pspeed = pspeed/10
						local pspeed = pspeed+0.01
						SetEntityMaxSpeed(zombie, 5.0)
						
						--Citizen.Wait(100)
						table.insert(zombiepeds, zombie)
						
						--[[if #zombiepeds > 40 then
							spawned = true
						end--]]
			end
		end
	
		for i, zombie in pairs(zombiepeds) do
			if DoesEntityExist(zombie) == false then
				table.remove(zombiepeds, i)
			end
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(zombie, true))
			
			if IsPedDeadOrDying(zombie, 1) == 1 then
				Citizen.Wait(60000)
				SetEntityAsNoLongerNeeded(zombie)
				DeleteEntity(zombie)
				table.remove(zombiepeds, i)
			end
				SetPedArmour(zombie, 0)
				SetPedAccuracy(zombie, 25)

				SetPedSeeingRange(zombie, 10.0)
				SetPedHearingRange(zombie, 1000.0)
				SetAiMeleeWeaponDamageModifier(1.0)
				SetPedFleeAttributes(zombie, 0, 0)
				SetPedCombatAttributes(zombie, 16, 1)
				SetPedCombatAttributes(zombie, 17, 0)
				SetPedCombatAttributes(zombie, 46, 1)
				SetPedCombatAttributes(zombie, 1424, 0)
				SetPedCombatAttributes(zombie, 5, 1)
				SetPedCombatRange(zombie,2)
				SetAmbientVoiceName(zombie, "ALIENS")
				SetPedEnableWeaponBlocking(zombie, false)
				SetPedRelationshipGroupHash(zombie, GetHashKey("caged"))
				DisablePedPainAudio(zombie, true)
				SetPedDiesInWater(zombie, false)
				SetPedDiesWhenInjured(zombie, false)
			if pedX < playerX - 500 or pedX > playerX + 500 or pedY < playerY - 500 or pedY > playerY + 500 then
				-- Set ped as no longer needed for despawning
				SetEntityAsNoLongerNeeded(zombie)
				DeleteEntity(zombie)
				--table.remove(zombiepeds, i)
				Citizen.Trace("Deleted far away horde zombie")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		distance = Vdist(playerX, playerY, playerZ, 1689.76, 3257.17, 40.87)
        
		if distance < 15 then
			if playingsound == true and inRange == false then
				Citizen.Trace("Volume up")
				volume = 1.0
				PlayHorde()
				inRange = true
			end
		elseif distance > 15 and distance < 30 then
			if playingsound == false then
				volume = 0.5
				PlayHorde()
				Citizen.Trace("Volume medium")
				playingsound = true
			end
		elseif distance > 30 then
			if playingsound == true then
				volume = 0.0
				StopHorde()
				Citizen.Trace("Volume down")
				playingsound = false
				inRange = false
			end
		end
	end
end)

function PlayHorde()
	SendNUIMessage({
		playsound = "horde.ogg",
		soundvolume = volume
	})
end

function StopHorde()
	SendNUIMessage({
		stopsound = "horde.ogg",
	})
end