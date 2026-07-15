-- ============================================================
-- Git related configurations
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage Hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset Hunk' })

    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[S]tage Hunk' })

    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[R]eset Hunk' })

    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage Buffer' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset Buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review Hunk' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview Hunk [I]nline' })

    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = '[B]lame Line' })

    map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff against index' })

    map('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = '[D]iff against last commit' })

    map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'View All in [Q]uicklist' })
    map('n', '<leader>hq', gitsigns.setqflist, { desc = 'View Buffer In [Q]uicklist' })

    -- Toggles
    map('n', '<leader>hB', gitsigns.blame)
    map('n', '<leader>hw', gitsigns.toggle_word_diff)

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end,
}
