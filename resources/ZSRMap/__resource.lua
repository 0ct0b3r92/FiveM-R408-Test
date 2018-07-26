resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/map.html"

files {
	"nui/map.html",
    "nui/background3.jpg",
   	"nui/ui.js", 
   	"nui/bootstrap.min.js",
   	"nui/gothicb.ttf",
   	"nui/signpainter.ttf",
   	"nui/bootstrap.min.css",
   	"nui/close.png",
   	"nui/close-hover.png",
   	"nui/map.css",
}

client_script 'click.lua'
server_script 'server.lua'