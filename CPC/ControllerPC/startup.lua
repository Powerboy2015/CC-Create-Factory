-- Repsonsible for keeping track of data coming in and sending out to other components.
-- Tasks:
--  - Connect to other PC's
--  - gets incoming data from other factory PC's
--  - sends request instructions to other factory PC's based on what's lacking

-- config
local inventorymonName = "right"
local modemName = "back"
local listenPort = 4321

-- Initialize peripherals
local Modem = require("utils.Modem")
local monitorDisplay = require("utils.monitorDisplay")

local modem = Modem:new(modemName)
local InventoryMonitor = monitorDisplay:new(inventorymonName)

print("Inventory Monitor started, listening for inventory data...")
modem:listen(listenPort, function(message, senderChannel, replyChannel, senderDistance)
    InventoryMonitor:clear()
    InventoryMonitor:printLn("Inventory Contents:\n")
    for itemName, itemCount in pairs(message) do
        InventoryMonitor:printLn(itemName .. ": " .. itemCount .. "\n")
    end
end)
--- IGNORE ---
