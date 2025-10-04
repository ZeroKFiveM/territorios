-- Servidor principal - Carga de gangs desde base de datos
local gangsLoaded = false

-- Función para cargar gangs desde la base de datos
function LoadGangsFromDatabase()
    print("^2[CARGANDO GANGS]^7 Iniciando carga de gangs desde la base de datos...")
    
    -- Query para obtener todas las gangs de la tabla origen_ilegal
    local query = "SELECT id FROM origen_ilegal WHERE id IS NOT NULL AND id != ''"
    
    MySQL.Async.fetchAll(query, {}, function(result)
        if result and #result > 0 then
            print("^2[CARGANDO GANGS]^7 Encontradas " .. #result .. " gangs en la base de datos")
            
            -- Limpiar el array de gangs existente
            Config.Gangs = {}
            
            -- Agregar cada gang encontrada
            for i = 1, #result do
                local gangId = result[i].id
                if gangId and gangId ~= "" then
                    Config.AddGang(gangId, Config.DefaultBlipColor)
                    print("^3[CARGANDO GANGS]^7 Gang cargada: " .. gangId .. " (Color: " .. Config.DefaultBlipColor .. ")")
                end
            end
            
            gangsLoaded = true
            print("^2[CARGANDO GANGS]^7 ¡Carga de gangs completada! Total: " .. #Config.Gangs)
            
            -- Trigger para notificar a los clientes que las gangs han sido cargadas
            TriggerClientEvent('gangs:loaded', -1, Config.Gangs)
            
        else
            print("^1[CARGANDO GANGS]^7 No se encontraron gangs en la base de datos")
            gangsLoaded = true
        end
    end)
end

-- Función para recargar gangs (útil para comandos de admin)
function ReloadGangs()
    LoadGangsFromDatabase()
end

-- Evento para cuando el servidor esté listo
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[CARGANDO GANGS]^7 Recurso iniciado, cargando gangs...")
        LoadGangsFromDatabase()
    end
end)

-- Comando para recargar gangs (solo para admins)
RegisterCommand('reloadgangs', function(source, args, rawCommand)
    if source == 0 then -- Solo desde consola del servidor
        print("^2[CARGANDO GANGS]^7 Recargando gangs por comando...")
        ReloadGangs()
    end
end, true)

-- Evento para obtener gangs cuando un cliente se conecta
RegisterNetEvent('gangs:requestGangs')
AddEventHandler('gangs:requestGangs', function()
    local source = source
    if gangsLoaded then
        TriggerClientEvent('gangs:loaded', source, Config.Gangs)
    end
end)

-- Función para verificar si las gangs están cargadas
function AreGangsLoaded()
    return gangsLoaded
end

-- Exportar funciones para uso en otros recursos
exports('GetGangs', function()
    return Config.Gangs
end)

exports('GangExists', function(gangId)
    return Config.GangExists(gangId)
end)

exports('GetGangBlipColor', function(gangId)
    return Config.GetGangBlipColor(gangId)
end)

exports('AreGangsLoaded', AreGangsLoaded)