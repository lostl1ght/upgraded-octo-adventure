local config = {}

function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'cpp',
      'go',
      'latex',
      'lua',
      'python',
      'rust',
      'toml',
      'yaml',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end

function config.nvimtree()
  require('nvim-tree').setup({
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
  })
end

function config.telescope()
  require('telescope').setup({
    pickers = {
      fd = {
        hidden = true,
        theme = 'dropdown',
      },
      live_grep = {
        hidden = true,
      },
      help_tags = {
        hidden = true,
        mappings = {
          i = {
            ['<cr>'] = 'select_tab',
          },
          n = {
            ['<cr>'] = 'select_tab',
          },
        },
      },
    },
  })
end

return config
