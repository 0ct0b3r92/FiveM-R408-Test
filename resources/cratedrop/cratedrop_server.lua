RegisterServerEvent("HighSupplyInbound")
AddEventHandler("HighSupplyInbound", function()
	--TriggerEvent("chatMessage", "^2MERRYWEATHER", {255, 255, 255}, "Supply drop inbound.")
	TriggerClientEvent('chatMessage', -1, "^1MERRYWEATHER", {255, 255, 255}, "High spec supply drop inbound.");
end)