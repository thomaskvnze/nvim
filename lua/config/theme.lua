-- ============================================================
-- Neovim theme settings
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'folke/tokyonight.nvim' }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}

vim.cmd.colorscheme 'tokyonight-night'
