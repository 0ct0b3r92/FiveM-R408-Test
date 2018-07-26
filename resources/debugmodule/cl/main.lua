RegisterNetEvent("module_debug:addItems")
AddEventHandler("module_debug:addItems", function()
	TriggerEvent("menu:registerModuleMenu", "Debugging", function(id)
		PlayerMenu.Add(id)
		VehicleMenu.Add(id)
		ClosestPedMenu.Add(id)
		ClosestPropMenu.Add(id)
		EntityTextsMenu.Add(id)
	end)
end)

Util = {}
function Util.RoundToNthDecimal(num, n)
	local mult = 10^(n or 0)
	return math.floor(num * mult + 0.5) / mult
end