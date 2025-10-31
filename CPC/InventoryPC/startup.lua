-- gets a reading of the current inventory and makes this available to the main pc

local inventoryObject = require("utils.InventoryObject")
local Modem = require("utils.Modem")

---config list
local inventoryName = "storagedrawers:controller_4"
local broadcastPort = 4321


-- Initialize peripherals
local mainInventory = inventoryObject:new(inventoryName)
local modem = Modem:new("back")



local excludelist = {
    "iron block",
    "gold block",
    "copper block",
    "iron nugget",
    "gold nugget",
    "copper nugget",
    "zinc block",
    "zinc nugget"
}

-- updates the inventory
while true do
    mainInventory:updateItemList()
    local items = mainInventory.inventoryList
    modem:send(broadcastPort, items)
    os.sleep(3)
end
