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
      fg = 6985097,   -- #6a9589
    },
  }
  require('kanagawa').setup({
    undercurl = false,
    globalStatus = true,
    overrides = {
      FoldColumn = colors.FoldColumn,
      YankHighlight = colors.YankHighlight,
      MiniIndentscopeSymbol = colors.MiniIndentscope,
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

function config.hydra()
  vim.api.nvim_set_hl(0, 'HydraHint', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'HydraBorder', { link = 'FloatermBorder' })
end

function config.illum()
  require('illuminate').configure()
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
  })
end

function config.indentscope()
  require('mini.indentscope').setup()
end

return config
