local expect = require("cc.expect")

---@class FactoryObject
local FactoryObject = {}
FactoryObject.__index = FactoryObject

function FactoryObject:new()
    local obj = {}
    setmetatable(obj, FactoryObject)
    return obj
end

return FactoryObject
