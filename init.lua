-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader =  ' '

-- Load neovim options, plugin configurations, and custom statusline
require('options')
require('plugs')
require('statusline')
require('lsp')

-- Start/end of line with H and L
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- Copy/paste from system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "x" }, "<leader>p", [["+p]])
