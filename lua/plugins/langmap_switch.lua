local M = { 'nvim-langmap-switch' }

M.dev = true

M.config = function()
  require('langmap_switch').setup({ keymap = 'russian-jcukenwin' })
end

return M
