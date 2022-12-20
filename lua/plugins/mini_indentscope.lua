local M = { 'echasnovski/mini.indentscope' }

M.event = 'BufReadPre'

M.config = function()
  require('mini.indentscope').setup({
    draw = {
      animation = require('mini.indentscope').gen_animation.none(),
    },
    symbol = '│',
  })
end

return M
