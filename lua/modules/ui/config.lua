local config = {}

function config.kanagawa()
  -- stylua: ignore
  local colors = {
    FoldColumn = {
      fg = 3552838,   -- #363646
    },
    YankHighlight = {
      fg = 14460257,  -- #dca561
      bg = 4801596,   -- #49443c
    },
    MiniIndentscopeSymbol = {
      fg = 2969447,   -- #2D4F67
    },
  }
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
    overrides = {
      FoldColumn = colors.FoldColumn,
      YankHighlight = colors.YankHighlight,
      MiniIndentscopeSymbol = colors.MiniIndentscopeSymbol,
    },
  })
  vim.cmd.colorscheme('kanagawa')
end

function config.heirline()
  local statuline = require('modules.ui.heirline.statusline').StatusLine
  local winbar = require('modules.ui.heirline.winbar').WinBar
  local tabline = require('modules.ui.heirline.tabline').TabLine
  require('heirline').setup(statuline, winbar, tabline)
end

function config.dressing()
  require('dressing').setup({
    input = {
      relative = 'editor',
    },
  })
end

function config.illum()
  require('illuminate').configure({
    filetypes_denylist = { 'noice', 'registers', 'lir', 'Glance' },
  })
end

function config.matchup()
  vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  require('nvim-treesitter.configs').setup({
    matchup = {
      enable = true,
      include_match_words = true,
    },
  })
end

function config.langmap_switch()
  require('langmap_switch').setup({ keymap = 'russian-jcukenwin' })
end

function config.noice()
  require('noice').setup({
    cmdline = {
      view = 'cmdline',
      format = {
        search_down = {
          view = 'cmdline',
        },
        search_up = {
          view = 'cmdline',
        },
      },
    },
    messages = {
      view = 'mini',
      view_error = 'mini',
      view_warn = 'mini',
    },
    popupmenu = {
      backend = 'cmp',
    },
    notify = {
      view = 'mini',
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      hover = {
        opts = {
          position = { row = 2, col = 2 },
        },
      },
      signature = {
        opts = {
          position = { row = 2, col = 2 },
        },
      },
      message = {
        view = 'mini',
      },
      documentation = {
        opts = {
          border = { style = 'single', padding = { 0, 0 } },
        },
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = '10%',
          col = '50%',
        },
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = 'search_count',
        },
        opts = { skip = true },
      },
    },
  })
end

function config.indentscope()
  require('mini.indentscope').setup({
    draw = {
      animation = require('mini.indentscope').gen_animation('none', {}),
    },
    symbol = '│',
  })
end

function config.whichkey()
  local wk = require('which-key')
  wk.setup({
    show_help = false,
    show_keys = false,
    triggers_blacklist = {
      i = { 'j', 'k', 'i' },
      v = { 'j', 'k', 'i' },
    },
  })
  wk.register({
    ['<leader>'] = {
      p = { name = 'packer' },
      w = { name = 'window' },
      g = { name = 'git' },
      t = { name = 'telescope' },
      d = { name = 'debug' },
      q = { name = 'persistence' },
      l = { name = 'lsp' },
    },
  }, {})
end

return config
