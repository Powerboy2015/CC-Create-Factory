local Station = require("utils.Station")
local registry = peripheral.wrap("recipe_registry_1") --[[@as recipeRegistry]]
-- local inventoryObject = require("utils.InventoryObject")
-- localInv:updateItemList()
-- local localInv = inventoryObject:new("minecraft:barrel_0")

function ParseName(_itemName)
    local removedPrefix = string.gsub(_itemName, "^[A-Za-z]+:", "")
    return string.gsub(removedPrefix, "_", " ")
end

local mixingStation = Station:new("create:basin")
if mixingStation == nil then
    error("No station blocks found. Startup aborted.")
end

---@param itemID string
local function mixItem(itemID)
    for _, machine in pairs(mixingStation.machineStates) do
        if machine.state == "idle" then
            local recipe = registry.getRecipesFor(itemID, "create:mixing")[1]
            if recipe ~= nil then
                print("Mixing item at machine: " .. machine.name)
                machine.setRecipe(recipe)
                machine.state = "active"
            end
        end
    end
end

mixItem("create:andesite_alloy")
