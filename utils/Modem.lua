-- modem: A wrapper for modems to set up simple send, listen and receive functions.

local expect = require("cc.expect").expect

---@class Modem
local Modem = {}
Modem.__index = Modem

---@return Modem
---@param modemPeripheral string
---@
function Modem:new(modemPeripheral)
    expect(1, modemPeripheral, "string")
    local modem = peripheral.wrap(modemPeripheral) or error("Modem not found", 0)
    local obj = {}
    setmetatable(obj, Modem)
    obj.modem = modem
    return obj
end

-- ---@return nil
-- ---@param port number
-- ---@param callback function
-- local function listenFunc(port, callback)
--     expect(1, port, "number")
--     expect(2, callback, "function")
--     Modem.modem.open(port)
--     while true do
--         local event, side, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
--         if senderChannel == port then
--             callback(message, senderChannel, replyChannel, senderDistance)
--         end
--     end
-- end

---@return nil
---@param _port integer
function Modem:listen(_port, _callback)
    expect(2, _port, "number")
    expect(3, _callback, "function")

    self.modem.open(_port)
    print("Modem listening on port " .. _port)
    while true do
        local _, side, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
        if senderChannel == _port then
            -- print("message received on port " .. _port)
            _callback(message, senderChannel, replyChannel, senderDistance)
        end
    end
end

function Modem:send(port, message)
    expect(1, port, "number")
    self.modem.transmit(port, 0, message)
end

return Modem
