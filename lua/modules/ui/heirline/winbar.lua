local colors = require('modules.ui.heirline.colors')
local mode_colors = colors.highlight.ModeColors
local conditions = require 'heirline.conditions'
local navic = require 'nvim-navic'

local Space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
        return { provider = string.rep(' ', n) }
    end,
})

local Navic = {
    condition = navic.is_available,
    provider = navic.get_location,
    hl = { fg = mode_colors.normal.fg },
}

local banned_buftypes = { 'prompt', 'nofile', 'help', 'quickfix', 'terminal' }
local banned_filetypes = { 'gitcommit', 'fugitive', 'dashboard', '^git.*' }

vim.api.nvim_create_autocmd('User', {
    pattern = 'HeirlineInitWinbar',
    callback = function(args)
        local buf = args.buf
        local buftype = vim.tbl_contains(banned_buftypes, vim.bo[buf].buftype)
        local filetype = vim.tbl_contains(banned_filetypes, vim.bo[buf].filetype)
        if buftype or filetype then
            vim.opt_local.winbar = nil
        end
    end,
})

local winbar = {
    fallthrough = false,
    {
        condition = function()
            return conditions.buffer_matches {
                buftype = banned_buftypes,
                filetype = banned_filetypes,
            }
        end,
        init = function()
            vim.opt_local.winbar = nil
        end,
    },
    {
        Space,
        Navic,
    },
}

return { WinBar = winbar }
