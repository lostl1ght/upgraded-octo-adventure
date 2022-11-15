local yank = vim.api.nvim_create_augroup('YankHighlight', {})
local term = vim.api.nvim_create_augroup('TermOptions', {})
local bufmod = vim.api.nvim_create_augroup('BufModifiable', {})
local autocmds = {
  {
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 350 })
      end,
      group = yank,
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
      group = term,
    },
  },
  {
    'TermClose',
    {
      callback = function(arg)
        if vim.v.event.status == 0 then
          vim.api.nvim_cmd({ cmd = 'bdelete', args = { arg.buf } }, {})
        end
      end,
      group = term,
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
      group = bufmod,
    },
  },
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(unpack(v))
end
