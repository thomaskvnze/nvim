-- ============================================================
-- Keymaps for functions that are n ovim standard and don't have a dedicateed config file
-- ============================================================
local helper = require 'config.helper'

-- ============================================================
-- Whichkey - plugin to show keymaps while tyiping
-- ============================================================
vim.pack.add { helper.gh 'folke/which-key.nvim' }

require('which-key').setup {
  preset = 'helix',
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { 'a', group = '[A]round', mode = { 'n', 'v' } },
    { 'g', group = '[G]oto', mode = { 'n', 'v' } },
    { 'ga', group = '[A]ll Calls', mode = { 'n' } },
    { 's', group = '[S]urround', mode = { 'n', 'v' } },
    { 'z', group = '[Z]Fold', mode = { 'n', 'v' } },
    { '<leader>b', group = '[B]uffer', mode = { 'n' } },
    { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
    { '<leader>d', group = '[D]ebug', mode = { 'n' } },
    { '<leader>e', group = '[E]ditor', mode = { 'n' } },
    { '<leader>f', group = '[F]ind', mode = { 'n', 'v' } },
    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
    { '<leader>gf', group = '[F]ind', mode = { 'n', 'v' } },
    { '<leader>r', group = '[R]ust', mode = { 'n', 'x' } },
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]est', mode = { 'n' } },
    { '<leader>tw', group = '[W]atch', mode = { 'n' } },
    { '<leader>u', group = '[U]tility', mode = { 'n' } },
    { '[', group = '[ - Previous', mode = { 'n' } },
    { ']', group = '] - Next', mode = { 'n' } },
    -- Hide the disabled `gw` format operator from the popup
    { 'gw', hidden = true, mode = { 'n', 'x' } },
    -- Hide the built-in comment operators from the popup (see `<leader>cc`)
    { 'gc', hidden = true, mode = { 'n', 'x' } },
    { 'gcc', hidden = true, mode = { 'n' } },
    -- Hide the disabled built-in LSP defaults from the popup
    { 'gO', hidden = true, mode = { 'n' } },
    { 'grn', hidden = true, mode = { 'n' } },
    { 'gra', hidden = true, mode = { 'n', 'x' } },
    { 'grr', hidden = true, mode = { 'n' } },
    { 'gri', hidden = true, mode = { 'n' } },
    { 'grt', hidden = true, mode = { 'n' } },
    { 'grx', hidden = true, mode = { 'n', 'x' } },
  },
}

-- ============================================================
-- Keymaps for standard neovim functions
-- ============================================================

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Comment toggling under the [C]ode group (wraps the built-in `gcc`/`gc`)
vim.keymap.set('n', '<leader>cc', 'gcc', { remap = true, desc = '[C]omment toggle line' })
vim.keymap.set('x', '<leader>cc', 'gc', { remap = true, desc = '[C]omment toggle selection' })

-- Disable the default `gw` format operator
vim.keymap.set({ 'n', 'x' }, 'gw', '<Nop>')

-- Disable the built-in Neovim LSP defaults (this config provides its own):
--   gO  -> document symbols (see `<leader>ss`)
--   grn -> rename           (see `<leader>cr`)
--   gra -> code action      (see `<leader>ca`)
--   grr -> references       (see `gr`)
--   gri -> implementation   (see `gI`)
--   grt -> type definition  (see `gy`)
--   grx -> code lens action (see `<leader>cl`)
vim.keymap.set('n', 'gO', '<Nop>')
vim.keymap.set('n', 'grn', '<Nop>')
vim.keymap.set({ 'n', 'x' }, 'gra', '<Nop>')
vim.keymap.set('n', 'grr', '<Nop>')
vim.keymap.set('n', 'gri', '<Nop>')
vim.keymap.set('n', 'grt', '<Nop>')
vim.keymap.set({ 'n', 'x' }, 'grx', '<Nop>')

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
