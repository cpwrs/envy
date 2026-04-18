-- Options

vim.opt.laststatus = 2                               -- Last window always has status line
vim.opt.showmode = false                             -- Don't show the mode on the cmd line.
vim.opt.showcmd = true                               -- Show command in the last line of the screen
vim.opt.foldlevel = 99                               -- All folds are open on file open
vim.opt.foldmethod = "expr"                          -- Use foldexpr as the method
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use the TS AST to figure out what's foldable
vim.opt.foldcolumn = "0"                             -- Hide the fold column in the sign gutter
vim.opt.fillchars:append({ fold = " " })             -- Default fold fill char is a space
vim.opt.wildmenu = true                              -- Command line completion using tab
vim.opt.path:append('**')                            -- Add current dir and all its subdirs, recursively, to the file-finding commands.

vim.opt.completeopt = {
  'menu',    -- Always show a menu of competion items,
  'menuone', -- even when there's only one.
  'popup',   -- Show extra information about the selected completion item in a popup.
  'fuzzy',   -- Fuzzy match for completion candidates.
  'noinsert' -- Do not insert any text for a match until selected.
}

vim.opt.termguicolors = true  -- 24-bit RGB
vim.opt.tabstop = 2           -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2        -- Number of spaces to use for each step of (auto)indention
vim.opt.expandtab = true      -- Tabs are inserted as spaces
vim.opt.autoindent = true     -- Copy indent from current line when starting a new line.
vim.opt.smartindent = true    -- Smart indent new lines.
vim.opt.smarttab = true       -- A tab in front of a line inserts blanks according to shiftwidth.
vim.opt.number = true         -- Print the line number in front of each line.
vim.opt.relativenumber = true -- Line number is relative to cursor
vim.opt.signcolumn = 'yes:1'  -- Always draw the signcolumn, with fixed space of 1 column (for gitsigns)
vim.opt.cursorline = true     -- Highlight the line the cursor is on.
vim.opt.cursorlineopt = 'both'-- Display cursor line with respective hl groups for the number and the line
vim.opt.wrap = false -- Don't wrap lines that don't fit in the buffer width
vim.opt.scrolloff = 8 -- Keep 8 screen linus above the cursor
vim.opt.incsearch = true -- Show where the pattern matches while typing a search command
vim.opt.splitbelow = true -- Put a new window below the current one
vim.opt.splitright = true -- Put a new vertical window to the right of the current one

-- Ignore style recommendations
vim.g.python_recommended_style = 0
