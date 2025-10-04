fx_version 'cerulean'
game 'gta5'

author 'Tu Nombre'
description 'Sistema de Gangs con carga desde base de datos'
version '1.0.0'

shared_scripts {
    'shared.lua'
}

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'mysql-async'
}