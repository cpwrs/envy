-- Line is a container for components/strings that will
-- be compiled to a string for vim.opt.statusline.

local Line = {}

-- Content contains the components/strings.
-- Members are displayed on the statusline left to right.
Line.content = {}

-- Concatenate contnet into a single string to be displayed. 
function Line:compile()
  local state = ""
  for _, comp in pairs(self.content) do
    if type(comp) == "string" then
      state = state .. comp
    else
      state = state .. comp.state
    end
  end
  return state
end

-- For each component in content: create autocmds to execute Module.state_func on Module.events
function Line:create_autocmds()
  for _, comp in pairs(self.content) do
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

function Line:setup(content)
  self.content = content
  self:create_autocmds()
  vim.opt.statusline = self:compile()
end

return Line
