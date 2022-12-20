local M = { 'nvim-telescope/telescope.nvim' }

M.cmd = { 'Telescope' }

M.dependencies = {
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
}

M.config = function()
  require('telescope').setup({
    pickers = {
      find_files = {
        hidden = true,
        previewer = false,
        layout_strategy = 'center',
        sorting_strategy = 'ascending',
        layout_config = {
          height = 0.5,
          width = 0.4,
          prompt_position = 'top',
        },
      },
      buffers = {
        previewer = false,
        layout_strategy = 'center',
        sorting_strategy = 'ascending',
        layout_config = {
          height = 0.5,
          width = 0.4,
          prompt_position = 'top',
        },
      },
      live_grep = {
        layout_strategy = 'vertical',
      },
      help_tags = {
        mappings = {
          i = {
            ['<cr>'] = 'select_vertical',
          },
          n = {
            ['<cr>'] = 'select_vertical',
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  })
  require('telescope').load_extension('fzf')
end

return M
