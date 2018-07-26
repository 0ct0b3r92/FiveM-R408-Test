---- Script created by Cody196

Citizen.CreateThread(function()
-- Coordinates where cars can spawn at
local carSpawnCoords = {
	{x=2465.23, y=4063.49, z=37.78},
	{x=1570.49, y=3631.48, z=35.33},
	{x=-35.45, y=6414.66, z=31.49},
	{x=427.52, y=6469.88, z=28.78}
}
-- Coordinates for the blips
local carBlips = {
	{id=85, x=2465.23, y=4063.49, z=37.78},
	{id=85, x=1570.49, y=3631.48, z=35.33},
	{id=85, x=-35.45, y=6414.66, z=31.49},
	{id=85, x=427.52, y=6469.88, z=28.78}
}

-- List of vehicles that can spawn
local vehicles = {
	"barracks",
	"voodoo2",
	"ratbike",
	"sanctus",
	"towtruck2",
	"caddy2",
	"gargoyle",
	"tornado3",
	"ratbike",
	"gargoyle",
	"tornado6",
	"ratloader",
	"rebel",
	"bfinjection",
	"dune",
	"dloader",
	"emperor2",
	"rubble",
	"bulldozer",
	"journey",
	"surfer2",
	"barracks2",
	"barracks3",
	"tractor",
	"wastelander",
	"scrap",
	"triptruck2"
}

local carCount = 27

-- Creates the blips for the vehicles on the map
for _, map in pairs(carBlips) do
	map.blip = AddBlipForCoord(map.x, map.y, map.z)
	SetBlipSprite(map.blip, map.id)
	SetBlipAsShortRange(map.blip, true)
end

-- Spawns the cars at the desired locations
for _, car in pairs(carSpawnCoords) do
	--carnum = math.random(1, carCount)
	--loothash = GetHashKey(loot(lootitemnum)
	
	spawnCar = vehicles[math.random(1, #vehicles)]
	RequestModel(spawnCar)
	while not HasModelLoaded(spawnCar) or not HasCollisionForModelLoaded(spawnCar) do
		Citizen.Wait(1)
	end
	
	car = CreateVehicle(spawnCar, car.x, car.y, car.z, math.random(), true, true)
	SetVehicleDirtLevel(car, 15.0)
	SetVehicleEngineHealth(car, math.random(400,1000)+0.0)
	SetVehicleFuelLevel(car, math.random() + math.random(0, 50))
end

end)