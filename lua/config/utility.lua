-- ============================================================
-- All configurations about the editing area
-- ============================================================

local helper = require('config.helper')

-- Highlight todo, notes, etc in comments
vim.pack.add { helper.gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }
