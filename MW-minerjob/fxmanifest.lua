fx_version 'adamant'

game 'gta5'

description 'MW-minerjob Converted To Qb-core By MW'

server_scripts {
	'server/main.lua',
	'config.lua',
	"@mysql-async/lib/MySQL.lua"
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

ui_page "html/index.html"
files({
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/pickaxe.png',
    'html/bread.png',
    'html/water.png',
    'html/logo.png'
})