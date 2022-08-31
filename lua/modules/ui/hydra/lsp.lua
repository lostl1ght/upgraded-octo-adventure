local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local hydra = Hydra({
  name = 'Lsp',
  heads = {
    { 'J', cmd('Lspsaga diagnostic_jump_next'), { desc = 'next diag' } },
    { 'K', cmd('Lspsaga diagnostic_jump_prev'), { desc = 'prev diag' } },
    { 'd', cmd('Lspsaga show_line_diagnostics'), { desc = 'line diag' } },
    { 't', cmd('TroubleToggle'), { exit = true, desc = 'trouble' } },
    { 's', cmd('SymbolsOutline'), { exit = true, desc = 'outline' } },
    { '<Esc>', nil, { desc = false, exit = true } },
  },
})

return hydra
