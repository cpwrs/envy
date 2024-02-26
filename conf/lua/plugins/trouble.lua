-- Trouble plugin configuration

local trouble = require('trouble')

trouble.setup {
	icons = false,
	padding = false,
	fold_open = "v",
	fold_closed = ">",
	indent_lines = true,
	use_diagnostic_signs = true,

}

vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end)
