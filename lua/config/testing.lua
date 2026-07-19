-- ============================================================
-- Testing capabilities inside neovim
-- ============================================================

local helper = require 'config.helper'

vim.pack.add {
  { src = helper.gh 'nvim-neotest/nvim-nio' },
  { src = helper.gh 'nvim-neotest/neotest' },
  { src = helper.gh 'nvim-neotest/neotest-python' },
  { src = helper.gh 'orjangj/neotest-ctest' },
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
    require 'rustaceanvim.neotest',
    require('neotest-ctest').setup {
      -- Name of the nvim-dap adapter to use for debugging.
      -- Must match the adapter name registered in nvim-dap.
      -- Common values: "codelldb", "cppdbg"
      dap_adapter = 'codelldb',
    },
  },
}

vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = 'Test Current [F]ile' })
vim.keymap.set('n', '<leader>ta', neotest.summary.toggle, { desc = '[A]ll' })
vim.keymap.set('n', '<leader>tp', neotest.run.run, { desc = 'Current [P]osition' })
vim.keymap.set('n', '<leader>tl', neotest.run.run_last, { desc = '[L]ast Position' })
vim.keymap.set('n', '<leader>vt', neotest.output_panel.toggle, { desc = '[T]est Output' })
vim.keymap.set('n', '<leader>tc', neotest.output_panel.clear, { desc = '[C]lear Output' })
vim.keymap.set('n', '<leader>twf', function() neotest.watch.toggle(vim.fn.expand '%') end, { desc = 'Current [F]ile' })
vim.keymap.set('n', '<leader>twp', neotest.watch.toggle, { desc = 'Current [P]osition' })
vim.keymap.set('n', '<leader>tws', neotest.watch.stop, { desc = '[S]top Watching Position or All' })
vim.keymap.set('n', '<leader>vT', neotest.summary.toggle, { desc = '[T]est Summary' })
