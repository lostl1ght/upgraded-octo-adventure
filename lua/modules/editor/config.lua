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

return config
