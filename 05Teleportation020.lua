-- OpenRoad Teleportation Script
-- Importing configurations and functions from previous scripts
local init = require("scripts.01Initialization020")
local debugLog = init.debugLog
local vehicleCheck = require("scripts.04VehicleCheck020")
local gridDetermination = require("scripts.03GridDetermination020")

debugLog("LOADING TELEPORT SCRIPT")

menu.register_callback("menubuildingdoneuggh", function()
    debugLog("RUNNING TELEPORT SCRIPT")
    -- Function to move a given vehicle to a teleport location
function teleportVehicle(vehicle)
    local maxAttempts = 5  -- Define a max number of attempts to prevent infinite loops.
    local attempts = 0

    while gridDetermination.isPositionInCell(vehicle:get_position(), gridDetermination.getCurrentCell()) and attempts < maxAttempts do
        if not vehicleCheck.isVehicleNearAnyPlayer(vehicle) then
            vehicle:set_position(vector3(init.teleportCoords.x, init.teleportCoords.y, init.teleportCoords.z))
            debugLog("Vehicle teleported to out-of-map location!")
        else
            debugLog("Vehicle is near a player. Not teleporting!")
            break  -- Exit the loop if the vehicle is near a player.
        end
        attempts = attempts + 1
    end

    if attempts == maxAttempts then
        debugLog("Vehicle could not be teleported out after maximum attempts!")
    end
end

debugLog("LOADING TELEPORT SCRIPT ALLMOST DONE")
-- Function to process and teleport vehicles based on player movement and cell transition
function processVehiclesForTeleportation(currentCell)
    local vehiclesInCell = vehicleCheck.getVehiclesInCell(currentCell)
    for _, vehicle in ipairs(vehiclesInCell) do
        teleportVehicle(vehicle)
    end
end

menu.emit_event("TeleportationComplete")
end)
-- Return the teleportation functions for other scripts
return {
    teleportVehicle = teleportVehicle,
    processVehiclesForTeleportation = processVehiclesForTeleportation
}
