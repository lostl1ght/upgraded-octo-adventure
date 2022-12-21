return {
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'tpope/vim-commentary', event = 'BufReadPost' },
  { 'tpope/vim-fugitive', lazy = false },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = 'markdown',
  },
}
