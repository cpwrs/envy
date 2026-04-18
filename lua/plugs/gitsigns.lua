local gitsigns = require('gitsigns')

gitsigns.setup({
  signcolumn = true,
  numhl = false,

  on_attach = function(bufnr)
    local function keymap(lhs, rhs, desc, mode)
      vim.keymap.set(mode or 'n', lhs, rhs, { desc = desc, buffer = bufnr })
    end

    keymap(']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, "Next git hunk")

    keymap('[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, "Previous git hunk")

    keymap('<leader>B', function()
      gitsigns.blame_line({ full = true })
    end, "Show cursor line git blame")

    keymap('ih', gitsigns.select_hunk, "Select git hunk", { 'o', 'x' })
  end
})
