-- Blink completion config

local blink = require("blink.cmp")

blink.setup({
  enabled = function()
    return not vim.tbl_contains({ "markdown", "oil" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
  end,

  keymap = { preset = "default" },
  signature = { enabled = true },
  fuzzy = { prebuilt_binaries = { download = false } },

  completion = {
    keyword = { range = 'full' },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      auto_show = false,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  cmdline = {
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
})
