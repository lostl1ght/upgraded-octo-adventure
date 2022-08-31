local colors = require('modules.ui.heirline.colors')
local mode_colors = colors.highlight.ModeColors
local heirline = require 'heirline.utils'
local conditions = require 'heirline.conditions'
local navic = require 'nvim-navic'

local Space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
        return { provider = string.rep(' ', n) }
    end,
})

local Navic = {
    condition = navic.is_available,
    static = {
        type_hl = {
            File = 'Directory',
            Module = 'Include',
            Namespace = 'TSNamespace',
            Package = 'Include',
            Class = 'Structure',
            Method = 'Function',
            Property = 'TSProperty',
            Field = 'TSField',
            Constructor = 'TSConstructor',
            Enum = 'TSField',
            Interface = 'Type',
            Function = 'Function',
            Variable = 'TSVariable',
            Constant = 'Constant',
            String = 'String',
            Number = 'Number',
            Boolean = 'Boolean',
            Array = 'TSField',
            Object = 'Type',
            Key = 'TSKeyword',
            Null = 'Comment',
            EnumMember = 'TSField',
            Struct = 'Structure',
            Event = 'Keyword',
            Operator = 'Operator',
            TypeParameter = 'Type',
        },
    },
    init = function(self)
        local data = require('nvim-navic').get_data() or {}
        local children = {}
        for i, d in ipairs(data) do
            local child = {
                {
                    provider = d.icon,
                    hl = self.type_hl[d.type],
                },
                {
                    provider = d.name,
                },
            }
            if #data > 1 and i < #data then
                table.insert(child, {
                    provider = ' > ',
                    hl = { fg = mode_colors.normal.fg },
                })
            end
            table.insert(children, child)
        end
        self[1] = self:new(children, 1)
    end,
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
