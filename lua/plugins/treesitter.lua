local M = { 'nvim-treesitter/nvim-treesitter' }

M.event = 'BufReadPre'

M.dependencies = {
  {
    'IndianBoy42/tree-sitter-just',
    config = function()
      require('tree-sitter-just').setup({})
    end,
  },
}

M.config = function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      -- basic
      'bash',
      'jsonc',
      'lua',
      'markdown',
      'markdown_inline',
      'regex',
      'toml',
      'vim',
      'yaml',

      -- needed
      'c',
      'cpp',
      'css',
      'fish',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'http',
      'proto',
      'python',
      'rust',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end

return M
