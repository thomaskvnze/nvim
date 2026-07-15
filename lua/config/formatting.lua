-- ============================================================
-- Additional formatting functionality beyond the lsp formatter
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      lua = true,
      python = true,
      c = true,
      cpp = true,
      objc = true,
      objcpp = true,
      cuda = true,
      swift = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    cuda = { 'clang_format' },
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
    lua = { 'stylua' },
    objc = { 'clang_format' },
    objcpp = { 'clang_format' },
    python = { 'ruff_format', 'ruff_fix' },
    swift = { 'swift_format' },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
