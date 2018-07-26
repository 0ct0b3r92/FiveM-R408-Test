RegisterServerEvent("menu:setup")

AddEventHandler("menu:setup", function()
	if not config.whitelist then
		TriggerClientEvent("module_debug:addItems", source)
	else
		for _, playerid in ipairs(GetPlayerIdentifiers(source)) do
			for _, allowedid in ipairs(config.whitelisted) do
				if playerid == allowedid then
					TriggerClientEvent("module_debug:addItems", source)
				end
			end
		end
	end
end)