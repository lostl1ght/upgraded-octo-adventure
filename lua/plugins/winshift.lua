local M = { 'sindrets/winshift.nvim' }

M.cmd = 'WinShift'

M.config = function()
  require('winshift').setup({ focused_hl_group = 'Visual' })
end

return M
