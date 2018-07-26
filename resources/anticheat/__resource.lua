-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page "index.html"

files {
	"index.html",
	"cheater.ogg",
	"signal.ogg",
}

client_script 'anticheat_client.lua'

server_script 'anticheat_server.lua'
server_script 'whitelist.lua'