-- Define some modules for the line.

local Module = require('statusline/module')
local LibModule = {}

-- Helper data for the diagnostics module.
local diag_data = {
  {severity = vim.diagnostic.severity.ERROR, hl = "%#LineError#", display = "*"},
  {severity = vim.diagnostic.severity.WARN, hl = "%#LineWarn#", display = "!"},
  {severity = vim.diagnostic.severity.INFO, hl = "%#LineInfo#", display = "i"},
  {severity = vim.diagnostic.severity.HINT, hl = "%#LineHint#", display = "?"},
}

-- Translator table for the mode module.
local translate_mode = {
  ["n"] = "Norm",
  ["no"] = "Norm",
  ["v"] = "Visl",
  ["V"] = "Visl",
  [""] = "Visl",
  ["s"] = "Slct",
  ["S"] = "Slct",
  [""] = "Slct",
  ["i"] = "Nsrt",
  ["ic"] = "Nsrt",
  ["R"] = "Rplc",
  ["Rv"] = "Rplc",
  ["c"] = "Cmnd",
  ["r"] = "Prmt",
  ["rm"] = "More",
  ["r?"] = "Cfrm",
  ["!"] = "Shll",
  ["t"] = "Term",
}

-- Show the editing mode.
LibModule.mode = Module.new(
  function()
    local mode = translate_mode[vim.api.nvim_get_mode().mode]
    if mode == nil then mode = "Mode" end
    return string.format(" %s", mode)
  end,
  {"ModeChanged"}
)

-- Show the file path, relative to the project root dir.
LibModule.path = Module.new(
  function()
    local fname = vim.fn.expand("%")
    local fpath = " " .. string.gsub(fname, vim.loop.cwd(), '')
    return fpath
  end
)

-- Indicator that the buffer has been modified.
LibModule.modified = Module.new(
  function()
    if vim.bo.modified then
      return " [+]"
    end
    return ""
  end,
  {"BufModifiedSet"}
)

-- Display diagnostic count by severity.
LibModule.diagnostics = Module.new(
  function()
    local status = ""
    for _, data in pairs(diag_data) do
      local count = vim.tbl_count(vim.diagnostic.get(0, {severity = data.severity}))
      if count ~= 0 then
        status = status .. data.hl .. count .. data.display .. " "
      end
    end

    if status ~= "" then
      status = "(" .. string.sub(status, 0, -2) .. "%#LineNormal#) "
    else
      status = " "
    end

    return status
  end,
  {"DiagnosticChanged"}
)

LibModule.lsp = Module.new(
  function()
    local lsp = ""
    local clients = vim.lsp.get_clients()

    if next(clients) == nil then
      lsp = ""
    else
      for _, client in pairs(clients) do
        lsp = lsp .. client.name
      end
    end

    return lsp
  end,
  {"LspAttach", "LspDetach"}
)

-- Show file permissions.
LibModule.permissions = Module.new(
  function()
		local fname = vim.fn.expand("%")
		local fperm = " " .. vim.fn.getfperm(fname)
  	return fperm
  end
)

-- Show line and column position of the cursor.
LibModule.position = Module.new(
  function()
    if vim.bo.filetype == "alpha" then
      return ""
    end
    return " %l,%c"
  end,
  {"CursorMoved"}
)

LibModule.size = Module.new(
  function()
    local fname = vim.fn.expand("%")
    local fsize = vim.fn.getfsize(fname)
    local size_string = ""

    if (fsize == -1) or (fsize == -2) then
      size_string = ""
    else
      size_string = " " .. fsize .. "B"
    end

    return size_string
  end
)

return LibModule
