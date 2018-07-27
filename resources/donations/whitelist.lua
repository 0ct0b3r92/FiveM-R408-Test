donators = {
	"steam:110000105ce25a9", -- Cody196
	"steam:1100001054985e9", -- Ryan
	"steam:11000010d23733a", -- MeNoHasHax aka Blitz Color
	"steam:1100001043dc7b9", -- red
}

RegisterServerEvent('donatorwhitelist')
AddEventHandler('donatorwhitelist', function()
	local numIds = GetPlayerIdentifiers(source)
	for i,donator in ipairs(donators) do
		for i,theId in ipairs(numIds) do
			if donator == theId then -- is the player a donator?
				TriggerClientEvent("checkDonators", source, "gg")
				print('A donator joined')
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