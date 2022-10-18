local config = {}

function config.gitsigns()
  require('gitsigns').setup({
    signs = {
      add = {
        hl = 'GitSignsAdd',
        text = '▕',
        numhl = 'GitSignsAddNr',
        linehl = 'GitSignsAddLn',
      },
      change = {
        hl = 'GitSignsChange',
        text = '▕',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
      delete = {
        hl = 'GitSignsDelete',
        text = '_',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      topdelete = {
        hl = 'GitSignsDelete',
        text = '‾',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      changedelete = {
        hl = 'GitSignsChange',
        text = '~',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
    },
  })
end

function config.lazygit()
  vim.api.nvim_set_hl(0, 'LazyGitBorder', { link = 'FloatermBorder' })
  vim.api.nvim_set_hl(0, 'LazyGitNormal', { link = 'Normal' })
  require('lazygit').setup()
end

return config
