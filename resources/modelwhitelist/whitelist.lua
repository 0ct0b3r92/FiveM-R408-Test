whitelist = {
	"steam:110000105ce25a9", -- Cody196
	"steam:110000106efd411", -- GeekRiot
	"steam:110000105c592e2", -- Ganjamonster
	"steam:11000010d91fad2", -- The Husky Jerk
	"steam:11000011412cfa2", -- Drgta
	"steam:110000110cd8dca",
	"steam:11000010a6798bd",
	"steam:110000107045158",
	"steam:11000010d68be8f", -- _Fade
	"steam:1100001054985e9" -- Ryan
}
RegisterServerEvent('white')
AddEventHandler('white', function()
	local numIds = GetPlayerIdentifiers(source)
	for i,admin in ipairs(whitelist) do
		for i,theId in ipairs(numIds) do
			if admin == theId then -- is the player an admin?
				TriggerClientEvent("checkwhitelist", source, "gg")
				print('An admin joined')
			end
		end
	end
end)