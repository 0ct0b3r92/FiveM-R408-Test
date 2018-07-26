-- Camping created by Vespura (Contributor: SPJESTER & DieselDave)
local prevtent = 0
RegisterCommand('tent', function(source, args, rawCommand)
    --[[if prevtent ~= 0 then
        SetEntityAsMissionEntity(prevtent)
        DeleteObject(prevtent)
        prevtent = 0
    end--]]
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.95))
    local tents = {
        'prop_skid_tent_01',
        'prop_skid_tent_01b',
        'prop_skid_tent_03',
    }
    local randomint = math.random(1,3)
    local tent = GetHashKey(tents[randomint])
    local prop = CreateObject(tent, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    --PlaceObjectOnGroundProperly(prop)
    prevtent = prop
end, false)

local prevfire = 0
RegisterCommand('campfire', function(source, args, rawCommand)
    --[[if prevfire ~= 0 then
        SetEntityAsMissionEntity(prevfire)
        DeleteObject(prevfire)
        prevfire = 0
    end--]]
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
	local objectX, objectY, objectZ = table.unpack(GetEntityCoords(prop, true))
    local prop = CreateObject(GetHashKey("prop_beach_fire"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
	--DrawLightWithRange(objectX, objectY, objectZ+1, 255, 255, 255, 10, 0.75)
    --PlaceObjectOnGroundProperly(prop)
    prevfire = prop
end, false)

local prevchair = 0
RegisterCommand('chair', function(source, args, rawCommand)
    --[[if prevchair ~= 0 then
        SetEntityAsMissionEntity(prevchair)
        DeleteObject(prevchair)
        prevchair = 0
    end--]]
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.02))
    local chair = {
        'prop_chair_02',
        'prop_chair_05',
		'prop_chair_10'
    }
    local randomint = math.random(1,3)
    local chair = GetHashKey(chair[randomint])
    local prop = CreateObject(chair, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
	FreezeEntityPosition(prop, true)
    PlaceObjectOnGroundProperly(prop)
    prevchair = prop
end, false)

-- Places a barricade
local prevbarricade = 0
RegisterCommand('barricade', function(source, args, rawCommand)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.02))
    local barricade = {
        'prop_fncwood_03a',
        'prop_fncwood_07a',
        'prop_fncwood_16a',
    }
    local randomint = math.random(1,3)
    local barricade = GetHashKey(barricade[randomint])
    local prop = CreateObject(barricade, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
	FreezeEntityPosition(prop, true)
    PlaceObjectOnGroundProperly(prop)
    prevbarricade = prop
end, false)

-- Places a foundation
local prevfoundation = 0
RegisterCommand('foundation', function(source, args, rawCommand)
	if prevfoundation > 0 then
        TriggerEvent('chatMessage', '^1SYSTEM', {255,255,255}, 'You can only have one foundation, delete your old one first.')
		--[[SetEntityAsMissionEntity(prevfoundation)
        DeleteObject(prevfoundation)
        prevfoundation = 0--]]
	elseif prevfoundation == 0 then
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, -1.02))
		local foundation = {
			'stt_prop_stunt_bowlpin_stand',
		}
		local randomint = math.random(1,1)
		local foundation = GetHashKey(foundation[randomint])
		local prop = CreateObject(foundation, x, y, z-3, true, false, true)
		SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
		FreezeEntityPosition(prop, true)
		prevfoundation = prop
	end
end, false)

-- Deletes your foundation
RegisterCommand('delfoundation', function(source, args, rawCommand)
	if prevfoundation > 0 then
		SetEntityAsMissionEntity(prevfoundation)
        DeleteObject(prevfoundation)
        prevfoundation = 0
	end
end, false)

-- Places a bunker
local prevbunker = 0
RegisterCommand('bunker', function(source, args, rawCommand)
	if prevbunker ~= 0 then
        SetEntityAsMissionEntity(prevbunker)
        DeleteObject(prevbunker)
        prevbunker = 0
    end
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, -1.02))
    local bunker = {
        'prop_mb_hesco_06',
    }
    local randomint = math.random(1,1)
    local bunker = GetHashKey(bunker[randomint])
    local prop = CreateObject(bunker, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
	FreezeEntityPosition(prop, true)
    PlaceObjectOnGroundProperly(prop)
    prevbunker = prop
end, false)

RegisterCommand('delobject', function(source, args, rawCommand)
    local prop = 0
    local deelz = 10
    local deelxy = 2
    for offsety=-2,2 do
        for offsetx=-2,2 do
            for offsetz=-8,8 do
                local CoordFrom = GetEntityCoords(PlayerPedId(), true)
                local CoordTo = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
                local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z-(offsetz/deelz), CoordTo.x+(offsetx/deelxy), CoordTo.y+(offsety/deelxy), CoordTo.z-(offsetz/deelz), 16, PlayerPedId(), 0)
                local _, _, _, _, object = GetShapeTestResult(RayHandle)
                if object ~= 0 then
                    prop = object
                    break
                end
            end
        end
    end
    SetEntityAsMissionEntity(prop)
    DeleteObject(prop)
end, false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/tent', 'Spawn a tent in front of you. If you already have a tent then this will override your old tent.')
    TriggerEvent('chat:addSuggestion', '/campfire', 'Spawn a campfire in front of you. If you already have a campfire then this will override your old campfire.')
    TriggerEvent('chat:addSuggestion', '/chair', 'Spawn a chair in front of you. If you already have a chair then this will override your old chair.')
    TriggerEvent('chat:addSuggestion', '/delobject', 'Deletes any object/prop in front of you.')
end)