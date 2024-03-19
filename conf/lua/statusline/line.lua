-- Create a table that holds line functions and state.

local Module = require('statusline/module')
local Line = {}

-- Components are the actual text that will be displayed on the line.
-- Members of this list are displayed left to right, and can be of type string or Module.
Line.components = {}

-- Concatenate each component into a single string to be displayed. 
function Line:compile()
  state = ""
  for k, comp in pairs(self.components) do
    if type(comp) == "string" then
      state = state .. comp
    else
      state = state .. comp.state
    end
  end
  return state
end

-- For each Module in components: create autocmds to execute Module.state_func on Module.events
function Line:create_autocmds()
  for k, comp in pairs(self.components) do
    if type(comp) == "table" then
      vim.api.nvim_create_autocmd(comp.events, {
        callback = function()
          comp:exec()
          vim.opt.statusline = self:compile()
        end
      })
    end
  end
end

function Line:setup(components)
  self.components = components
  self:create_autocmds()
  vim.opt.statusline = self:compile()
end

return Line
