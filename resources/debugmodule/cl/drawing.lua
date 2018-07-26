local drawings = {}

Drawing = {}
function Drawing.AddDrawText(text)
	table.insert(drawings, text)
end

function Drawing.DrawText(text, size, x, y, r, g, b)
	SetTextColour(r, g, b, 255)
	SetTextFont(0)
	SetTextScale(size, size)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

Citizen.CreateThread(function()
	while true do
		Wait(1)
		
		local startPos = 0.01 + 0.06 * (#drawings - 1)
		for i = #drawings, 1, -1 do
			Drawing.DrawText(drawings[i], 0.6, 0.005, startPos, 255, 255, 255)
			table.remove(drawings, i)
			startPos = startPos - 0.06
		end
	end
end)