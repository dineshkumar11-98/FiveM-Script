fx_version 'cerulean'
games {'gta5' }

client_scripts {
    "config.lua",
    "/client/main.lua",
} 

server_scripts {
    "/server/main.lua",
    "@mysql-async/lib/MySQL.lua"
}