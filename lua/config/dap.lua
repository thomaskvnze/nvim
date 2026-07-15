-- ============================================================
-- Debug Adapter Protocol Client
-- ============================================================

local helper = require 'config.helper'

vim.pack.add {
  { src = helper.gh 'mfussenegger/nvim-dap' },
  { src = helper.gh 'nvim-neotest/nvim-nio' },
  { src = helper.gh 'rcarriga/nvim-dap-ui' },
  { src = helper.gh 'theHamsta/nvim-dap-virtual-text' },
  { src = helper.gh 'mfussenegger/nvim-dap-python' },
}

local dap = require 'dap'
local dapui = require 'dapui'

---@diagnostic disable-next-line: missing-fields
dapui.setup {}
require('nvim-dap-virtual-text').setup {}

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.expand '~/.local/share/codelldb/adapter/codelldb',
    args = { '--port', '${port}' },
  },
}

require('dap-python').setup 'uv'

-- Signs shown in the gutter
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticWarn', linehl = 'Visual' })

-- Auto open/close the UI with a debug session
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
-- dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
-- dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- ============================================================
-- Keymaps (<leader>d group)
-- ============================================================
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input 'Condition: ') end, { desc = 'Conditional [B]reakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[C]ontinue / Start' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step [I]nto' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step [O]ver' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step [O]ut' })
vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Toggle [R]EPL' })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Run [L]ast' })
vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[T]erminate' })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle [U]I' })
vim.keymap.set('n', '<leader>de', function() dapui.eval(nil, { enter = true }) end, { desc = '[E]val expression' })
