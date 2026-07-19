-- ============================================================
-- Diagnostics settings and keymaps
-- ============================================================

local helper = require 'config.helper'
-- ============================================================
--
-- Trouble - a pretty list for diagnostic, references, quickfix
-- and location lists
-- ============================================================
vim.pack.add {
  { src = helper.gh 'folke/trouble.nvim', version = 'main' },
}

require('trouble').setup {}

-- Trouble keymaps (<leader>v = [V]iew group, see config.keymaps)
vim.keymap.set('n', '<leader>vd', '<cmd>Trouble diagnostics toggle<cr>', { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>vD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer [D]iagnostics' })
vim.keymap.set('n', '<leader>vs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = '[S]ymbols' })
vim.keymap.set('n', '<leader>vr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = '[R]eferences / Declarations / Definitions' })
vim.keymap.set('n', '<leader>vl', '<cmd>Trouble loclist toggle<cr>', { desc = '[L]ocation List' })
vim.keymap.set('n', '<leader>vq', '<cmd>Trouble qflist toggle<cr>', { desc = '[Q]uickfix List' })

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}
