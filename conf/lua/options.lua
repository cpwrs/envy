# Assign vim.opts

local options = {
  ['fillchars'] = {
    horiz = ' ',
    horizup = ' ',
    horizdown = ' ',
    vert = ' ',
    vertleft  = ' ',
    vertright = ' ' ,
    verthoriz = ' ',
  },
  ['laststatus'] = 3,
  ['termguicolors'] = true,
  ['tabstop'] = 2,
  ['shiftwidth'] = 2,
  ['expandtab'] = true,
  ['smartindent'] = true,

  ['number'] = true,
  ['relativenumber'] = true,
  ['signcolumn'] = 'yes',
  ['cursorline'] = true,
  ['cursorlineopt'] = 'both',

  ['wrap'] = false,
  ['scrolloff'] = 8,
  ['incsearch'] = true,
  ['clipboard'] = 'unnamedplus'
}

-- Assign each vim.opt key-value listed in the options table.
for key, value in pairs(options) do
  vim.opt[key] = value
end
