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
  ['softtabstop'] = 0,
  ['autoindent'] = true,
  ['smarttab'] = true,

  ['number'] = true,
  ['relativenumber'] = true,
  ['signcolumn'] = 'auto',
  ['cursorline'] = true,
  ['cursorlineopt'] = 'number',

  ['showmode'] = false,

  ['wrap'] = false,
  ['scrolloff'] = 8,
  ['incsearch'] = true,
  ['clipboard'] = 'unnamedplus',
}

-- Assign each vim.opt key-value listed in the options table.
for key, value in pairs(options) do
  vim.opt[key] = value
end
