-- OpenRoad Grid Determination Script

-- Importing configurations and functions from Initialization script
local init = require("scripts.01Initialization020")
local debugLog = init.debugLog
-- Ensure grid is initialized only once
if not grid then
    grid = {}
end

menu.register_callback("PlayerMonitoringComplete", function()

    -- Function to determine the cell in which a position resides
function getCellForPosition(pos)
    local cell = {
        x = math.floor(pos.x / init.CELL_SIZE.x),
        y = math.floor(pos.y / init.CELL_SIZE.y),
        z = math.floor(pos.z / init.CELL_SIZE.z)
    }
    return cell
end

-- Function to check if a position is within a specific cell
function isPositionInCell(pos, cell)
    local targetCell = getCellForPosition(pos)
    return targetCell.x == cell.x and targetCell.y == cell.y and targetCell.z == cell.z
end

-- Function to get all players in a specific cell
function getPlayersInCell(cell)
    local playersInCell = {}
    local totalPlayers = player.get_number_of_players()
    for i = 1, totalPlayers do
        local playerPed = player.get_player_ped(i)
        if playerPed then
            local playerPos = localplayer:get_position()
        if isPositionInCell(playerPos, cell) then
            table.insert(playersInCell, i)
        end
    end
    return playersInCell
end




-- Return the grid determination functions for other scripts
return {
    getCellForPosition = getCellForPosition,
    isPositionInCell = isPositionInCell,
    getPlayersInCell = getPlayersInCell,
    grid
}
end
menu.emit_event("GridDeterminationComplete")
end)