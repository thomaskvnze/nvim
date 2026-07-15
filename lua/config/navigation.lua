-- ============================================================
-- Fuzzy finder and navigation tools
-- ============================================================

local helper = require 'config.helper'

vim.pack.add {
  { src = helper.gh 'folke/snacks.nvim' },
  { src = helper.gh 'nvim-mini/mini.icons', version = 'stable' },
}

local snacks = require 'snacks'

snacks.setup {
  bigfile = { enabled = false },
  dashboard = { enabled = false },
  indent = { enabled = false },
  input = { enabled = false },
  notifier = { enabled = false },
  picker = { enabled = true },
  quickfix = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  words = { enabled = false },
}

-- Top Pickers & Explorer
vim.keymap.set('n', '<leader><space>', function() snacks.picker.smart() end, { desc = 'Smart Find Files' })
vim.keymap.set('n', '<leader>,', function() snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function() snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>:', function() snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>n', function() snacks.picker.notifications() end, { desc = 'Notification History' })
vim.keymap.set('n', '<leader>e', function() snacks.explorer() end, { desc = 'File Explorer' })

-- find
vim.keymap.set('n', '<leader>fb', function() snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', function() snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find Config File' })
vim.keymap.set('n', '<leader>ff', function() snacks.picker.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', function() snacks.picker.git_files() end, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fp', function() snacks.picker.projects() end, { desc = 'Projects' })
vim.keymap.set('n', '<leader>fr', function() snacks.picker.recent() end, { desc = 'Recent' })

-- git
vim.keymap.set('n', '<leader>gfb', function() snacks.picker.git_branches() end, { desc = 'Git Branches' })
vim.keymap.set('n', '<leader>gfl', function() snacks.picker.git_log() end, { desc = 'Git Log' })
vim.keymap.set('n', '<leader>gfL', function() snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
vim.keymap.set('n', '<leader>gfs', function() snacks.picker.git_status() end, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gfS', function() snacks.picker.git_stash() end, { desc = 'Git Stash' })
vim.keymap.set('n', '<leader>gfd', function() snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
vim.keymap.set('n', '<leader>gff', function() snacks.picker.git_log_file() end, { desc = 'Git Log File' })

-- gh
vim.keymap.set('n', '<leader>gfi', function() snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
vim.keymap.set('n', '<leader>gfI', function() snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub Issues (all)' })
vim.keymap.set('n', '<leader>gfp', function() snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
vim.keymap.set('n', '<leader>gfP', function() snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub Pull Requests (all)' })

-- Grep
vim.keymap.set('n', '<leader>sB', function() snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
vim.keymap.set('n', '<leader>sg', function() snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() snacks.picker.grep_word() end, { desc = 'Visual selection or word' })

-- search
vim.keymap.set('n', '<leader>s"', function() snacks.picker.registers() end, { desc = 'Registers' })
vim.keymap.set('n', '<leader>s/', function() snacks.picker.search_history() end, { desc = 'Search History' })
vim.keymap.set('n', '<leader>sa', function() snacks.picker.autocmds() end, { desc = 'Autocmds' })
vim.keymap.set('n', '<leader>sb', function() snacks.picker.lines() end, { desc = 'Buffer Lines' })
vim.keymap.set('n', '<leader>sc', function() snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>sC', function() snacks.picker.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sd', function() snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sD', function() snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>sh', function() snacks.picker.help() end, { desc = 'Help Pages' })
vim.keymap.set('n', '<leader>sH', function() snacks.picker.highlights() end, { desc = 'Highlights' })
vim.keymap.set('n', '<leader>si', function() snacks.picker.icons() end, { desc = 'Icons' })
vim.keymap.set('n', '<leader>sj', function() snacks.picker.jumps() end, { desc = 'Jumps' })
vim.keymap.set('n', '<leader>sk', function() snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>sl', function() snacks.picker.loclist() end, { desc = 'Location List' })
vim.keymap.set('n', '<leader>sm', function() snacks.picker.marks() end, { desc = 'Marks' })
vim.keymap.set('n', '<leader>sM', function() snacks.picker.man() end, { desc = 'Man Pages' })
vim.keymap.set('n', '<leader>sp', function() snacks.picker.lazy() end, { desc = 'Search for Plugin Spec' })
vim.keymap.set('n', '<leader>sq', function() snacks.picker.qflist() end, { desc = 'Quickfix List' })
vim.keymap.set('n', '<leader>sR', function() snacks.picker.resume() end, { desc = 'Resume' })
vim.keymap.set('n', '<leader>su', function() snacks.picker.undo() end, { desc = 'Undo History' })
vim.keymap.set('n', '<leader>uC', function() snacks.picker.colorschemes() end, { desc = 'Colorschemes' })

-- Other
vim.keymap.set('n', '<leader>.', function() snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
vim.keymap.set('n', '<leader>S', function() snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
vim.keymap.set('n', '<leader>bd', function() snacks.bufdelete() end, { desc = '[D]elete Buffer' })
vim.keymap.set('n', '<leader>bR', function() snacks.rename.rename_file() end, { desc = '[R]ename File' })
vim.keymap.set({ 'n', 'v' }, '<leader>gB', function() snacks.gitbrowse() end, { desc = 'Open in [B]rowser' })
vim.keymap.set('n', '<leader>gg', function() snacks.lazygit() end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>un', function() snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
-- Terminal is handled by toggleterm (see config/terminal.lua)
vim.keymap.set({ 'n', 't' }, ']]', function() snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
vim.keymap.set({ 'n', 't' }, '[[', function() snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })

-- Help
vim.keymap.set('v', '<leader>h', function()
  local lines = vim.fn.getregion(
    vim.fn.getpos 'v', -- selection start (where you pressed v/V)
    vim.fn.getpos '.', -- cursor position (other end)
    { type = vim.fn.mode() }
  )
  local text = table.concat(lines, '\n')
  snacks.picker.help { pattern = text }
end)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('snacks-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    vim.keymap.set({ 'n', 'x' }, 'gla', function() snacks.picker.pick 'code_actions' end, { buffer = event.buf, desc = '[G]oto Code [A]ction' })
    vim.keymap.set('n', 'gd', function() snacks.picker.lsp_definitions() end, { desc = '[G]oto Definition' })
    vim.keymap.set('n', 'gD', function() snacks.picker.lsp_declarations() end, { desc = '[G]oto Declaration' })
    vim.keymap.set('n', 'gr', function() snacks.picker.lsp_references() end, { nowait = true, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', function() snacks.picker.lsp_implementations() end, { desc = '[G]oto Implementation' })
    vim.keymap.set('n', 'gy', function() snacks.picker.lsp_type_definitions() end, { desc = '[G]oto T[y]pe Definition' })
    vim.keymap.set('n', 'gai', function() snacks.picker.lsp_incoming_calls() end, { desc = '[G]oto C[a]lls Incoming' })
    vim.keymap.set('n', 'gao', function() snacks.picker.lsp_outgoing_calls() end, { desc = '[G]oto C[a]lls Outgoing' })
    vim.keymap.set('n', '<leader>ss', function() snacks.picker.lsp_symbols() end, { desc = '[S]ymbols' })
    vim.keymap.set('n', '<leader>sS', function() snacks.picker.lsp_workspace_symbols() end, { desc = 'Workspace [S]ymbols' })
  end,
})
