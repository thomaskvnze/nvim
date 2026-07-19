-- ============================================================
-- formatting functionality beyond the lsp formatter
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
      css = true,
      cuda = true,
      html = true,
      javascript = true,
      javascriptreact = true,
      json = true,
      jsonc = true,
      objc = true,
      objcpp = true,
      rust = true,
      swift = true,
      tf = true,
      ['terraform-vars'] = true,
      terraform = true,
      typescript = true,
      typescriptreact = true,
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
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    css = { 'biome' },
    cuda = { 'clang-format' },
    html = { 'biome' },
    javascript = { 'biome' },
    javascriptreact = { 'biome' },
    lua = { 'stylua' },
    objc = { 'clang-format' },
    objcpp = { 'clang-format' },
    python = { 'ruff_format', 'ruff_fix' },
    rust = { 'rustfmt' },
    swift = { 'swift' },
    terraform = { 'terraform_fmt' },
    tf = { 'terraform_fmt' },
    ['terraform-vars'] = { 'terraform_fmt' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
