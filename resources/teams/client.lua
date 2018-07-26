local teamID

RegisterNetEvent( 'wk:SetTeam' )
AddEventHandler( 'wk:SetTeam', function( teamid )
	teamID = teamid 
	log( "Player teamid set to " .. teamid )
end )

function log( msg )
	Citizen.Trace( "[DEBUG]: " .. msg )
end 