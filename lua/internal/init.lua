local file_group = vim.api.nvim_create_augroup('CustomFiletype', {})
local autocmds = {
  {
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ timeout = 350 })
      end,
      group = vim.api.nvim_create_augroup('YankHighlight', {}),
    },
  },
  {
    { 'BufRead', 'BufNewFile', 'BufWinEnter' },
    {
      pattern = '.clang-format',
      callback = function()
        vim.bo.filetype = 'yaml'
      end,
      group = file_group,
    },
  },
  {
    { 'BufRead', 'BufNewFile', 'BufWinEnter' },
    {
      pattern = { '*.zsh', '.zshrc', '.zshenv' },
      callback = function()
        vim.bo.filetype = 'bash'
      end,
      group = file_group,
    },
  },
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(v[1], v[2])
end
