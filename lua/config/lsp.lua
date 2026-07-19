-- ============================================================
-- Language Servers
-- ============================================================
local helper = require 'config.helper'

-- Useful status updates for LSP.
vim.pack.add { helper.gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.

    vim.keymap.set({ 'n', 'v' }, '<leader>cr', vim.lsp.buf.rename, { buffer = event.buf, desc = '[R]ename' })

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'Code [A]ction' })

    -- Run the code lens action under (or above) your cursor.
    vim.keymap.set({ 'n', 'x' }, '<leader>cl', vim.lsp.codelens.run, { buffer = event.buf, desc = 'Code [L]ens Action' })

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      vim.keymap.set(
        { 'n' },
        '<leader>ch',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
        { buffer = event.buf, desc = 'Toggle Inlay [H]ints' }
      )
    end
  end,
})

-- ============================================================
-- Adding language servers to vim.lsp
-- ============================================================

vim.pack.add {
  helper.gh 'neovim/nvim-lspconfig',
  helper.gh 'b0o/SchemaStore.nvim',
}

-- Formatting is owned by conform (see config.formatting); stop language servers
-- from advertising formatting so there is a single source of truth.
local function disable_lsp_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnusedImport = 'none', -- F401
            reportUnusedVariable = 'none', -- F841
            reportUnusedExpression = 'none', -- B018
            reportUndefinedVariable = 'none', -- F821
            reportUnboundVariable = 'none', -- F823
            reportRedeclaration = 'none', -- F811
            reportUnsupportedDunderAll = 'none', -- F822
            reportWildcardImportFromLibrary = 'none', -- F403/F405
            reportAssertAlwaysTrue = 'none', -- F631
            reportInvalidStringEscapeSequence = 'none', -- W605
            reportSelfClsParameterName = 'none', -- N804/N805
            -- keep reportPossiblyUnbound ON — ruff is weaker here
          },
        },
        disableOrganizeImports = true,
      },
    },
  },
  biome = {
    on_init = disable_lsp_formatting,
    -- json/jsonc linting is owned by jsonls; keep biome off those filetypes so
    -- there is a single diagnostics source. JS/TS(X) linting is owned by vtsls.
    -- (Default biome filetypes minus json/jsonc and javascript/typescript(react).)
    filetypes = {
      'astro',
      'css',
      'graphql',
      'svelte',
      'vue',
    },
  },
  jsonls = {},
  cmake = {},
  clangd = {
    filetypes = { 'c', 'cpp' },
  },
  sourcekit = {
    filetypes = { 'swift', 'objc', 'objcpp' },
  },
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

      if client.workspace_folders then local path = client.workspace_folders[1].name end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      },
    },
  },
  terraformls = {},
  vtsls = {
    -- conform (biome) owns formatting; vtsls owns lint diagnostics for JS/TS(X).
    on_init = disable_lsp_formatting,
  },
  ruff = {
    on_attach = function(client, _) client.server_capabilities.hoverProvider = false end,
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
