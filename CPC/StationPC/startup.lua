local Station = require("utils.Station")
local registry = peripheral.wrap("recipe_registry_1") --[[@as recipeRegistry]]
-- local inventoryObject = require("utils.InventoryObject")
-- localInv:updateItemList()
-- local localInv = inventoryObject:new("minecraft:barrel_0")

function ParseName(_itemName)
    local removedPrefix = string.gsub(_itemName, "^[A-Za-z]+:", "")
    return string.gsub(removedPrefix, "_", " ")
end

local mixingStation = Station:new("create:basin", "create:mixing")
if mixingStation == nil then
    error("No station blocks found. Startup aborted.")
end

local itemID = "create:andesite_alloy"
mixingStation:create(itemID, registry)
