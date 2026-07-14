-- ============================================================
-- Filebrowser to explore current working directory
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'stevearc/oil.nvim' }

require('oil').setup({})

vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open file browser"})
