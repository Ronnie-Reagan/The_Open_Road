-- OpenRoad Menu Building Script
menu.register_callback("TeleportationComplete", function()
-- Importing configurations and functions from previous scripts
local init = require("scripts.01Initialization020")
local playerMonitor = require("scripts.02PlayerMonitorScript020")
local gridDetermination = require("scripts.03GridDetermination020")
local vehicleCheck = require("scripts.04VehicleCheck020")
local teleportation = require("scripts.05Teleportation020")

-- Debug Mode
local debugMode = init.debugMode

-- Function to log debug messages
local debugLog = init.debugLog

-- Define the main menu and submenus
local mainMenu = menu.add_submenu("OpenRoad Main Menu")
local updateSubMenu = mainMenu:add_submenu("Update Options")
local debugSubMenu = mainMenu:add_submenu("Debug Options")

-- Update Action: To be triggered by players to update the vehicle checks and teleportation
updateSubMenu:add_action("Update Vehicle Positions", function()
    local currentPlayerPosition = playerMonitor.getCurrentPlayerPosition()
    local currentCell = gridDetermination.getCellForPosition(currentPlayerPosition)
    teleportation.processVehiclesForTeleportation(currentCell)
    debugLog("Update Complete!")
end)

-- Debug Actions: To enable or disable debug mode
debugSubMenu:add_action("Enable Debug Mode", function()
    debugMode = true
    debugLog("Debug mode enabled!")
end)
debugSubMenu:add_action("Disable Debug Mode", function()
    debugMode = false
    debugLog("Debug mode disabled!")
end)

-- Initialization Complete for Menu Building
debugLog("OpenRoad Menu Building Complete!")
end)
menu.emit_event("menubuildingdoneuggh")

--debugLog("MENU BUILDING DONE")