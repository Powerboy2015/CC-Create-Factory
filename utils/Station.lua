---@class Machine
---@field block filterBlock
---@field name string
---@field state "active"|"idle"|"resetting"

local Machine = {}
Machine.__index = Machine

---@param machinePeripheral filterBlock
---@param name string
---@return Machine
function Machine:new(machinePeripheral, name)
    local obj = {
        name = name or "Machine",
        block = machinePeripheral,
        state = "idle",
    }
    setmetatable(obj, Machine)
    return obj
end

--- @param ItemID string the ID of the output item to set as filter
function Machine:setRecipe(ItemID)
    self.block.setFilterItem(ItemID)
end

---@class Station
---@field machines table<number, Machine>
---@
---@field recipeType string
local Station = {}
Station.__index = Station

---@param stationID string minecraft ID of the station blocks in the cluster.
---@param recipeType string the kind of recipes this system is able to acomplish
---@return Station | nil
function Station:new(stationID, recipeType)
    local obj = {
        recipeType = recipeType
    }

    -- Gets all the station blocks with the given ID
    ---@type table<number, filterBlock>| nil
    local StationBlocks = { peripheral.find(stationID) }
    if StationBlocks == nil then
        print("No station blocks found with ID: " .. stationID)
        return nil
    end

    -- Create machine objects for each station block
    local machineStates = {}

    for id, Block in pairs(StationBlocks) do
        local machineName = stationID .. "_" .. tostring(id)
        print("Found station block: " .. machineName)
        local machine = Machine:new(Block, machineName)
        table.insert(machineStates, machine)
    end

    obj.machines = machineStates
    setmetatable(obj, Station)
    print("Station initialized with " .. #machineStates .. " machines.")
    sleep(3)
    term.clear()
    term.setCursorPos(1, 1)
    return obj
end

---@param itemID string
---@param registry recipeRegistry
function Station:create(itemID, registry)
    local recipes = registry.search(itemID, self.recipeType)
    for _, recipe in pairs(recipes) do
        print("recipe found!" .. recipe.id)
    end

    print("finding empty machine")
    local usableRecipe = recipes[1]
    if (usableRecipe == nil) then
        print("not a usable recipe!")
        return;
    end
    for _, machine in pairs(self.machines) do
        if machine.state == "idle" then
            machine.state = "active"
            machine.block.setFilterItem(itemID)
            print(machine.name .. " has been activated!")
            break;
        end
    end
end

function Station:status()
    for _, machine in pairs(self.machines) do
        print(machine.name .. " | " .. machine.state)
    end
end

-- returns classes
return Station
