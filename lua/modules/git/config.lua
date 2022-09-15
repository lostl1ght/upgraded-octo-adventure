local config = {}

function config.gitsigns()
  require('gitsigns').setup()
end

function config.lazygit()
  require('lazygit').setup({
    on_enter = function()
      vim.keymap.del('t', 'ii', {})
      vim.opt_local.sidescrolloff = 0
      vim.opt_local.virtualedit = 'block'
    end,
    on_leave = function()
      vim.keymap.set('t', 'ii', '<c-\\><c-n>', {})
    end,
  })
end

return config
