local config = {}

function config.neogit()
  require('diffview').setup({
    enhanced_diff_hl = true,
  })
  require('neogit').setup({
    signs = {
      section = { ' ', ' ' },
      item = { '>', 'v' },
      hunk = { '', '' },
    },
    integrations = { diffview = true },
  })
end

function config.gitsigns()
  require('gitsigns').setup()
end

return config
