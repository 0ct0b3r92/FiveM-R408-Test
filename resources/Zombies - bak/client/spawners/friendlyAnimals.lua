---- Original author of RottenV 3.0: Mr.Scammer
---- Some code used from Zombiespawner and converted to work as animals
---- Edited fully by Cody196
---- Some pieces of code put in place by Cody196




local maxAnimals = 10

local animalmodelhash = {
	0xD86B5A95, -- Deer
	0xFCFA9E1E, -- Cow
	0xCE5FF074 -- Boar
}
-- Total count of hashes for animalmodelhash
local hashTotal = 3

--The Main Code--
players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
end)

animals = {}

isclose = false
Citizen.CreateThread(function()
	AddRelationshipGroup("animals")
	AddRelationshipGroup("zombeez")
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("animals"))
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("animals"))
	
	while true do
		Citizen.Wait(1)
		-- spawn animals
		AnimalSpawner()
		
		for i, animal in pairs(animals) do
			if not DoesEntityExist(animal) then
				table.remove(animals, i)
			elseif IsPedDeadOrDying(animal, 1) then
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(animal, true))
				if GetPedSourceOfDeath(animal) == PlayerPedId() then
					if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 3.0)then
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
								DeleteEntity(animal)
								table.remove(animals, i)
							end
						end
					end
				end
			else
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY = table.unpack(GetEntityCoords(animal, true))

				if pedX < playerX - 750 or pedX > playerX + 750 or pedY < playerY - 750 or pedY > playerY + 750 then
					-- Set animal as no longer needed for despawning
					Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(animal))
					table.remove(animals, i)
				end
			end
		end
	end
end)

function AnimalSpawner()
	if #animals < maxAnimals then
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			
		-- load all the skins 
		for i, skinhash in pairs(animalmodelhash) do
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
		animal = CreatePed(28, animalmodelhash[hashint], newX, newY, z - 500, 0.0, true, false)
		
		-- Adds the blips for Zombies
		--SetEntityCoords(entity, X, Y, Z, xAxis, yAxis, zAxis, p7)
		blip = AddBlipForEntity(animal)
		SetBlipSprite(blip, 141)
		SetBlipAsShortRange(blip, true)
		
		SetPedSeeingRange(animal, 50.0)
		SetPedHearingRange(animal, 150.0)
		SetPedFleeAttributes(animal, 1, 1)
		SetPedRelationshipGroupHash(animal, GetHashKey("animals"))
		SetPedDiesInWater(animal, true)
		SetPedDiesWhenInjured(animal, true)
		
		x, y, z = table.unpack(GetEntityCoords(animal, true))
		TaskWanderStandard(animal, 1.0, 10)
		
		table.insert(animals, animal)
	end
end


function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end