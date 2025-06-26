-- Enable LSPs, configure diagnostics, and set LSP keymaps

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "clangd",
  "rust_analyzer",
  "nixd",
  "denols",
  "gopls",
  "ts_ls",
  "svelte"
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        ignoreDir = { ".direnv", ".git", ".direnv/flake-inputs", "dist", "build", "result", "flake.nix", "node_modules", "flake.lock" }
      },
    },
  },
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})

-- Configure diagnostics.
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    },
  },
  severity_sort = true,
  underline = true,
})

-- Global mappings
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })
vim.keymap.set('n', '<leader>d', function ()
  local new = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new })
end, { desc = "Toggle diagnostic virtual_lines" })

local methods = vim.lsp.protocol.Methods
-- Set up LSP keymaps and  autocommands for the given buffer.
local function on_attach(client, bufnr)
  local function keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts }
    or vim.tbl_extend('error', opts, { buffer = bufnr })
    mode = mode or 'n'
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Set up general keybinds.
  if client.supports_method(methods.textDocument_inlayHint) then
    keymap('<leader>h', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle inlay hints")
  end

  keymap('gf', function()
    vim.lsp.buf.format { async = true }
  end, "Format buffer")

  keymap('gD', vim.lsp.buf.declaration, "Go to declaration")
  keymap('gd', vim.lsp.buf.definition, "Go to definiton")
  keymap('gi', vim.lsp.buf.implementation, "Go to implementation")
  keymap('<C-k>', vim.lsp.buf.signature_help, "Signature help", 'i')

  keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  keymap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Configure LSP keymaps",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, args.buf)
  end,
})
