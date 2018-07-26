
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	
	
	if sm[1] == "/help" then
    CancelEvent()
    TriggerClientEvent("ToogleInformation", source)
	
    end
   
end)


RegisterServerEvent("openInfo")
AddEventHandler('openInfo', function(spawn)
	TriggerClientEvent("ToogleInformation", source)
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