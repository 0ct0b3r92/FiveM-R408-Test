ymapPedTab = {}

local hasTriggered = false
RegisterServerEvent('guards:PlyLoaded')
AddEventHandler('guards:PlyLoaded', function()
    if hasTriggered then else
        TriggerClientEvent('guards:CreateEnts',source)
        hasTriggered = true
    end
end)