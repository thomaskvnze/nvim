-- ============================================================
-- All configurations about the editing area
-- ============================================================

local helper = require 'config.helper'

-- Highlight todo, notes, etc in comments
vim.pack.add { helper.gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- ============================================================
-- Mini.statusline - statusline styling
-- ============================================================
vim.pack.add({
  { src = helper.gh 'nvim-mini/mini.statusline', version = 'stable' },
})
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end

-- ============================================================
-- Mini.ai - enhanced a and i commands 
-- ============================================================
vim.pack.add({
  { src = helper.gh 'nvim-mini/mini.ai', version = 'stable' },
})

require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- ============================================================
-- Mini.surround - enhanced surround commands
-- ============================================================
vim.pack.add({
  { src = helper.gh 'nvim-mini/mini.surround', version = 'stable' },
})
require('mini.surround').setup()
