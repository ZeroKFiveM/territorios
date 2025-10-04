-- Configuración de gangs cargada dinámicamente desde la base de datos
Config = {}

-- Variable global para almacenar las gangs cargadas desde la base de datos
Config.Gangs = {}

-- Color por defecto para todas las gangs (rojo)
Config.DefaultBlipColor = 1 -- Color rojo según la documentación de FiveM

-- Función para agregar una gang al array
function Config.AddGang(gangId, blipColor)
    Config.Gangs[gangId] = {
        blipColour = blipColor or Config.DefaultBlipColor
    }
end

-- Función para obtener todas las gangs
function Config.GetGangs()
    return Config.Gangs
end

-- Función para verificar si una gang existe
function Config.GangExists(gangId)
    return Config.Gangs[gangId] ~= nil
end

-- Función para obtener el color de blip de una gang
function Config.GetGangBlipColor(gangId)
    if Config.Gangs[gangId] then
        return Config.Gangs[gangId].blipColour
    end
    return Config.DefaultBlipColor
end