-- ============================================================
-- Testing capabilities inside neovim
-- ============================================================

local helper = require 'config.helper'

vim.pack.add {
  { src = helper.gh 'nvim-neotest/nvim-nio' },
  { src = helper.gh 'nvim-neotest/neotest' },
  { src = helper.gh 'nvim-neotest/neotest-python' },
}

local neotest = require 'neotest'
---@diagnostic disable-next-line: missing-fields
neotest.setup {
  adapters = {
    require 'neotest-python' {
      dap = {
        justMyCode = false,
      },
      runner = 'pytest',
    },
  },
}

vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = 'Test Current [F]ile' })
vim.keymap.set('n', '<leader>tp', neotest.run.run, { desc = 'Test Current [P]osition' })
vim.keymap.set('n', '<leader>tl', neotest.run.run_last, { desc = 'Test [L]ast Position' })
vim.keymap.set('n', '<leader>to', neotest.output_panel.toggle, { desc = 'Toggle [O]utput Panel' })
vim.keymap.set('n', '<leader>tc', neotest.output_panel.clear, { desc = '[C]lear Output Panel' })
vim.keymap.set('n', '<leader>twf', function() neotest.watch.toggle(vim.fn.expand '%') end, { desc = 'Watch Current [F]ile' })
vim.keymap.set('n', '<leader>twp', neotest.watch.toggle, { desc = 'Watch Current [P]osition' })
vim.keymap.set('n', '<leader>tws', neotest.watch.stop, { desc = '[S]top Watching Position or All' })
vim.keymap.set('n', '<leader>ts', neotest.summary.toggle, { desc = 'Toggle [S]Summary' })
