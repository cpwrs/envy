-- A component holds the state for a dynamic part of the statusline
-- It is a table whos first element is a function returning a string (text to display)
-- and second element is an optional list of strings (neovim autocmd events)
local components = {}

-- Translations for the mode component.
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
components.mode = {
  function()
    local mode = translate_mode[vim.api.nvim_get_mode().mode]
    if mode == nil then mode = "Mode" end
    return string.format(" %s", mode)
  end,
  { "ModeChanged" }
}

-- Show the file path, relative to the project root dir.
components.path = {
  function()
    -- Messy code to make the tail of the path a different highlight
    local name = vim.fn.expand("%:t")
    local relpath = string.gsub(vim.fn.expand("%"), vim.loop.cwd(), '')
    local relnotail = string.gsub(relpath, name, '')

    local path = "%#StatusOther#" .. relnotail .. "%*" .. name
    return path
  end
}

-- Indicator that the buffer has been modified.
components.modified = {
  function()
    if vim.bo.modified then
      return "+"
    end
    return ""
  end,
  { "BufModifiedSet" }
}

-- Severities and their associated hl for the diagnostics component.
local severities = {
  [vim.diagnostic.severity.ERROR] = "%#StatusError#",
  [vim.diagnostic.severity.WARN] = "%#StatusWarn#",
  [vim.diagnostic.severity.INFO] = "%#StatusInfo#",
  [vim.diagnostic.severity.HINT] = "%#StatusHint#",
}

-- Display diagnostic count by severity.
components.diagnostics = {
  function()
    local diags = ""
    for sev, hl in pairs(severities) do
      local count = #vim.diagnostic.get(0, { severity = sev })
      if count ~= 0 then
        diags = diags .. hl .. count .. "%#StatusOther#,%*"
      end
    end

    if diags ~= "" then
      diags = "%#StatusOther#[%*" .. string.sub(diags, 1, -4) .. "]%*"
    end
    return diags
  end,
  { "DiagnosticChanged" }
}

components.lsp = {
  function()
    local lsp = ""
    local clients = vim.lsp.get_clients({bufnr = 0})

    if next(clients) ~= nil then
      for _, client in pairs(clients) do
        lsp = lsp .. client.name
      end
    end

    return " " .. lsp
  end,
  { "LspAttach", "LspDetach" }
}

-- Show file permissions.
components.permissions = {
  function()
    local fpath = vim.fn.expand("%")
    local fperm = vim.fn.getfperm(fpath)

    if fperm ~= "" then
      return " %#StatusOther#(%*" .. fperm .. "%#StatusOther#)%* "
    else
      return " "
    end
  end
}

-- Show line and column position of the cursor.
components.position = {
  function()
    if vim.bo.filetype == "alpha" then
      return ""
    end
    return " %l%#StatusOther#:%*%c"
  end,
  { "CursorMoved" }
}

return components
