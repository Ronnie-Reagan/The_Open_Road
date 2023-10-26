-- OpenRoad Vehicle Check Script
-- Importing configurations and functions from previous scripts
local init = require("scripts.01Initialization020")
local debugLog = init.debugLog
local grid = require("scripts.03GridDetermination020")

menu.register_callback("GridDeterminationComplete", function()
    function isVehicleNearAnyPlayer(vehicle)
        local vehiclePos = vehicle:get_position()
        local totalPlayers = player.get_number_of_players()
    
        for i = 1, totalPlayers do
            local playerPed = player.get_player_ped(i)
            local playerPos = localplayer:get_position()
            
            if vector3.distance(vehiclePos, playerPos) < init.safetyRadius then
                return true
            end
        end
    
        return false
    end
    
    -- Function to retrieve all vehicles within a given cell
    function getVehiclesInCell(cell)
        local vehiclesInCell = {}
        for vehicle in replayinterface.get_vehicles() do
            local vehiclePos = vehicle:get_position()
            debugLog("Vehicle at position (x=" .. vehiclePos .. ", cell=" .. cell .. ")")
            if grid.isPositionInCell(vehiclePos, cell) then
                table.insert(vehiclesInCell, vehicle)
            end
        end
        return vehiclesInCell
    end
        debugLog("All scripts loaded!")
    menu.emit_event("VehicleCheckComplete")
end)


-- Return the vehicle check functions for other scripts
return {
    isVehicleNearAnyPlayer = isVehicleNearAnyPlayer,
    getVehiclesInCell = getVehiclesInCell
}
