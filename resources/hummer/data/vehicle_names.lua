	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	-- humvee
	AddTextEntry('0x34A923C5', 'h111')
end)