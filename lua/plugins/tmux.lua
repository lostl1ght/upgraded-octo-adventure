local M = { 'aserowy/tmux.nvim' }

M.lazy = false

M.config = function()
  require('tmux').setup({
    copy_sync = {
      enable = false,
    },
    navigation = {
      enable_default_keybindings = false,
    },
    resize = {
      enable_default_keybindings = false,
      resize_step_x = 3,
      resize_step_y = 3,
    },
  })
end

return M
