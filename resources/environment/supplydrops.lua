---- Created By: Cody196
---- Creation Date: 4/25/2018

-- Hashes for some of the crate objects
local crates = {
	"prop_crate_01a",
	"prop_crate_02a",
	"prop_crate_08a",
	"prop_crate_09a",
}

-- Spawn locations for the supply drops
local dropLocations = {
	{x= 671.73, y= -1738.00, z= 29.35},
}

-- Main Code That Spawns The Supply Drops and Controls Distance Between Player and Crate
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5 * 60000) -- 5 times 60000 milliseconds for easier way to say 5 minutes
		for k,v in ipairs(dropLocations) do
			randomCrate = crates[math.random(1, #crates)]
			crate = CreateObject(GetHashKey(randomCrate), v.x, v.y, v.z, true, true, false)
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			crateX, crateY, crateZ = table.unpack(GetEntityCoords(crate, true))
			if(Vdist(playerX, playerY, playerZ, crateX, crateY, crateZ) < 5.0)then
				Citizen.Trace("Player is near crate")
				if IsControlJustReleased(1, 51) then
					Citizen.Trace("Loot Collected")
					DeleteEntity(crate)
				end
			end
		end
	end
end)