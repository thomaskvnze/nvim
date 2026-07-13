-- ============================================================
-- Fuzzy finder and navigation tools
-- ============================================================

local helper = require 'config.helper'

vim.pack.add {
  { src = helper.gh 'nvim-mini/mini.pick', version = 'stable' },
  { src = helper.gh 'nvim-mini/mini.extra', version = 'stable' },
  { src = helper.gh 'nvim-mini/mini.icons', version = 'stable' },
}

local minipick = require 'mini.pick'
minipick.setup()
local miniextra = require 'mini.extra'
miniextra.setup()

if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

local builtin = minipick.builtin
local extras = miniextra.pickers
vim.keymap.set('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sk', extras.keymaps, { desc = '[S]earch [K]eymaps' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', extras.diagnostic, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', extras.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', extras.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sp', extras.history, { desc = '[S]earch [P]ast Commands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>so', extras.options, { desc = '[S]earch [O]ptions' })
vim.keymap.set('n', '<leader>s/', function() extras.buf_lines({scope = "all"}) end, { desc = '[s/] Fuzzily search in open buffers' })
vim.keymap.set('n', '<leader>/', function() extras.buf_lines({scope = "current"}) end, { desc = '[/] Fuzzily search in current buffer' })


vim.api.nvim_create_autocmd('LspAttach', {
group = vim.api.nvim_create_augroup('mini-pick-lsp-attach', { clear = true}),
callback = function(event)
	local buf = event.buf
    -- Find references for the word under your cursor.
    vim.keymap.set('n', 'grr', function() extras.lsp({scope = "references" }) end, { buffer = buf, desc = '[G]oto [R]eferences' })

    -- Jump to the implementation of the word under your cursor.
    -- Useful when your language has ways of declaring types without an actual implementation.
    vim.keymap.set('n', 'gri', function() extras.lsp({scope = "implementation" }) end, { buffer = buf, desc = '[G]oto [I]mplementation' })

    -- Jump to the definition of the word under your cursor.
    -- This is where a variable was first declared, or where a function is defined, etc.
    -- To jump back, press <C-t>.
    vim.keymap.set('n', 'grd', function() extras.lsp({scope = "definition" }) end, { buffer = buf, desc = '[G]oto [D]efinition' })

    -- Fuzzy find all the symbols in your current document<LeftMouse>
    -- Symbols are things like variables, functions, types, etc.
    vim.keymap.set('n', 'gO', function() extras.lsp({scope = "document_symbol" }) end, { buffer = buf, desc = 'Open Document Symbols' })

    -- Fuzzy find all the symbols in your current workspace.
    -- Similar to document symbols, except searches over your entire project.
    vim.keymap.set('n', 'gW', function() extras.lsp({scope = "workspace_symbol_live" }) end, { buffer = buf, desc = 'Open Workspace Symbols' })

    -- Jump to the type of the word under your cursor.
    -- Useful when you're not sure what type a variable is and you want to se<LeftMouse>
    -- the definition of its *type*, not where it was *defined*.
    vim.keymap.set('n', 'grt', function() extras.lsp({scope = "type_definition" }) end, { buffer = buf, desc = '[G]oto [T]ype Definition' })
end,
})
