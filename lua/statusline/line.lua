-- Statusline is a list of components and strings
-- See components.lua for the specification
local line = {}

function line.setup(components)
  cache = {}
  
  for i, comp in pairs(components) do
    if type(comp) == "table" then
      -- Item is in fact a component
      -- Cache line state, only update individual components on their events
      cache[i] = comp[1]()
      -- Bind to WinEnter/BufEnter by default, plus any events specified
      events = { "WinEnter", "BufEnter", unpack(comp[2] or {}) }
      vim.api.nvim_create_autocmd(events, {
        callback = function() 
          cache[i] = comp[1]()
          vim.opt_local.statusline = table.concat(cache)
        end
      })
    else
      -- Item is a string
      cache[i] = comp
    end
  end
end

return line
