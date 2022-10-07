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
  {
    'TermOpen',
    {
      callback = function()
        vim.opt_local.number = false
      end,
    },
  },
  {
    'BufRead',
    {
      callback = function ()
        if vim.bo.readonly then
          vim.bo.modifiable = false
        end
      end
    }
  }
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(unpack(v))
end
