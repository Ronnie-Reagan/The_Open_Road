-- OpenRoad Initialization Script

-- Configuration Defaults
local playerTeleportRadius = 150.0  -- Radius around the player where vehicles get teleported
local safetyRadius = 30.0          -- Safety radius around each player to protect their vehicles
local teleportCoords = vector3(6969.0, 555.0, 420.0)  -- Out of map coordinates

-- Debug Mode (Should be off by default for performance reasons)
local debugMode = false

-- Function to log debug messages
local function debugLog(message)
    if debugMode then
        print("[OpenRoad Debug]: " .. message)
    end
end

-- Define the size of the world and the grid cells
local WORLD_SIZE = {x = 8000, y = 8000, z = 2500}
local CELL_SIZE = {x = 500, y = 500, z = 500}

local GRID_DIMENSIONS = {
    x = math.ceil(WORLD_SIZE.x / CELL_SIZE.x),
    y = math.ceil(WORLD_SIZE.y / CELL_SIZE.y),
    z = math.ceil(WORLD_SIZE.z / CELL_SIZE.z)
}

-- Store previous positions of all players
local totalPlayers = player.get_number_of_players()
local previousPlayerPositions = {}
for i = 1, totalPlayers do
    local playerPed = player.get_player_ped()
    previousPlayerPositions[i] = localplayer:get_position()
end
-- Register the callback
menu.emit_event("InitializationComplete")
-- Initialization Complete
debugLog("OpenRoad Initialization Complete!")

-- Return configurations and functions for other scripts
return {
    debugLog = debugLog,
    playerTeleportRadius = playerTeleportRadius,
    safetyRadius = safetyRadius,
    teleportCoords = teleportCoords,
    WORLD_SIZE = WORLD_SIZE,
    CELL_SIZE = CELL_SIZE,
    GRID_DIMENSIONS = GRID_DIMENSIONS,
    previousPlayerPositions = previousPlayerPositions
}
