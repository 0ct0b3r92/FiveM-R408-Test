local maxBadAnimals = 5

local badanimalmodelhash = {
	0x1250D7BA, -- Mountain Lion
	0x644AC75E, -- Coyote
}
-- Total count of hashes for animalmodelhash
local hashTotal = 2

--The Main Code--
players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
	--[[local playercount = 0;
	for i, ped in pairs(players) do
		playercount = playercount + 1
	end
	maxBadAnimals = 5
	Citizen.Trace("Maximum spawnable badanimals: " .. maxBadAnimals .. "\n")--]]
end)

badanimals = {}

Citizen.CreateThread(function()
	AddRelationshipGroup("badanimals")
	SetRelationshipBetweenGroups(5, GetHashKey("badanimals"), GetHashKey("PLAYER"))
	--SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("badanimals"))
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("badanimals"))
	SetRelationshipBetweenGroups(5, GetHashKey("badanimals"), GetHashKey("zombeez"))
	
	while true do
		Citizen.Wait(1)
		-- spawn bad animals
		BadAnimalSpawner()
		
		for i, ped in pairs(badanimals) do
			if not DoesEntityExist(ped) then
				table.remove(badanimals, i)
			elseif IsPedDeadOrDying(ped, 1) then
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(ped, true))
				if GetPedSourceOfDeath(ped) == PlayerPedId() then
					if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 5.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to harvest animal.")
						if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
							if DoesEntityExist(GetPlayerPed(-1)) then
								RequestAnimDict("pickup_object")
								while not HasAnimDictLoaded("pickup_object") do
								Citizen.Wait(1)
								end
								TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8, -1, 49, 0, 0, 0, 0)
								DecorSetFloat(PlayerPedId(), "hunger", DecorGetFloat(PlayerPedId(),"hunger")+5)
								DecorSetFloat(PlayerPedId(), "thirst", DecorGetFloat(PlayerPedId(),"thirst")+2)
								Citizen.Wait(2000)
								ClearPedSecondaryTask(GetPlayerPed(-1))
								DeleteEntity(ped)
								table.remove(badanimals, i)
							end
						end
					end
				end
			else
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY = table.unpack(GetEntityCoords(ped, true))

				if pedX < playerX - 750 or pedX > playerX + 750 or pedY < playerY - 750 or pedY > playerY + 750 then
					-- Set ped as no longer needed for despawning
					Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))
					table.remove(badanimals, i)
				end
			end
		end
	end
end)

function BadAnimalSpawner()
	if #badanimals < maxBadAnimals then
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			
		-- load all the skins 
		for i, skinhash in pairs(badanimalmodelhash) do
			RequestModel(skinhash)
			while not HasModelLoaded(skinhash) do
				Citizen.Wait(1)
			end
		end
		
		repeat
			Citizen.Wait(1)

			newX = x + math.random(-750, 750)
			newY = y + math.random(-750, 750)

			--for _, player in pairs(players) do
				player = PlayerId()
				Citizen.Wait(1)
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
				if newX > playerX - 60 and newX < playerX + 60 or newY > playerY - 60 and newY < playerY + 60 then
					canSpawn = false
					break
				else
					canSpawn = true
				end
			--end
		until canSpawn
		
		
		-- set a random skin
		hashint = math.random(1, hashTotal)
		ped = CreatePed(4, badanimalmodelhash[hashint], newX, newY, z - 500, 0.0, true, false)
		
		-- Adds the blips for Zombies
		--SetEntityCoords(entity, X, Y, Z, xAxis, yAxis, zAxis, p7)
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 442)
		SetBlipAsShortRange(blip, true)
		
		SetPedSeeingRange(ped, 50.0)
		SetPedHearingRange(ped, 150.0)
		SetPedFleeAttributes(ped, 0, 0)
		SetPedCombatAttributes(ped, 46, 1)
		SetPedCombatAttributes(ped, 5, 1)
		SetPedCombatAbility(ped, 100)
		SetPedCombatRange(ped, 2)
		SetPedCombatMovement(ped, 3)
		SetPedRelationshipGroupHash(ped, GetHashKey("badanimals"))
		SetPedDiesInWater(ped, true)
		SetPedDiesWhenInjured(ped, true)
		
		x, y, z = table.unpack(GetEntityCoords(ped, true))
		TaskWanderStandard(ped, 1.0, 10)
		
		table.insert(badanimals, ped)
	end
end