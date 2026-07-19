-- ============================================================
-- Filebrowser to explore current working directory
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'stevearc/oil.nvim' }

require('oil').setup {}

vim.keymap.set('n', '<leader>vf', '<CMD>Oil<CR>', { desc = '[F]ile browser' })
