-- Create the main player team array that holds all of the player data
playerTeams = {}

-- Set up thee factions that people can choose from 
local factions = 
{
	survivalist = { id = 1, name = "Survivalist",   cmd = "survivalist",    colour = { 255, 221, 0 } },
	lspd     = { id = 2, name = "Bandit",       cmd = "bandit",   colour = { 50, 50, 255 } },
	lscsd    = { id = 3, name = "The Reapers",      cmd = "reapers",  colour = { 50, 50, 255 } },
	bcsd     = { id = 4, name = "Liberators",       cmd = "liberators",   colour = { 50, 50, 255 } },
	sahp     = { id = 5, name = "Demon Corporation",       cmd = "demoncorp",   colour = { 50, 50, 255 } },
}

-- Set the default team, this can be changed
local defaultTeam = factions.survivalist

-- When the player is fully loaded we set their default team data
AddEventHandler( 'es:playerLoaded', function( source ) 
	TriggerClientEvent( 'wk:SetTeam', source, defaultTeam.id )
	playerTeams[ source ] = factions.survivalist
end )

-- The main EssentialMode faction command
TriggerEvent( 'es:addCommand', 'faction', function( source, args, user ) 
	local faction = args[2]

	-- Check to make sure the faction variable actually exists 
	if ( faction ) then 
		-- Un-capitalise the string  
		faction = string.lower( faction )

		-- Loop through the factions 
		for k, v in pairs( factions ) do 
			-- Set the faction of the player if they aren't already on the team they chose 
			if ( v.cmd == faction and GetPlayerTeamID( source ) ~= v.id ) then 
				TriggerClientEvent( 'wk:SetTeam', source, v.id )
				playerTeams[ source ] = v
				TriggerClientEvent( 'chatMessage', -1, '', {255, 0, 0}, GetPlayerName( source ) .. " has switched to " .. v.name .. " faction." )
			elseif ( v.cmd == faction and GetPlayerTeamID( source ) == v.id ) then 
				TriggerClientEvent( 'chatMessage', source, 'SYSTEM', {255, 0, 0}, "You are already on that faction." )
			end 
		end 
	else 
		-- Add all of the current teams to a string variable and add a full-stop to the end.
		local cmds = "Factions: "
		for k, v in pairs( factions ) do cmds = cmds .. v.cmd .. ", " end 
		cmds = string.sub( cmds, 1, -3 ) .. "."
		TriggerClientEvent( 'chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage: /faction <faction name>" )
		TriggerClientEvent( 'chatMessage', source, 'SYSTEM', {255, 0, 0}, cmds )
	end 
end )

-- Override the chatMessage event to add the team name and colour 
AddEventHandler( 'chatMessage', function( source, n, message )
	local isCommand = startswith( message, "/" )

	CancelEvent()

	if ( not isCommand ) then 
	    TriggerClientEvent( 'chatMessage', -1,  playerTeams[ source ].name .. " | " .. n, playerTeams[ source ].colour, message )
    end  
end )

function startswith( String, Start )
	return string.sub( String, 1, string.len( Start ) ) == Start
end

function GetPlayerTeamID( source )
	if ( playerTeams[ source ] ) then return playerTeams[ source ].id end 
end 