vim.api.nvim_create_augroup('YankHighlight', {})
vim.api.nvim_create_augroup('TermOptions', {})
vim.api.nvim_create_augroup('BufModifiable', {})
local autocmds = {
  {
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 350 })
      end,
      group = 'YankHighlight',
    },
  },
  {
    'TermOpen',
    {
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.b.miniindentscope_disable = true
      end,
      group = 'TermOptions',
    },
  },
  {
    'TermClose',
    {
      callback = function(arg)
        if vim.v.event.status == 0 then
          vim.api.nvim_cmd({ cmd = 'bdelete', bang = true, args = { arg.buf } }, {})
        end
      end,
      group = 'TermOptions',
    },
  },
  {
    'BufRead',
    {
      callback = function()
        if vim.bo.readonly then
          vim.bo.modifiable = false
        end
      end,
      group = 'BufModifiable',
    },
  },
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(unpack(v))
end
