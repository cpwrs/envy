-- Telescope plugin configuration

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    layout_config = {
      preview_width = 0.5,
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
  },
})

vim.keymap.set('n', '<leader>f', function() builtin.find_files() end, { desc = "Fuzzy find files" })
vim.keymap.set('n', '<leader>b', function() builtin.buffers() end, { desc = "Fuzzy find buffers" })
vim.keymap.set('n', '<leader>r', function() builtin.live_grep() end, { desc = "Fuzzy ripgrep" })
vim.keymap.set('n', '<leader>d', function() builtin.diagnostics() end, { desc = "Fuzzy find diagnostics" })
vim.keymap.set('n', '<leader>i', function() builtin.lsp_implementations() end, { desc = "Fuzzy find LSP implementations" })
vim.keymap.set('n', '<leader>g', function() builtin.git_status() end, { desc = "Fuzzy git status" })
