local M = { 'weilbith/nvim-code-action-menu' }

M.cmd = 'CodeActionMenu'

M.config = function ()
  vim.g.code_action_menu_show_diff = false
end

return M
