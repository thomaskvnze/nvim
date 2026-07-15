-- ============================================================
-- Debug Adapter Protocol Client
-- ============================================================

local helper = require 'config.helper'

-- ============================================================
-- Guess indent options for file
-- ============================================================
vim.pack.add { helper.gh 'mfussenegger/nvim-dap' }
-- vim.pack.add { helper.gh 'rcarriga/nvim-dap-ui' }
require('nvim-dap').setup {}
