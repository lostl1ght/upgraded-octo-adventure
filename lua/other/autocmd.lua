local yank = vim.api.nvim_create_augroup('YankHighlight', {})
local term = vim.api.nvim_create_augroup('TermOptions', {})
local bufmod = vim.api.nvim_create_augroup('BufModifiable', {})
local autocmds = {
  {
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 350 })
      end,
      group = yank,
    },
  },
  {
    'TermOpen',
    {
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.b.miniindentscope_disable = true
      end,
      group = term,
    },
  },
  {
    'TermClose',
    {
      callback = function(arg)
        if vim.v.event.status == 0 then
          vim.api.nvim_cmd({ cmd = 'bdelete', args = { arg.buf } }, {})
        end
      end,
      group = term,
    },
  },
  {
    'BufRead',
    {
      callback = function()
        if vim.bo.readonly then
          vim.bo.modifiable = false
        end
      end,
      group = bufmod,
    },
  },
  {
    'LspAttach',
    {
      callback = function(args)
        local keymap = require('core.keymap')
        local nmap = keymap.nmap
        local opts = keymap.new_opts
        local cmd = keymap.cmd
        local buf = args.buf
        nmap({
          { 'K', vim.lsp.buf.hover, opts('Hover', buf) },
          { ']d', vim.diagnostic.goto_next, opts('Next diagnostic', buf) },
          { '[d', vim.diagnostic.goto_prev, opts('Next diagnostic', buf) },
          { '<leader>lr', vim.lsp.buf.rename, opts('Rename', buf) },
          {
            '<leader>ll',
            function()
              vim.g.lsplines_enabled = not vim.g.lsplines_enabled
              vim.diagnostic.config({
                virtual_lines = vim.g.lsplines_enabled,
              })
              vim.notify(
                string.format(
                  'Line diagnostics %s',
                  vim.g.lsplines_enabled and 'enabled' or 'disabled'
                ),
                vim.log.levels.INFO,
                { title = 'Diagnostics' }
              )
            end,
            opts('Toggle diagnostics', buf),
          },
          {
            '<leader>lf',
            function()
              vim.lsp.buf.format({
                filter = function(client)
                  return client.name == 'null-ls'
                end,
              })
              pcall(vim.api.nvim_cmd, { cmd = 'write', mods = { silent = true } }, {})
            end,
            opts('Format', buf),
          },
          { '<leader>le', cmd('Glance references'), opts('References', buf) },
          { 'gi', cmd('Glance implementations'), opts('Implementations', buf) },
          { 'gd', cmd('Glance definitions'), opts('Definitions', buf) },
          { '<leader>ly', cmd('Glance type_definitions'), opts('Type definitions', buf) },
          {
            '<leader>ld',
            cmd('TroubleToggle document_diagnostics'),
            opts('Document diagnostics', buf),
          },
          {
            '<leader>lw',
            cmd('TroubleToggle workspace_diagnostics'),
            opts('Workspace diagnostics', buf),
          },
          { '<leader>lt', cmd('AerialToggle'), opts('Document symbols', buf) },
          { '<leader>la', cmd('CodeActionMenu'), opts('Code actions', buf) },
        })
      end,
    },
  },
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(unpack(v))
end
