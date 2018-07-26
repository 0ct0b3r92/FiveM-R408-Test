-- Citizen.CreateThread(function()
-- local blips = {
	-- {id=47, x= 1614.95, y= 3598.97, z= 34.90}
-- }

	-- for _, map in pairs(blips) do
	-- map.blip = AddBlipForCoord(map.x, map.y, map.z)
	-- SetBlipSprite(map.blip, map.id)
	-- SetBlipAsShortRange(map.blip, true)
	-- end
-- end)

local jesusChats = {
	"Welcome to the church of Christ my friend. We are all about peace and restoration.",
	"You are welcome to stay here just don't cause any trouble.",
	"I don't have any tasks for you right now sorry friend.",
}

local guardChats = {
	"Can you help clear some zombies around the base?",
	"Help us kill these fucking zombies before they pack up in numbers.",
	"Don't need help right now, come back shortly.",
}

local injuredChats = {
	"I was shot by a looter, can you kill some looters for me? They have Lost MC jackets on them.",
	"I got shot by someone with a sniper rifle can you find him and kill him? in return you can keep the rifle.",
	"A guy shot me with a machine gun, can you find and kill him for me? The gun is yours for a reward.",
}

local tomChats = {
	"I don't have anything for you right now, come back another time and I might have something.",
	"Not today, sorry.",
	"Nothing to give you right now, maybe another time.",
	"I don't have any tasks, ask someone else around here maybe?",
}

local jimmyChats = {
	--"Not today, sorry man.",
	"Can you deliver these radios to Mark over at the Grapeseed Safezone?",
	--"Come back soon, and I might have something.",
}

local humaneLabInfo = {
	"The government has allowed us to use the inmates for testing our DNA modification experiment between the chimps DNA and regular human DNA.",
	"We have partnered with the IAA, FIB and Merryweather to begin testing our new experiment.",
	"All the prison buses must line up single file, each individual is to be checked for any signs of weakness. Including old age. The weak ones must be locked up on the outside quarantine fence. The rest are to be locked in the cages before proceeding.",
	"All patients are required to wear the special suits to prevent spreading of disease.",
	"The military has provided us with weapons, chemicals, and suits out back.",
	"Patients are dying as a result of the DNA modification, however we designed a syringe chemical labeled 'RES-457'.",
	"'RES-457' is suppose to do is bring back dead brain cells and re-activate the brain before permanent death.",
	"After injecting 'RES-457' into the last prisoner, the dead prisoner remained motionless for about 30 seconds before scientists notice something strange happening in the brain stem of the patient.",
	"Ever since resurrection 401 spread around the state, we have decided to move offshore to make a mass weapon that will wipe out the whole state to prevent it from spreading to other places.",
}

local looterMissions = {
	{name="Injured", id=47, x= 1692.66, y= 3587.85, z= 35.62},
}

local guardMissions = {
	{name="Guards", id=47, x= 2490.16, y= 4954.79, z= 48.23},
	{name="Guards", id=47, x= 2329.54, y= 3129.99, z= 51.44},
}

local jesusMissions = {
	{name="Jesus", id=47, x= 1858.75, y= 3852.40, z= 33.04},
}

local tomMissions = {
	{name="Tommy", id=47, x= 1866.00, y= 3844.44, z= 32.53},
}

local jimmyMissions = {
	{name="Jimmy", id=47, x= 2341.10, y= 3128.54, z= 48.20},
}

local markMissions = {
	{name="Mark", id=47, x= 2454.12, y= 4946.46, z= 45.12},
}

local jasonMissions = {
	{name="Jason", id=47, x= 2665.29, y= 3519.75, z= 52.73},
}

local humaneLabMissions = {
	{name="Merryweather", id=47, x= 3560.00, y= 3675.00, z= 28.00},
	{name="Merryweather", id=47, x= 3541.00, y= 3644.00, z= 28.00},
	{name="Merryweather", id=47, x= 3537.00, y= 3668.00, z= 28.00},
}

local looterBases = {
	{id=66, x= 686.00, y= 136.00, z= 85.00},
}

-- Mission Variables
local hasRadios = false
local hasMedkit = false
local killZinn = false


-- Global Variables
hasFingers = false
jasonMission = false
fingerCount = 0

-- Mission Completed Variables
local tomComplete = false
local jesusComplete = false
local jimmyComplete = false
local jasonComplete = false


-- Kill Looter missions
incircle = false
Citizen.CreateThread(function()
	for _, item in pairs(looterMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(looterMissions) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						if hasMedkit == true then
							TaskTurnPedToFaceEntity(injuredPed, PlayerPedId(), 10000)
							TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0Are you okay?")
							Citizen.Wait(3000)
							TriggerEvent('chatMessage', "^4an injured survivor(NPC)", {255, 0, 0}, "^0I was shot in the leg, I can't really move around for a while.")
							Citizen.Wait(3000)
							TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0Here is a first aid kit from Jesus.")
							Citizen.Wait(3000)
							TriggerEvent('chatMessage', "^4an injured survivor(NPC)", {255, 0, 0}, "^0Tell him I said thank you, here is your reward buddy.")
							Citizen.Wait(3000)
							experience = DecorGetFloat(PlayerPedId(), "experience")
							DecorSetFloat(PlayerPedId(), "experience", experience + 75)
							GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_APPISTOL", 30, true, true)
							DisplayHelpText("You were given an AP Pistol and 75 XP as a reward.")
							hasMedkit = false
							jesusComplete = true
						elseif hasMedkit == false then
							TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0What happened to you?")
							Citizen.Wait(3000)
							TriggerEvent('chatMessage', "^4an injured survivor(NPC)", {255, 0, 0}, "^0" .. injuredChats[math.random(1, #injuredChats)])
						end
					end
				end
			end
		end
	end
end)

-- Base Guard Missions
Citizen.CreateThread(function()
	for _, item in pairs(guardMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(guardMissions) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TaskTurnPedToFaceEntity(guardPed, PlayerPedId(), 10000)
						TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0What can I help you with?")
						Citizen.Wait(3000)
						TriggerEvent('chatMessage', "^4Base Guard(NPC)", {255, 0, 0}, "^0" .. guardChats[math.random(1, #guardChats)])
					end
				end
			end
		end
	end
end)

-- Jesus Mission
Citizen.CreateThread(function()
	for _, item in pairs(jesusMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(jesusMissions) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TaskTurnPedToFaceEntity(Jesus, PlayerPedId(), 10000)
						TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0Hello there.")
						Citizen.Wait(3000)
						TriggerEvent('chatMessage', "^4Jesus(NPC)", {255, 0, 0}, "^0There is someone injured in the fire station, can you give them this first aid kit?")
						DisplayHelpText("You were given a first aid kid, go to the Sandy Shores Fire Station and give the injured guy the kit.")
						hasMedkit = true
					elseif jesusComplete == true then
						TriggerEvent('chatMessage', "^4Jesus(NPC)", {255, 0, 0}, "^0I got no more tasks for you right now, sorry friend.")
					end
				end
			end
		end
	end
end)

-- Tom Jaredson Missions
Citizen.CreateThread(function()
	for _, item in pairs(tomMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(tomMissions) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TaskTurnPedToFaceEntity(Tom, PlayerPedId(), 10000)
						TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0Need anything?")
						Citizen.Wait(3000)
						TriggerEvent('chatMessage', "^4Tom Jaredson(NPC)", {255, 0, 0}, "^0My cousin is who is behind the looter situation, his name is Zinn. Can you do me a favor, and take him out? I cannot do it myself.")
						Citizen.Wait(3000)
						TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0Do you know where he is?")
						Citizen.Wait(3000)
						TriggerEvent('chatMessage', "^4Tom Jaredson(NPC)", {255, 0, 0}, "^0He is at the water plant in Los Santos near the Vinewood Bowl, it should be marked on your map.")
						killZinn = true
					elseif tomComplete == true then
						TriggerEvent('chatMessage', "^4Tom Jaredson(NPC)", {255, 0, 0}, "^0I don't have any more quests for you, sorry pal.")
					end
				end
			end
		end
	end
end)

-- Jimmy Mission
Citizen.CreateThread(function()
	for _, item in pairs(jimmyMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(jimmyMissions) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TaskTurnPedToFaceEntity(Jimmy, PlayerPedId(), 10000)
						TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0Got anything I can do?")
						Citizen.Wait(3000)
						TriggerEvent('chatMessage', "^4Jimmy(NPC)", {255, 0, 0}, "^0" .. jimmyChats[math.random(1, #jimmyChats)])
						DisplayHelpText("You were given a couple radios, take them over to Mark at Grapeseed Safezone.")
						playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
						markX, markY, markZ = table.unpack(GetEntityCoords(Mark, true))
						hasRadios = true
					elseif jimmyComplete == true then
						TriggerEvent('chatMessage', "^4Jimmy(NPC)", {255, 0, 0}, "^0I don't have any more tasks for you right now, sorry.")
					end
				end
			end
		end
	end
end)

-- Humane Lab Merryweather Mission
Citizen.CreateThread(function()
	for _, item in pairs(humaneLabMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(humaneLabMissions) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TriggerEvent('chatMessage', "^4Merryweather Security(Document)", {255, 0, 0}, "^0" .. humaneLabInfo[math.random(1, #humaneLabInfo)])
						DisplayHelpText("You found a highly classified Merryweather document with information.")
					end
				end
			end
		end
	end
end)

-- Mark Mission
Citizen.CreateThread(function()
	for _, item in pairs(markMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in ipairs(markMissions) do
			if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
				markMission = DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
					if (incircle == false) then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
					end
					incircle = true
					if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						if hasRadios == true then
							TaskTurnPedToFaceEntity(Mark, PlayerPedId(), 10000)
							TriggerEvent('chatMessage', "^2You", {255, 0, 0}, "^0I got radios to give you.")
							Citizen.Wait(3000)
							TriggerEvent('chatMessage', "^4Mark(NPC)", {255, 0, 0}, "^0Thank you, here is your reward.")
							Citizen.Wait(3000)
							DisplayHelpText("You delivered the radios, here is your reward.")
							Citizen.Wait(1000)
							experience = DecorGetFloat(PlayerPedId(), "experience")
							DecorSetFloat(PlayerPedId(), "experience", experience + 75)
							GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_CARBINERIFLE", 30, true, true)
							DisplayHelpText("You were given a carbine rifle with 30 rounds and 75 XP as a reward")
							hasRadios = false
							jimmyComplete = true
						elseif hasRadios == false then
							TriggerEvent('chatMessage', "^4Mark(NPC)", {255, 0, 0}, "^0I don't have anything for you right now, sorry.")
						end
					end
				end
			end
		end
	end
end)

-- Kill Zinn Mission
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if killZinn == true then
			DrawMarker(1, 715.92, 111.82, 79.95 - 1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 500.0, 255, 0, 0,100, 0, 0, 0,0)
			if IsPedDeadOrDying(Zinn, 1) == 1 then
				experience = DecorGetFloat(PlayerPedId(), "experience")
				DecorSetFloat(PlayerPedId(), "experience", experience + 150)
				GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_ASSAULTRIFLE", 30, true, true)
				DisplayHelpText("You eliminated the target and was given an assault rifle and 150 XP as a reward")
				killZinn = false
				tomComplete = true
				Citizen.Wait(5000)
				DeleteEntity(Zinn)
			end
		end
	end
end)

-- Jason Mission
Citizen.CreateThread(function()
	for _, item in pairs(jasonMissions) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in ipairs(jasonMissions) do
			if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
					DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5001, 0, 255, 0,165, 0, 0, 0,0)
					if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to interact with NPC.")
						if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
							if hasFingers == true then
								TriggerEvent('chatMessage', "^2You", {255, 255, 255}, "Here is your fingers.")
								Citizen.Wait(3000)
								TriggerEvent('chatMessage', "^4Jason", {255, 255, 255}, "Thank you, here is your reward.")
								Citizen.Wait(3000)
								experience = DecorGetFloat(PlayerPedId(), "experience")
								DecorSetFloat(PlayerPedId(), "experience", experience + 100)
								GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_ASSAULTRIFLE", 30, true, true)
								DisplayHelpText("You were given an assault rifle with 30 rounds and 100 XP as a reward")
								hasFingers = false
								jasonComplete = true
							else
								if jasonMission == true then
									TriggerEvent('chatMessage', "^4Jason(NPC)", {255, 255, 255}, "Go get me some fingers.")
								end
								if jasonComplete == true then
									TriggerEvent('chatMessage', "^4Jason(NPC)", {255, 255, 255}, "I have no business with you.")
								end
								if jasonMission == false then
									TaskTurnPedToFaceEntity(Jason, PlayerPedId(), 10000)
									TriggerEvent('chatMessage', "^2You", {255, 255, 255}, "Do you got any tasks available?")
									Citizen.Wait(3000)
									TriggerEvent('chatMessage', "^4Jason(NPC)", {255, 255, 255}, "Would you be willing to collect a few dead fingers?")
									Citizen.Wait(3000)
									TriggerEvent('chatMessage', "^2You", {255, 255, 255}, "Sure thing.")
									Citizen.Wait(3000)
									DisplayHelpText("Jason gave you a task to collect a couple zombie fingers, go kill a few zombies.")
									jasonMission = true
									Citizen.Trace("Mission added.")
								end
							end
						end
					end
			end
		end
	end
end)



function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end