-- Options


-- Status line and cmd line
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.showcmd = true

-- Finding files
vim.opt.wildmenu = true
vim.opt.path:append('**')

-- Completion
vim.opt.completeopt = {'menu', 'menuone', 'popup', 'fuzzy', 'noinsert'}

-- 24-bit RGB
vim.opt.termguicolors = true

-- Indents = two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'both'

-- Other
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.incsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Ignore style recommendations 
vim.g.python_recommended_style = 0
