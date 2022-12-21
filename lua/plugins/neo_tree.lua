local M = { 'nvim-neo-tree/neo-tree.nvim' }

M.cmd = 'Neotree'

M.dependencies = {
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  'MunifTanjim/nui.nvim',
}

M.init = function()
  vim.g.neo_tree_remove_legacy_commands = 1
end

M.config = function()
  require('neo-tree').setup({
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = 'open_current',
    },
  })
end

return M
