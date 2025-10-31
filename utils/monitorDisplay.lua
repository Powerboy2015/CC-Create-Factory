-- What am I trying to do?
-- create a object that streamlines the process of displaying information on monitors

local expect = require("cc.expect").expect

-- MonitorDisplay class that adds specific handling for displaying monitor data.
---@class MonitorDisplay
---@field monitor table
---@field defaultMessage string
local MonitorDisplay = {}
MonitorDisplay.__index = MonitorDisplay

-- Finds monitor peripheral and initializes it
---@return MonitorDisplay
---@param monitorPeripheral string
function MonitorDisplay:new(monitorPeripheral)
    expect(1, monitorPeripheral, "string")
    local monitor = peripheral.wrap(monitorPeripheral) or error("Monitor not found", 0)
    local obj = {}
    setmetatable(obj, MonitorDisplay)
    obj.monitor = monitor
    obj.monitor.setTextScale(1)
    return obj
end

-- clears monitor data fully and writes default header
---@return nil
function MonitorDisplay:clear()
    self.monitor.clear()
    self.monitor.setCursorPos(1, 1)
end

-- prints text on the monitor and goes to the next line
---@return nil
function MonitorDisplay:printLn(text)
    local _, y = self.monitor.getCursorPos()
    self.monitor.write(text)
    self.monitor.setCursorPos(1, y + 1)
end

function MonitorDisplay:size()
    local width, height = self.monitor.getSize()
    return width, height
end

return MonitorDisplay
