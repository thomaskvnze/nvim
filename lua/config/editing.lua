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
-- Undo tree (Neovim 0.12 builtin plugin)
-- ============================================================
vim.cmd.packadd 'nvim.undotree'
vim.keymap.set('n', '<leader>vu', function() require('undotree').open { command = '55vnew' } end, { desc = '[U]ndo Tree' })

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
require('mini.surround').setup {
  mappings = {
    add = '<leader>csa', -- Add surrounding in Normal and Visual modes
    delete = '<leader>csd', -- Delete surrounding
    find = '<leader>csf', -- Find surrounding (to the right)
    find_left = '<leader>csF', -- Find surrounding (to the left)
    highlight = '<leader>csh', -- Highlight surrounding
    replace = '<leader>csr', -- Replace surrounding
    update_n_lines = '<leader>csn', -- Update `n_lines`
  },
}

-- ============================================================
-- Advanced cursor navigation
-- ============================================================
vim.pack.add {
  { src = helper.gh 'folke/flash.nvim' },
}

require('flash').setup {}
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
vim.keymap.set({ 'o' }, 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
vim.keymap.set({ 'c' }, '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
