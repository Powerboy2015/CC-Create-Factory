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
        state = "idle"
    }
    setmetatable(obj, Machine)
    return obj
end

---@param ItemID string the ID of the output item to set as filter
---@param output string item that is suppsed to come out
function Machine:setRecipe(ItemID, output)
    self.block.setFilterItem(output)
end

---@class Station
---@field machineStates table<number, Machine>
local Station = {}
Station.__index = Station

---@param stationID string minecraft ID of the station blocks in the cluster.
---@return Station | nil
function Station:new(stationID)
    local obj = {}

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

    obj.machineStates = machineStates
    setmetatable(obj, Station)
    print("Station initialized with " .. #machineStates .. " machines.")
    sleep(3)
    term.clear()
    term.setCursorPos(1, 1)
    return obj
end

-- returns classes
return Station
