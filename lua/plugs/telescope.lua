-- Telescope plugin configuration

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 0.4,
      width = vim.o.columns,
      prompt_position = "bottom",
      preview_cutoff = 1,
      preview_width = 0.5,
    },
  },
})

vim.keymap.set('n', '<leader>f', function() builtin.find_files() end, { desc = "Fuzzy find files" })
vim.keymap.set('n', '<leader>b', function() builtin.buffers() end, { desc = "Fuzzy find buffers" })
vim.keymap.set('n', '<leader>r', function() builtin.live_grep() end, { desc = "Fuzzy ripgrep" })
vim.keymap.set('n', '<leader>d', function() builtin.diagnostics() end, { desc = "Fuzzy find diagnostics" })
vim.keymap.set('n', '<leader>r', function() builtin.lsp_references() end, { desc = "Fuzzy find LSP references" })
vim.keymap.set('n', '<leader>i', function() builtin.lsp_implementations() end, { desc = "Fuzzy find LSP implementations" })
vim.keymap.set('n', '<leader>g', function() builtin.git_status() end, { desc = "Fuzzy git status" })
