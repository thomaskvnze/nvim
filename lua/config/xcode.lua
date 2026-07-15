-- ============================================================
-- Xcodebuild configuration to enable macos and ios development
-- Lazy-loaded: only activates when the current directory (or an
-- ancestor of the current file) contains an .xcodeproj/.xcworkspace
-- ============================================================

local helper = require 'config.helper'

-- Install and configure the plugin. Guarded so it only runs once; a plugin
-- cannot be unloaded, so this stays loaded for the rest of the session even
-- if the keymaps are later detached.

vim.pack.add {
  { src = helper.gh 'wojciech-kulik/xcodebuild.nvim' },
  { src = helper.gh 'MunifTanjim/nui.nvim' },
}

require('xcodebuild').setup {
  integrations = {
    codelldb = {
      enabled = true,
      codelldb_path = vim.fn.expand '~/.local/share/codelldb/adapter/codelldb',
      -- lldb_lib_path defaults to Xcode's LLDB.framework; port defaults to 13000
    },
  },
}

-- ============================================================
-- Keymaps (under the [X]code which-key group)
-- Attached only while the current buffer / cwd is inside an Xcode
-- project, and removed again when it no longer is.
-- ============================================================
local xcodebuild_integrations_dap = require 'xcodebuild.integrations.dap'

-- Register the nvim-dap adapter and populate `dap.configurations.swift`.
-- require('xcodebuild').setup{} above only configures the plugin; it does NOT
-- wire up nvim-dap. Without this call, `debugger.set_implementation` never runs,
-- so the swift launch config is an empty table with `type = nil` -> nvim-dap
-- reports "references adapter nil. Available: codelldb".
xcodebuild_integrations_dap.setup()

local xcode_keymaps = {
  { 'n', '<leader>X', '<cmd>XcodebuildPicker<cr>', 'Show Xcodebuild Actions' },
  { 'n', '<leader>xf', '<cmd>XcodebuildProjectManager<cr>', 'Show Project Manager Actions' },

  { 'n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', 'Build Project' },
  { 'n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', 'Build For Testing' },
  { 'n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', 'Build & Run Project' },

  { 'n', '<leader>xt', '<cmd>XcodebuildTest<cr>', 'Run Tests' },
  { 'v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', 'Run Selected Tests' },
  { 'n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', 'Run Current Test Class' },
  { 'n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', 'Repeat Last Test Run' },

  { 'n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', 'Toggle Xcodebuild Logs' },
  { 'n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', 'Toggle Code Coverage' },
  { 'n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', 'Show Code Coverage Report' },
  { 'n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', 'Toggle Test Explorer' },
  { 'n', '<leader>xs', '<cmd>XcodebuildFailingSnapshots<cr>', 'Show Failing Snapshots' },

  { 'n', '<leader>xp', '<cmd>XcodebuildPreviewGenerateAndShow<cr>', 'Generate Preview' },
  { 'n', '<leader>x<cr>', '<cmd>XcodebuildPreviewToggle<cr>', 'Toggle Preview' },

  { 'n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', 'Select Device' },
  { 'n', '<leader>xq', '<cmd>Telescope quickfix<cr>', 'Show QuickFix List' },

  { 'n', '<leader>xx', '<cmd>XcodebuildQuickfixLine<cr>', 'Quickfix Line' },
  { 'n', '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', 'Show Code Actions' },

  { 'n', '<leader>dd', function() xcodebuild_integrations_dap.build_and_debug() end, 'Build & [D]ebug' },
  { 'n', '<leader>dc', function() xcodebuild_integrations_dap.debug_without_build() end, '[C]ontinue / Start' },
  { 'n', '<leader>dT', function() xcodebuild_integrations_dap.debug_tests() end, 'Debug [T]ests' },
  { 'n', '<leader>dC', function() xcodebuild_integrations_dap.debug_class_tests() end, 'Debug [C]lass Tests' },
  { 'n', '<leader>dB', function() xcodebuild_integrations_dap.toggle_message_breakpoint() end, 'Toggle Message [B]reakpoint' },

  {
    'n',
    '<leader>db',
    function() xcodebuild_integrations_dap.toggle_breakpoint() end,
    'Toggle [B]reakpoint',
  },
  {
    'n',
    '<leader>dt',
    function() xcodebuild_integrations_dap.terminate_session() end,
    '[T]erminate',
  },
}

local keymaps_attached = false

local function attach_xcode_keymaps()
  if keymaps_attached then return end
  keymaps_attached = true
  require('which-key').add { { '<leader>x', group = '[X]code', mode = 'n' } }
  for _, m in ipairs(xcode_keymaps) do
    vim.keymap.set(m[1], m[2], m[3], { desc = m[4] })
  end
end

local function detach_xcode_keymaps()
  if not keymaps_attached then return end
  keymaps_attached = false
  -- With no child keymaps left, which-key prunes the now-empty [X]code group.
  for _, m in ipairs(xcode_keymaps) do
    if m[5] then
      -- Overlaps a dap.lua global: restore that mapping instead of deleting it.
      vim.keymap.set(m[1], m[2], m[5][1], { desc = m[5][2] })
    else
      vim.keymap.del(m[1], m[2])
    end
  end
end

-- Search the given path and its ancestors for an Xcode project/workspace bundle.
local function has_xcode_project(path)
  if not path or path == '' then return false end
  local found = vim.fs.find(
    function(name) return name:match '%.xcodeproj$' ~= nil or name:match '%.xcworkspace$' ~= nil end,
    { upward = true, path = path, type = 'directory', limit = 1 }
  )
  return #found > 0
end

-- Attach/detach purely based on the cwd: opening a file from an unrelated
-- cwd should not pull in the Xcode keymaps.
local function sync_xcode_keymaps()
  if has_xcode_project(vim.fn.getcwd()) then
    attach_xcode_keymaps()
  else
    detach_xcode_keymaps()
  end
end

local group = vim.api.nvim_create_augroup('XcodebuildLazy', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  group = group,
  desc = 'Attach/detach Xcode keymaps as the cwd enters/leaves an Xcode project',
  callback = sync_xcode_keymaps,
})

-- Handle the case where the config loads after VimEnter has already fired.
sync_xcode_keymaps()
