-- OpenRoad Player Monitor Script

-- Importing configurations and functions from Initialization script
local init = require("scripts.01Initialization020")
local debugLog = init.debugLog
menu.register_callback("menubuildingdoneuggh", function()
menu.register_callback("InitializationComplete", function()
    -- Code for player monitoring
    debugLog("Comparing vectors: " .. tostring(vec1) .. " and " .. tostring(vec2))

local function equals(vec1, vec2)
    if not vec1 or not vec2 then return false end
    return vec1.x == vec2.x and vec1.y == vec2.y and vec1.z == vec2.z
end

-- Function to check if a player has moved since the last check
local function hasPlayerMoved(playerIndex)
    local currentPlayerPosition = localplayer:get_position()
    local moved = not equals(init.previousPlayerPositions[playerIndex], currentPlayerPosition)
    init.previousPlayerPositions[playerIndex] = currentPlayerPosition  -- Update the previous position
    return moved
end

-- Function to determine if the ped is a player
function IsPlayer(ped)
    if ped == nil or ped:get_pedtype() >= 4 then
        return false
    end
    for i = 1, player.get_number_of_players() do
        if ped == player.get_player_ped(i) then
            return true
        end
    end
    return false
end

-- Monitor all players and check if any of them have moved
local function monitorPlayers()
    for ped in replayinterface.get_peds() do
        if IsPlayer(ped) then            
            local playerIndex = ped:get_player_id()
            debugLog("player index " .. playerIndex)
            if hasPlayerMoved(playerIndex) then
                debugLog("Player " .. playerIndex .. " has moved!")
                -- Trigger other actions or callbacks here, as needed.
            end
        end
    end
end

-- Periodically monitor players
while true do
    sleep(1.0)
    sleep(1.0)
    sleep(1.0)
    monitorPlayers()
end
end)

end)

-- Return the monitor function for other scripts
return {
    monitorPlayers = monitorPlayers
}

