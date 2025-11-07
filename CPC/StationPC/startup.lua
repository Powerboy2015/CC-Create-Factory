---@return table<number, filterBlock>

local FactoryHandler = require("utils.FactoryHandler")
local inventoryObject = require("utils.InventoryObject")
local localInv = inventoryObject:new("minecraft:barrel_0")

local machineList = FactoryHandler:new("create:basin")

localInv:updateItemList()

for machine, status in pairs(machineList.machineState) do
    print(machine.size(), status)
end
