local config = {}

function config.diffview()
  require('diffview').setup({
    enhanced_diff_hl = true,
  })
end

function config.gitsigns()
  require('gitsigns').setup()
end

function config.neogit()
  require('neogit').setup({
    signs = {
      section = { ' ', ' ' },
      item = { '>', 'v' },
      hunk = { '', '' },
    },
    integrations = { diffview = true },
  })
end

return config
