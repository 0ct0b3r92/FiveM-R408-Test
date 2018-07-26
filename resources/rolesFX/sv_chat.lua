--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.
--- DO NOT REMOVE ME FROM THE CONFIG, ITS THERE TO GIVE ME CREDIT WHEN I JOIN SERVERS.

local CoOwner = {
	"steam:11000010d68be8f", -- Fade_
	"steam:110000106efd411", -- GeekRiot
	"steam:11000010d23733a", -- MeNoHasHax aka Blitz Color
}

local Owner = {
	"steam:110000105ce25a9"  -- Cody196
}

local HeadAdmin = {
	"steam:110000117eb9a54", -- Binary Radeon
	"steam:110000105c592e2", -- [[User hasn't been on since last wipe]]
	"steam:11000010d91fad2", -- [[User hasn't been on since last wipe]]
	"steam:11000010219be7e", -- [[User hasn't been on since last wipe]]
	"steam:11000011412cfa2", -- Cristo aka DoctorGTA
	"steam:110000105bac5ad", -- [[User hasn't been on since last wipe]]
}
local Admin = {
	"steam:1100001035da84d", -- [[User hasn't been on since last wipe]]
	"steam:110000114d18680", -- [[User hasn't been on since last wipe]]
	"steam:1100001054985e9", -- [[User hasn't been on since last wipe]]
	"steam:11000010a10dbe5", -- MetalCoreSucks
	"steam:11000011c73b0b2", -- Pablo
	"steam:11000010a1d235e", -- Hawk

}
local Donator = {
	"steam:1100001007d6e15"
}
local Developer = {
	""
}
local Secretary = {
	""
}
local Support = {
	""
}
local Moderator = {
	"steam:110000110cd8dca", -- [[User hasn't been on since last wipe]]
	"steam:110000107045158", -- [[User hasn't been on since last wipe]]
	"steam:11000010a6798bd", -- [[User hasn't been on since last wipe]]
	"steam:11000010ae3a274", -- [[User hasn't been on since last wipe]]
	"steam:110000104e0be74", -- [[User hasn't been on since last wipe]]
	"steam:11000010e74b19a", -- Unknown
	"steam:110000106603f04", -- jdhumpf
	"steam:110000105de21b7", -- Jake
	"steam:110000112bfaa9e", -- Nick
	"steam:1100001043dc7b9", -- red
	"steam:11000010533f850", -- Negan Grimes
	"steam:1100001046ea6f7", -- Beaker
}

local Member = {
	"steam:"
}
local ScriptCreator = {"steam:110000108ce69e8","ip:",}


AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    else     
        local player = GetPlayerIdentifiers(Source)[1]
        if has_value(HeadAdmin, player) then
            TriggerClientEvent('chatMessage', -1, "Head Admin | " .. Name, { 150, 0, 0 }, Msg) 
		elseif has_value(CoOwner, player) then
            TriggerClientEvent('chatMessage', -1, "Co Owner | " .. Name, { 197, 35, 209 }, Msg)
		elseif has_value(Owner, player) then
            TriggerClientEvent('chatMessage', -1, "Owner | " .. Name, { 86, 0, 112 }, Msg)
        elseif has_value(Admin, player) then
            TriggerClientEvent('chatMessage', -1, "Admin | " .. Name, { 255, 0, 0 }, Msg)
        elseif has_value(Developer, player) then
            TriggerClientEvent('chatMessage', -1, "Developer | " .. Name, { 0, 0, 255 }, Msg)
        elseif has_value(Secretary, player) then
            TriggerClientEvent('chatMessage', -1, "Secretary | " .. Name, { 0, 0, 255 }, Msg)
        elseif has_value(Support, player) then
            TriggerClientEvent('chatMessage', -1, "Tech Support | " .. Name, { 0, 0, 255 }, Msg)
	    elseif has_value(Moderator, player) then
            TriggerClientEvent('chatMessage', -1, "Moderator | " .. Name, { 235, 214, 51 }, Msg)
        elseif has_value(Member, player) then
            TriggerClientEvent('chatMessage', -1, "Member | " .. Name, { 222, 0, 255 }, Msg)
		elseif has_value(ScriptCreator, player) then
            TriggerClientEvent('chatMessage', -1, "Chat Roles Creator | " .. Name, { 0, 255, 43 }, Msg)
		elseif has_value(Donator, player) then
            TriggerClientEvent('chatMessage', -1, "Donator | " .. Name, { 0, 43, 255 }, Msg)
        else
            TriggerClientEvent('chatMessage', -1, "User | " .. Name, { 255, 255, 255 }, Msg)
        end
            
    end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

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