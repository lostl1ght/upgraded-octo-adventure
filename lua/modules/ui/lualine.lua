local navic = require('nvim-navic')

local function get_location()
  local location = navic.get_location()
  return location ~= '' and location or ' '
end

local function lsp_names()
  local names = {}
  for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
    table.insert(names, server.name)
  end
  return #names > 0 and ' ' .. table.concat(names, ' ') or ''
end

local function get_cwd()
  local cwd = vim.fn.getcwd(0)
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path == '' then
    cwd = vim.fn.fnamemodify(cwd, ':~')
  elseif current_path:find(cwd, 1, true) then
    cwd = vim.fn.fnamemodify(cwd, ':~')
  else
    cwd = ''
  end
  return cwd
end

local function get_path()
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path ~= '' then
    current_path = vim.fn.fnamemodify(current_path, ':~:.:h')
    if current_path == '.' then
      current_path = ''
    end
  end
  return current_path
end

local function config()
  require('lualine').setup({
    options = {
      globalstatus = true,
      theme = 'kanagawa',
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
      },
      lualine_b = {
        { get_cwd },
        { get_path },
        { 'filename', file_status = false },
      },
      lualine_c = {
        { 'branch', icon = '' },
        { 'diff' },
      },

      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        },
        { lsp_names },
      },
      lualine_y = { 'filetype' },
      lualine_z = {
        { 'location', separator = { left = '', right = '' }, left_padding = 2 },
      },
    },
    winbar = {
      lualine_c = {
        { get_location, cond = navic.is_available },
      },
    },
  })
end

return { config = config }
