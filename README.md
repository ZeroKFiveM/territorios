# Sistema de Gangs con Carga desde Base de Datos

Este recurso carga dinámicamente las gangs desde la base de datos en lugar de usar valores hardcodeados.

## Características

- ✅ Carga automática de gangs desde la tabla `origen_ilegal` al iniciar el servidor
- ✅ Color rojo por defecto para todas las gangs (configurable)
- ✅ Sistema de eventos para sincronizar entre servidor y cliente
- ✅ Funciones exportadas para uso en otros recursos
- ✅ Comando de consola para recargar gangs

## Estructura de la Base de Datos

El sistema consulta la tabla `origen_ilegal` y obtiene el campo `id` para crear las gangs:

```sql
SELECT id FROM origen_ilegal WHERE id IS NOT NULL AND id != ''
```

## Configuración

### Color por Defecto
En `shared.lua` puedes cambiar el color por defecto:
```lua
Config.DefaultBlipColor = 1 -- Color rojo (1-85 según documentación FiveM)
```

### Colores de Blip Disponibles
- 1: Rojo
- 2: Verde
- 3: Azul
- 4: Amarillo
- 5: Naranja
- 6: Púrpura
- 7: Rosa
- 8: Blanco
- Y muchos más (consulta la documentación de FiveM)

## Uso en Otros Recursos

### Desde el Servidor
```lua
-- Obtener todas las gangs
local gangs = exports['tu-recurso']:GetGangs()

-- Verificar si una gang existe
local exists = exports['tu-recurso']:GangExists('gsf')

-- Obtener color de blip
local color = exports['tu-recurso']:GetGangBlipColor('gsf')

-- Verificar si las gangs están cargadas
local loaded = exports['tu-recurso']:AreGangsLoaded()
```

### Desde el Cliente
```lua
-- Obtener todas las gangs
local gangs = exports['tu-recurso']:GetGangs()

-- Verificar si una gang existe
local exists = exports['tu-recurso']:GangExists('gsf')

-- Obtener color de blip
local color = exports['tu-recurso']:GetGangBlipColor('gsf')

-- Verificar si las gangs están cargadas
local loaded = exports['tu-recurso']:AreGangsLoaded()
```

## Eventos

### Servidor → Cliente
- `gangs:loaded`: Se dispara cuando las gangs han sido cargadas

### Cliente → Servidor
- `gangs:requestGangs`: Solicita las gangs al servidor

## Comandos de Consola

- `reloadgangs`: Recarga las gangs desde la base de datos

## Dependencias

- `mysql-async`: Para consultas a la base de datos

## Instalación

1. Coloca el recurso en tu carpeta `resources`
2. Asegúrate de tener `mysql-async` instalado
3. Agrega `ensure tu-recurso` a tu `server.cfg`
4. Reinicia el servidor

## Logs

El sistema genera logs informativos:
- `[CARGANDO GANGS]`: Logs del servidor
- `[CLIENTE GANGS]`: Logs del cliente

## Estructura de Archivos

```
tu-recurso/
├── fxmanifest.lua
├── shared.lua
├── server.lua
├── client.lua
└── README.md
```