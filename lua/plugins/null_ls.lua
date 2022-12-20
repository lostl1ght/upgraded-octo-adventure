local M = { 'jose-elias-alvarez/null-ls.nvim' }

M.event = 'VeryLazy'

M.config = function()
  local null = require('null-ls')
  null.setup({
    sources = {
      null.builtins.formatting.stylua,
      null.builtins.formatting.rustfmt.with({
        extra_args = { '--edition', '2021' },
      }),
      null.builtins.formatting.latexindent.with({
        filetypes = { 'tex', 'bib' },
        extra_args = {
          '-c',
          '/tmp',
          '-m',
          '-l',
          vim.fs.normalize('~/.config/latexindent/defaultSettings.yaml'),
        },
      }),
      null.builtins.formatting.clang_format,
      null.builtins.formatting.prettier.with({
        filetypes = { 'htmldjango' },
      }),
    },
  })
end

return M
