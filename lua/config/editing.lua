-- ============================================================
-- All configurations about the editing area
-- ============================================================

local helper = require 'config.helper'

-- ============================================================
-- Guess indent options for file
-- ============================================================
vim.pack.add { helper.gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- ============================================================
-- Highlighting for notes and todos in comments
-- ============================================================
vim.pack.add { helper.gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- ============================================================
-- Statusline Styling
-- ============================================================
-- vim.pack.add {
--   { src = helper.gh 'nvim-mini/mini.statusline', version = 'stable' },
-- }
-- local statusline = require 'mini.statusline'
-- statusline.setup { use_icons = vim.g.have_nerd_font }
-- ---@diagnostic disable-next-line: duplicate-set-field
-- statusline.section_location = function() return '%2l:%-2v' end
vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}
require('lualine').setup {
  options = { theme = 'auto' },
}

-- ============================================================
-- Enhanced a and i commands
-- ============================================================
vim.pack.add {
  { src = helper.gh 'nvim-mini/mini.ai', version = 'stable' },
}

require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- ============================================================
-- Enhanced Surround Commands
-- ============================================================
vim.pack.add {
  { src = helper.gh 'nvim-mini/mini.surround', version = 'stable' },
}
require('mini.surround').setup()
