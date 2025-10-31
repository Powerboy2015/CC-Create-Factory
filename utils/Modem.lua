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

function Modem:listen(port, callback)
    coroutine.create(function()
        expect(1, port, "number")
        expect(2, callback, "function")
        self.modem.open(port)
        while true do
            local event, side, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
            if senderChannel == port then
                callback(message, senderChannel, replyChannel, senderDistance)
            end
        end
    end
    )()
end

function Modem:send(port, message)
    expect(1, port, "number")
    self.modem.transmit(port, 0, message)
end

return Modem
