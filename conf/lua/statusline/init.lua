-- Define statusline modules and create bindings to neovim events.

local Module = require('statusline/module')

-- Translate from the mode neovim gives us to what will be displayed.
local translate = {
  ["n"] = "Normal",
  ["no"] = "Normal",
  ["v"] = "Visual",
  ["V"] = "Visual Line",
  [""] = "Visual Block",
  ["s"] = "Select",
  ["S"] = "Select Line",
  [""] = "Select Block",
  ["i"] = "Insert",
  ["ic"] = "Insert",
  ["R"] = "Replace",
  ["Rv"] = "Visual Replace",
  ["c"] = "Command",
  ["cv"] = "Vim Ex",
  ["ce"] = "Ex",
  ["r"] = "Prompt",
  ["rm"] = "Moar",
  ["r?"] = "Confirm",
  ["!"] = "Shell",
  ["t"] = "Terminal",
}

-- Boilerplate needed for processing and displaying diagnostic status.
local diag_data = {
  {level = "Error", hl = "%#StatusError#", display = "errors"},
  {level = "Warn", hl = "%#StatusWarn#", display = "warnings"},
  {level = "Info", hl = "%#StatusInfo#", display = "info"},
  {level = "Hint", hl = "%#StatusHint#", display = "hints"},
}

-- Modules: Objects that update on specific bindings and return state for
-- the statusline to display. Don't include WinEnter/BufEnter binds!

-- Show the editing mode.
local mode = Module.new(
  function() 
    local mode = translate[vim.api.nvim_get_mode().mode] 
    return string.format(" %s ", mode)
  end,
  {"ModeChanged"}
)

-- Show the file path.
local path = Module.new(
  function()
    local fname = vim.fn.expand "%:~:t"
    if fname == "" then
      return ""
    end
    return "%#StatusLineExtra# " .. fname .. " "
  end
)

-- Indicator that the buffer has been modified.
local modified = Module.new(
  function()
    if vim.bo.modified then
      return "+"
    end
    return ""
  end,
  {"BufModifiedSet"}
)

-- Display diagnostic count by severity.
local diagnostics = Module.new(
  function()
    status = ""
    for k, data in pairs(diag_data) do
      count = vim.tbl_count(vim.diagnostic.get(0, {severity = data.level}))
      if count ~= 0 then
        status = status .. data.hl .. data.display .. " " .. count .. " "
      end
    end
    if status ~= "" then
      status = " (" .. string.sub(status, 0, -2) .. "%#StatusLineExtra#)"
    end

    return status
  end,
  {"DiagnosticChanged"}
)

-- Show file permissions.
local permissions = Module.new(
  function()
		local fname = vim.fn.expand("%")
		local fperm = vim.fn.getfperm(fname);
  	return "%=" .. fperm .. " " -- Start aligning modules to the right.
  end
)

-- Show line and column position of the cursor.
local position = Module.new(
  function()
    if vim.bo.filetype == "alpha" then
      return ""
    end
    return " L%l C%c "
  end,
  {"CursorMoved"}
)

-- Define the order in which the modules should be displayed.
local modules = {
  mode,
  path,
  modified,
  diagnostics,
  permissions,
  position
}

-- Compile the states of each module into a single string to display
local compile = function()
  status = ""
  for k, mod in pairs(modules) do
    status = status .. mod.state
  end
  return status
end

-- Empty the state of all modules listed.
local reset = function()
  for k, mod in pairs(modules) do
    mod.state = ""
  end
end

-- Establish an autocommand group for the status line.
local augroup = vim.api.nvim_create_augroup('statusline', {clear = true})

-- For each module, attach an autocommand with its specific bindings.
for k, mod in pairs(modules) do
  if mod.events then
    vim.api.nvim_create_autocmd(mod.events, {
      callback = function()
        mod:exec()
        vim.opt.statusline = compile()
      end
    })
  end
end

-- Create an autocommand to wipe module state upon leaving a buffer or window.
vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
  callback = function()
    reset()
    vim.opt.statusline = compile()
  end
})
