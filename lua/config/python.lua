-- ============================================================
-- Python specific configuration
-- ============================================================

-- ============================================================
-- Debug keymaps (under the existing [D]ebug which-key group)
-- Attached only while Neovim's cwd is inside a Python project and
-- removed again when you :cd out of it. The dap-python plugin itself
-- is loaded/configured in config.dap.
-- ============================================================
local dap_python = require 'dap-python'

local python_keymaps = {
  { '<leader>dm', dap_python.test_method, 'Test [M]ethod' },
  { '<leader>dC', dap_python.test_class, 'Test [C]lass' },
}

local keymaps_attached = false

local function attach_python_keymaps()
  if keymaps_attached then return end
  keymaps_attached = true
  for _, m in ipairs(python_keymaps) do
    vim.keymap.set('n', m[1], m[2], { desc = m[3] })
  end
end

local function detach_python_keymaps()
  if not keymaps_attached then return end
  keymaps_attached = false
  for _, m in ipairs(python_keymaps) do
    vim.keymap.del('n', m[1])
  end
end

-- Detect a Python project by common project markers at or above the cwd.
local python_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile' }

local function sync_python_keymaps()
  if vim.fs.root(vim.uv.cwd(), python_markers) ~= nil then
    attach_python_keymaps()
  else
    detach_python_keymaps()
  end
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  group = vim.api.nvim_create_augroup('dap-python-keymaps', { clear = true }),
  desc = 'Attach/detach Python debug keymaps as the cwd enters/leaves a Python project',
  callback = sync_python_keymaps,
})

sync_python_keymaps()
