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
vim.keymap.set('n', '<leader>n', function() snacks.picker.notifications() end, { desc = '[N]otification History' })
vim.keymap.set('n', '<leader>ee', function() snacks.explorer() end, { desc = 'File [E]xplorer' })

-- find
vim.keymap.set('n', '<leader>fb', function() snacks.picker.buffers() end, { desc = '[B]uffers' })
vim.keymap.set('n', '<leader>fc', function() snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find [C]onfig File' })
vim.keymap.set('n', '<leader>ff', function() snacks.picker.files() end, { desc = 'Find [F]iles' })
vim.keymap.set('n', '<leader>fg', function() snacks.picker.git_files() end, { desc = 'Find [G]it Files' })
vim.keymap.set('n', '<leader>fp', function() snacks.picker.projects() end, { desc = '[P]rojects' })
vim.keymap.set('n', '<leader>fr', function() snacks.picker.recent() end, { desc = '[R]ecent' })

-- git
vim.keymap.set('n', '<leader>gfb', function() snacks.picker.git_branches() end, { desc = 'Git [B]ranches' })
vim.keymap.set('n', '<leader>gfl', function() snacks.picker.git_log() end, { desc = 'Git [L]og' })
vim.keymap.set('n', '<leader>gfL', function() snacks.picker.git_log_line() end, { desc = 'Git Log [L]ine' })
vim.keymap.set('n', '<leader>gfs', function() snacks.picker.git_status() end, { desc = 'Git [S]tatus' })
vim.keymap.set('n', '<leader>gfS', function() snacks.picker.git_stash() end, { desc = 'Git [S]tash' })
vim.keymap.set('n', '<leader>gfd', function() snacks.picker.git_diff() end, { desc = 'Git [D]iff (Hunks)' })
vim.keymap.set('n', '<leader>gff', function() snacks.picker.git_log_file() end, { desc = 'Git Log [F]ile' })

-- gh
vim.keymap.set('n', '<leader>gfi', function() snacks.picker.gh_issue() end, { desc = 'GitHub [I]ssues (open)' })
vim.keymap.set('n', '<leader>gfI', function() snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub [I]ssues (all)' })
vim.keymap.set('n', '<leader>gfp', function() snacks.picker.gh_pr() end, { desc = 'GitHub [P]ull Requests (open)' })
vim.keymap.set('n', '<leader>gfP', function() snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub [P]ull Requests (all)' })

-- Grep
vim.keymap.set('n', '<leader>sB', function() snacks.picker.grep_buffers() end, { desc = 'Grep Open [B]uffers' })
vim.keymap.set('n', '<leader>sg', function() snacks.picker.grep() end, { desc = '[G]rep' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() snacks.picker.grep_word() end, { desc = 'Visual selection or [w]ord' })

-- search
vim.keymap.set('n', '<leader>s"', function() snacks.picker.registers() end, { desc = 'Registers' })
vim.keymap.set('n', '<leader>s/', function() snacks.picker.search_history() end, { desc = 'Search History' })
vim.keymap.set('n', '<leader>sa', function() snacks.picker.autocmds() end, { desc = '[A]utocmds' })
vim.keymap.set('n', '<leader>sb', function() snacks.picker.lines() end, { desc = '[B]uffer Lines' })
vim.keymap.set('n', '<leader>sc', function() snacks.picker.command_history() end, { desc = '[C]ommand History' })
vim.keymap.set('n', '<leader>sC', function() snacks.picker.commands() end, { desc = '[C]ommands' })
vim.keymap.set('n', '<leader>sd', function() snacks.picker.diagnostics() end, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>sD', function() snacks.picker.diagnostics_buffer() end, { desc = 'Buffer [D]iagnostics' })
vim.keymap.set('n', '<leader>sh', function() snacks.picker.help() end, { desc = '[H]elp Pages' })
vim.keymap.set('n', '<leader>sH', function() snacks.picker.highlights() end, { desc = '[H]ighlights' })
vim.keymap.set('n', '<leader>si', function() snacks.picker.icons() end, { desc = '[I]cons' })
vim.keymap.set('n', '<leader>sj', function() snacks.picker.jumps() end, { desc = '[J]umps' })
vim.keymap.set('n', '<leader>sk', function() snacks.picker.keymaps() end, { desc = '[K]eymaps' })
vim.keymap.set('n', '<leader>sl', function() snacks.picker.loclist() end, { desc = '[L]ocation List' })
vim.keymap.set('n', '<leader>sm', function() snacks.picker.marks() end, { desc = '[M]arks' })
vim.keymap.set('n', '<leader>sM', function() snacks.picker.man() end, { desc = '[M]an Pages' })
vim.keymap.set('n', '<leader>sp', function() snacks.picker.lazy() end, { desc = 'Search for [P]lugin Spec' })
vim.keymap.set('n', '<leader>sq', function() snacks.picker.qflist() end, { desc = '[Q]uickfix List' })
vim.keymap.set('n', '<leader>sR', function() snacks.picker.resume() end, { desc = '[R]esume' })
vim.keymap.set('n', '<leader>su', function() snacks.picker.undo() end, { desc = '[U]ndo History' })
vim.keymap.set('n', '<leader>uC', function() snacks.picker.colorschemes() end, { desc = '[C]olorschemes' })

-- Other
vim.keymap.set('n', '<leader>.', function() snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
vim.keymap.set('n', '<leader>S', function() snacks.scratch.select() end, { desc = '[S]elect Scratch Buffer' })
vim.keymap.set('n', '<leader>bd', function() snacks.bufdelete() end, { desc = '[D]elete Buffer' })
vim.keymap.set('n', '<leader>bR', function() snacks.rename.rename_file() end, { desc = '[R]ename File' })
vim.keymap.set({ 'n', 'v' }, '<leader>gB', function() snacks.gitbrowse() end, { desc = 'Open in [B]rowser' })
vim.keymap.set('n', '<leader>gg', function() snacks.lazygit() end, { desc = 'Lazy[g]it' })
vim.keymap.set('n', '<leader>un', function() snacks.notifier.hide() end, { desc = 'Dismiss All [N]otifications' })
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
  callback = function()
    vim.keymap.set('n', 'gd', function() snacks.picker.lsp_definitions() end, { desc = '[D]efinition' })
    vim.keymap.set('n', 'gD', function() snacks.picker.lsp_declarations() end, { desc = '[D]eclaration' })
    vim.keymap.set('n', 'gr', function() snacks.picker.lsp_references() end, { nowait = true, desc = '[R]eferences' })
    vim.keymap.set('n', 'gI', function() snacks.picker.lsp_implementations() end, { desc = '[I]mplementation' })
    vim.keymap.set('n', 'gy', function() snacks.picker.lsp_type_definitions() end, { desc = 'T[y]pe Definition' })
    vim.keymap.set('n', 'gai', function() snacks.picker.lsp_incoming_calls() end, { desc = '[I]ncoming' })
    vim.keymap.set('n', 'gao', function() snacks.picker.lsp_outgoing_calls() end, { desc = '[O]utgoing' })
    vim.keymap.set('n', '<leader>ss', function() snacks.picker.lsp_symbols() end, { desc = '[S]ymbols' })
    vim.keymap.set('n', '<leader>sS', function() snacks.picker.lsp_workspace_symbols() end, { desc = 'Workspace [S]ymbols' })
  end,
})
