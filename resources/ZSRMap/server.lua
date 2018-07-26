
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	
	
	if sm[1] == "/openmap" then
    CancelEvent()
    TriggerClientEvent("ToogleZSRMap", source)
	
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