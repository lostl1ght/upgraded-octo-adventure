local config = {}

function config.cmp()
  local cmp = require('cmp')

  local cmp_buffer = require('cmp_buffer')
  local luasnip = require('luasnip')
  vim.o.completeopt = 'menu,menuone,noselect'
  cmp.setup({
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
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      {
        name = 'buffer',
        keyword_length = 5,
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
        with_text = true,
        menu = {
          buffer = '[buf]',
          nvim_lsp = '[lsp]',
          nvim_lua = '[api]',
          path = '[path]',
          luasnip = '[snip]',
        },
      }),
    },
    experimental = {
      native_menu = false,

      ghost_text = true,
    },
  })
end

function config.luasnip()
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
end

return config
