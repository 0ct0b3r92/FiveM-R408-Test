whitelist = {
	"steam:110000105ce25a9", -- Cody196
	"steam:110000106efd411", -- GeekRiot
	"steam:110000105c592e2", -- Ganjamonster
	"steam:11000010d91fad2", -- The Husky Jerk
	"steam:11000011412cfa2", -- Drgta
	"steam:11000010d68be8f", -- _Fade
	"steam:1100001054985e9", -- Ryan
	"steam:11000010a10dbe5", -- MetalcoreSucks
	"steam:11000011c73b0b2", -- Pablo
	"steam:11000010d23733a", -- MeNoHasHax aka Blitz Color
	"steam:1100001043dc7b9", -- red
	"steam:11000010533f850", -- Negan Grimes
	"steam:11000010593a0e5", -- AceAstral
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

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end