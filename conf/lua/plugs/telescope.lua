-- Telescope plugin configuration

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local ivy = require('telescope.themes').get_ivy()

telescope.setup()
vim.keymap.set('n', '<leader>ff', function() builtin.find_files(ivy) end)
vim.keymap.set('n', '<leader>gf', function() builtin.git_files(ivy) end)
