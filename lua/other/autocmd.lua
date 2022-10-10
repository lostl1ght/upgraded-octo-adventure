local autocmds = {
  {
    'TextYankPost',
    {
      callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 350 })
      end,
      group = vim.api.nvim_create_augroup('YankHighlight', {}),
    },
  },
  {
    'TermOpen',
    {
      callback = function()
        vim.opt_local.number = false
      end,
      group = vim.api.nvim_create_augroup('TermNumbers', {}),
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
      group = vim.api.nvim_create_augroup('BufModifiable', {}),
    },
  },
  {
    'LspAttach',
    {
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        require('aerial').on_attach(client, bufnr)
      end,
      group = vim.api.nvim_create_augroup('LspOnAttach', {}),
    },
  },
}
for _, v in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(unpack(v))
end
