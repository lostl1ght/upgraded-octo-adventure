local M = { 's1n7ax/nvim-window-picker' }

M.config = function()
  require('window-picker').setup({
    include_current_win = true,
    use_winbar = 'smart',
    fg_color = '#2a2a37',
    current_win_hl_color = '#c34043',
    other_win_hl_color = '#76946a',
  })
end

return M
