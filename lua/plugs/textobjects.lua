local textobjects = require('nvim-treesitter-textobjects')

textobjects.setup {
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v',
      ['@function.outer'] = 'V',
      ['@class.outer'] = 'V',
    },
  },
  move = { set_jumps = true },
}

local function keymap(lhs, rhs, desc, mode)
  vim.keymap.set(mode or 'n', lhs, rhs, { desc = desc })
end

-- Select
local select = require('nvim-treesitter-textobjects.select')
keymap("am", function()
  select.select_textobject("@function.outer", "textobjects")
end, "Select around function", { "x", "o" })
keymap("im", function()
  select.select_textobject("@function.inner", "textobjects")
end, "Select inside function", { "x", "o" })
keymap("ac", function()
  select.select_textobject("@class.outer", "textobjects")
end, "Select around class", { "x", "o" })
keymap("ic", function()
  select.select_textobject("@class.inner", "textobjects")
end, "Select inside class", { "x", "o" })
keymap("as", function()
  select.select_textobject("@local.scope", "locals")
end, "Select around scope", { "x", "o" })
-- Move
local move = require('nvim-treesitter-textobjects.move')
keymap("]m", function()
  move.goto_next_start("@function.outer", "textobjects")
end, "Next function start", { "n", "x", "o" })
keymap("]]", function()
  move.goto_next_start("@class.outer", "textobjects")
end, "Next class start", { "n", "x", "o" })
keymap("]o", function()
  move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, "Next loop start", { "n", "x", "o" })
keymap("]s", function()
  move.goto_next_start("@local.scope", "locals")
end, "Next scope start", { "n", "x", "o" })
keymap("]z", function()
  move.goto_next_start("@fold", "folds")
end, "Next fold start", { "n", "x", "o" })
keymap("]M", function()
  move.goto_next_end("@function.outer", "textobjects")
end, "Next function end", { "n", "x", "o" })
keymap("][", function()
  move.goto_next_end("@class.outer", "textobjects")
end, "Next class end", { "n", "x", "o" })
keymap("[m", function()
  move.goto_previous_start("@function.outer", "textobjects")
end, "Previous function start", { "n", "x", "o" })
keymap("[[", function()
  move.goto_previous_start("@class.outer", "textobjects")
end, "Previous class start", { "n", "x", "o" })
keymap("[M", function()
  move.goto_previous_end("@function.outer", "textobjects")
end, "Previous function end", { "n", "x", "o" })
keymap("[]", function()
  move.goto_previous_end("@class.outer", "textobjects")
end, "Previous class end", { "n", "x", "o" })
