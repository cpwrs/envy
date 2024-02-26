-- nvim-treesitter configuration

local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
	auto_install = false,
	highlight = { enable = true },
	indent = { emable = true },
}
