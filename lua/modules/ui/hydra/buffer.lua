local Hydra = require 'hydra'
local cmd = require('hydra.keymap-util').cmd
local hydra = Hydra {
    name = 'Buffers',
    heads = {
        { 'l', cmd 'bn', { desc = 'next buf' } },
        { 'h', cmd 'bp', { desc = 'prev buf' } },
        { 'c', cmd 'bd', { desc = 'close' } },
        { '`', cmd 'b#', { desc = 'switch' } },
        { 'q', nil, { exit = true, desc = false } },
    },
}

return hydra