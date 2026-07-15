-- ============================================================
-- Keymaps for functions that are n ovim standard and don't have a dedicateed config file
-- ============================================================
local helper = require 'config.helper'

-- ============================================================
-- Whichkey - plugin to show keymaps while tyiping
-- ============================================================
vim.pack.add { helper.gh 'folke/which-key.nvim' }

require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>b', group = '[B]uffer', mode = { 'n' } },
    { '<leader>d', group = '[D]ebug', mode = { 'n' } },
    { '<leader>e', group = '[E]ditor', mode = { 'n' } },
    { '<leader>f', group = '[F]ind', mode = { 'n', 'v' } },
    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
    { '<leader>gf', group = '[F]ind', mode = { 'n', 'v' } },
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]est', mode = { 'n' } },
    { '<leader>tw', group = '[W]atch', mode = { 'n' } },
    { '<leader>u', group = '[U]tility', mode = { 'n' } },
    -- '<leader>x' [X]code group is registered dynamically in config/xcode.lua
  },
}

-- ============================================================
-- Keymaps for standard neovim functions
-- ============================================================

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
