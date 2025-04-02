fx_version 'cerulean'
game 'gta5'

author 'Chosse98CZ'
description 'Ilegální tuning - klíče k tajným schránkám'
version '1.1'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}
