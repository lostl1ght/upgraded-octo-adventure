vim.api.nvim_set_hl(0, 'YankHighlight', { fg = '#DCA561', bg = '#49443C' })
local autocmds = {
  {
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 350 })
      end,
      group = vim.api.nvim_create_augroup('YankHighlight', {}),
    },
  },
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(v[1], v[2])
end
