-- ============================================================
-- Task Runnner and Job Manager
-- ============================================================
local helper = require 'config.helper'

vim.pack.add { helper.gh 'stevearc/overseer.nvim' }

require('overseer').setup()
