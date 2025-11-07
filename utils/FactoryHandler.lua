local expect = require("cc.expect").expect

---@class FactoryHandler
---@field machineState table<filterBlock,string>
local FactoryHandler = {}
FactoryHandler.__index = FactoryHandler

---@param machineID string name of factoryBlock
---@return FactoryHandler
function FactoryHandler:new(machineID)
    expect(1, machineID, "string")
    local obj = {}
    setmetatable(obj, FactoryHandler)
    -- find all machines of the given type

    ---@type table<number,filterBlock>
    local machines = { peripheral.find(machineID) }

    -- initialize machine states
    local machineState = {}
    for id, machine in pairs(machines) do
        machine.name = machineID .. "_" .. tostring(id)
        print(machine.size())
        machineState[machine] = "idle"
    end

    -- assign to object
    obj.machineState = machineState
    return obj
end

return FactoryHandler
