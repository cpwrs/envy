-- Neovim configuration entry point


-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader =  ' '

-- Load neovim options and plugin configurations.
require('options')
require('highlights')
require('statusline')
require('plugs')
