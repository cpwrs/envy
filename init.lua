-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader =  ' '

-- Load neovim options, plugin configurations, and custom statusline
require('options')
require('colors')
require('statusline')
require('plugs')
require('lsp')

-- Keymaps not specific to plugins:

-- Navigate panes with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', vim.cmd("wincmd h"))
vim.keymap.set('n', '<C-j>', vim.cmd("wincmd j"))
vim.keymap.set('n', '<C-k>', vim.cmd("wincmd k"))
vim.keymap.set('n', '<C-l>', vim.cmd("wincmd l"))

-- Start/end of line with H and L
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- Copy/paste from system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "x" }, "<leader>p", [["+p]])
