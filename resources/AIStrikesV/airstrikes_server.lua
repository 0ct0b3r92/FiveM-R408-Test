RegisterServerEvent("AirstrikeMsg")
AddEventHandler("AirstrikeMsg", function()
	--TriggerEvent("chatMessage", "^2MERRYWEATHER", {255, 255, 255}, "Supply drop inbound.")
	TriggerClientEvent('chatMessage', -1, "^1MERRYWEATHER", {255, 255, 255}, "Airstrike inbound.");
end)