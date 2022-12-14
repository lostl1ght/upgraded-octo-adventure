local M = { 'hrsh7th/nvim-cmp' }

M.dependencies = {
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-buffer' },
  { 'onsails/lspkind.nvim' },
}

M.event = { 'InsertEnter', 'CmdLineEnter' }

M.config = function()
  local cmp = require('cmp')

  local cmp_buffer = require('cmp_buffer')
  local luasnip = require('luasnip')
  vim.o.completeopt = 'menu,menuone,noselect'
  local border = {
    border = 'single',
    winhighlight = 'Normal:Normal,FloatBorder:FloatermBorder,CursorLine:Visual,Search:None',
  }
  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(border),
      documentation = cmp.config.window.bordered(border),
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      {
        name = 'buffer',
        keyword_length = 4,
        option = {
          keyword_pattern = [[\k\+]],
        },
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    sorting = {
      comparators = {
        function(...)
          return cmp_buffer:compare_locality(...)
        end,
      },
    },
    formatting = {
      format = require('lspkind').cmp_format({
        menu = {
          buffer = '[buf]',
          cmdline = '[cmd]',
          luasnip = '[snip]',
          nvim_lsp = '[lsp]',
          path = '[path]',
        },
      }),
    },
    experimental = {
      native_menu = false,

      ghost_text = true,
    },
  })
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
end

return M
