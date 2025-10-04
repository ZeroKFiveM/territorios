-- Cliente - Manejo de gangs cargadas desde el servidor
local gangsLoaded = false
local gangsData = {}

-- Evento para recibir las gangs cargadas desde el servidor
RegisterNetEvent('gangs:loaded')
AddEventHandler('gangs:loaded', function(gangs)
    gangsData = gangs
    gangsLoaded = true
    
    print("^2[CLIENTE GANGS]^7 Gangs recibidas del servidor:")
    for gangId, gangData in pairs(gangs) do
        print("^3[CLIENTE GANGS]^7 Gang: " .. gangId .. " - Color: " .. gangData.blipColour)
    end
end)

-- Función para obtener las gangs (para uso en otros scripts)
function GetGangs()
    return gangsData
end

-- Función para verificar si una gang existe
function GangExists(gangId)
    return gangsData[gangId] ~= nil
end

-- Función para obtener el color de blip de una gang
function GetGangBlipColor(gangId)
    if gangsData[gangId] then
        return gangsData[gangId].blipColour
    end
    return 1 -- Color rojo por defecto
end

-- Función para verificar si las gangs están cargadas
function AreGangsLoaded()
    return gangsLoaded
end

-- Solicitar gangs al servidor cuando el cliente esté listo
Citizen.CreateThread(function()
    Citizen.Wait(2000) -- Esperar un poco para que el servidor esté listo
    TriggerServerEvent('gangs:requestGangs')
end)

-- Exportar funciones para uso en otros recursos
exports('GetGangs', GetGangs)
exports('GangExists', GangExists)
exports('GetGangBlipColor', GetGangBlipColor)
exports('AreGangsLoaded', AreGangsLoaded)