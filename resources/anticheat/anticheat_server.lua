RegisterServerEvent("ZA:BroadcastMessage")
AddEventHandler("ZA:BroadcastMessage", function(message)
      TriggerClientEvent("chatMessage", -1, "^1CHEATER ALERT!", {255, 255, 255}, message)
end)

strings = { -- these are the strings we use to show our players, feel free to edit to your liking
	-- EasyAdmin Base strings
	bancheating = "auto banned for rule breaking",
	bancheatingadd = " ( Nickname: %s )",
}

RegisterServerEvent("kickCheater")
AddEventHandler('kickCheater', function(finalCheat)
	local _source = source

	DropPlayer(_source, "You have been auto kicked for cheating.")
end)

badWords = {
	"niggers",
	"nigger",
	"nigga",
	"niggas",
	"faggot",
	"nigglet",
}

badNames = {
	"nigger",
	"fag",
	"dick",
	"cock",
	"i like dick sucking",
	"fucking niggers",
	"fucking nigglets",
	"FUCKING N.I.G.G.E.R.S",
	"my name is jeff",
	"BigBlackMan",
	"N.I.GGG.E.RRRRRS",
	"fucking nig.g.ers",
	"i hate fucking NIGGLETS",
}

-- Below Needs fixing

--[[RegisterServerEvent("checkBadNames")
AddEventHandler("checkBadNames", function()
	local name = GetPlayerName(source)
	for i, gname in ipairs(badNames) do
		local lowername = string.lower(message)
		lowername = lowername:gsub('%W','')
		
		if string.match(lowername, gname) then
			CancelEvent()
			--DropPlayer(source, "Using vulgar nickname.")
			TriggerEvent("banCheater", source,"Using vulgar nickname.")
		end
	end
end)--]]

RegisterServerEvent("Playsignal")
AddEventHandler("Playsignal", function()
	TriggerClientEvent('chatMessage', -1, "MYSTERIOUS SIGNAL", {117, 247, 191}, "^0Hush, listen to your radios..... the mysterious signal is playing.")
end)

RegisterServerEvent("ShowFFA")
AddEventHandler("ShowFFA", function()
	CancelEvent();
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All starts in 5 minutes, get geared up. Do NOT PvP yet!");
	Citizen.Wait(240000)
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All Starts In 1 Minute. Find some guns and be prepared to fight to the death.");
	Citizen.Wait(30000)
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All Starts In 30 seconds.");
	Citizen.Wait(20000)
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All Starts In 10 seconds.");
	Citizen.Wait(10000)
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All has started. PvP is now only allowed until time is up. Free For All ends in 15 minutes.");
	Citizen.Wait(600000)
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All ends in 5 minutes.");
	Citizen.Wait(300000)
	TriggerClientEvent('chatMessage', -1, "^1Server", {255, 0, 0}, "^0Free For All has ended. PvP is now no longer allowed, resume normal gameplay.");
	--TriggerClientEvent('showFFA', source);
end)

AddEventHandler("chatMessage", function(source, name, message)
	--cm = stringsplit(message, " ")

	for i, word in ipairs(badWords) do
		local lowerword = string.lower(message)
		lowerword = lowerword:gsub('%W','')
		
		if string.match(lowerword, word) then
			CancelEvent()
			--DropPlayer(source, "Stop being vulgar.")
			TriggerEvent("banCheater", source,"Using vulgar language.")
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