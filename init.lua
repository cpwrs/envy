-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ft = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if lang and pcall(vim.treesitter.language.inspect, lang) then
      vim.treesitter.start()
    end
  end,
})
