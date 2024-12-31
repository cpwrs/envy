-- Blink completion config

local blink = require("blink.cmp")

blink.setup({
  enabled = function()
    return not vim.tbl_contains({ "markdown", "oil" }, vim.bo.filetype)
      and vim.bo.buftype ~= "prompt"
      and vim.b.completion ~= false
  end,

  keymap = { preset = "default" },
  appearance = { use_nvim_cmp_as_default = true },
  signature = { enabled = true },
  fuzzy = { prebuilt_binaries = { download = false } },

  completion = {
    keyword = { range = 'full' },
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
        components = {
          kind = {
            highlight = "PmenuKind",
          }
        }
      }
    }
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    -- cmdline completion based on cmdtype
    cmdline = function()
      local type = vim.fn.getcmdtype()
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end
  }
})
