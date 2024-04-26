-- Telescope plugin configuration

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 0.3,
      width = vim.o.columns,
      prompt_position = "bottom",
      preview_cutoff = 1,
      preview_width = 0.5,
    },
  },
})

vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end)
vim.keymap.set('n', '<leader>fb', function() builtin.buffers() end)
vim.keymap.set('n', '<leader>fg', function() builtin.live_grep() end)
vim.keymap.set('n', '<leader>gf', function() builtin.git_files() end)
