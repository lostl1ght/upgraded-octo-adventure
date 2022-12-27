local M = { 'nvim-neo-tree/neo-tree.nvim' }

M.cmd = 'Neotree'

M.dependencies = {
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  'MunifTanjim/nui.nvim',
  's1n7ax/nvim-window-picker',
}

M.init = function()
  vim.g.neo_tree_remove_legacy_commands = 1
end

M.config = function()
  require('neo-tree').setup({
    popup_border_style = 'single',
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = 'open_current',
    },
  })
end

return M
