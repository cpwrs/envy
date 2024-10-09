-- All LSP configurations.

local lspconfig = require('lspconfig')
local methods = vim.lsp.protocol.Methods

-- Set up language servers with lspconfig defaults.
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } }
    }
  }
})
lspconfig.pyright.setup({})
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})

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
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  underline = true,
})

-- Global mappings
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Set up LSP keymaps and  autocommands for the given buffer.
local function on_attach(client, bufnr)
  local function keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts }
           or vim.tbl_extend('error', opts, { buffer = bufnr })
    mode = mode or 'n'
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Replacing certain <C-x>... keymaps.
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
  end

  -- Check if the completion menu is open.
  local function pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
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
  keymap('<leader>d', vim.lsp.buf.type_definition, "Go to the type definiton")

  keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  keymap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")

  -- Enable insert mode completion.
  if client.supports_method(methods.textDocument_completion) then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    -- Use enter to accept completions.
    keymap('<cr>', function()
      return pumvisible() and '<C-y>' or '<cr>'
    end, { expr = true }, 'i')

    -- Use slash to dismiss the completion menu.
    keymap('/', function()
      return pumvisible() and '<C-e>' or '/'
    end, { expr = true }, 'i')

    -- Use <C-n> to navigate to the next completion or:
    -- - Trigger LSP completion.
    -- - If there's no one, fallback to vanilla omnifunc.
    keymap('<C-n>', function()
      if pumvisible() then
        feedkeys '<C-n>'
      else
        if next(vim.lsp.get_clients { bufnr = 0 }) then
          vim.lsp.completion.trigger()
        else
          if vim.bo.omnifunc == '' then
            feedkeys('<C-x><C-n>')
          else
            feedkeys('<C-x><C-o>')
          end
        end
      end
    end, "Trigger/select next completion", 'i')
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Configure LSP keymaps",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, args.buf)
  end,
})
