RegisterServerEvent("SupplyInbound")
AddEventHandler("SupplyInbound", function()
	--TriggerEvent("chatMessage", "^2MERRYWEATHER", {255, 255, 255}, "Supply drop inbound.")
	TriggerClientEvent('chatMessage', -1, "MYSTERIOUS SIGNAL", {117, 247, 191}, "^0Supply drop inbound.");
end)