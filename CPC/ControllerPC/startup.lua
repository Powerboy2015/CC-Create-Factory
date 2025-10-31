-- Repsonsible for keeping track of data coming in and sending out to other components.
-- Tasks:
--  - Connect to other PC's
--  - gets incoming data from other factory PC's
--  - sends request instructions to other factory PC's based on what's lacking

-- Initialize peripherals
local modem = peripheral.wrap("back") or error("Modem not found", 0)
