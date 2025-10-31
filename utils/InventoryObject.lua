-- InventoryObject.lua
-- wrapper for inventory management & display
-- made especially for storage drawers.
-- features:
--  - reading inventory contents
--  - find item quantity
--  - display function.

local expect = require("cc.expect").expect

---@class InventoryObject
---@field inventoryPeripheral table
local InventoryObject = {
    inventoryList = {}
}

InventoryObject.__index = InventoryObject
-- initializes inventory object

---@param inventoryPeripheral string
---@return InventoryObject
function InventoryObject:new(inventoryPeripheral)
    expect(1, inventoryPeripheral, "string")
    local inventory = peripheral.wrap(inventoryPeripheral) or error("Inventory peripheral not found", 0)
    local obj = {}
    setmetatable(obj, InventoryObject)
    obj.inventoryPeripheral = inventory
    return obj
end

-- updates the internal item list from the inventory peripheral
---@return nil
function InventoryObject:updateItemList()
    local rawList = self.inventoryPeripheral.list()
    local parseItems = {}
    for _, item in pairs(rawList) do
        local parsedName = ParseName(item.name)
        parseItems[parsedName] = (parseItems[parsedName] or 0) + item.count
    end
    self.inventoryList = parseItems
end

-- removes mod names and returns a more user friendly name
function ParseName(_itemName)
    local removedPrefix = string.gsub(_itemName, "^[A-Za-z]+:", "")
    return string.gsub(removedPrefix, "_", " ")
end

return InventoryObject
