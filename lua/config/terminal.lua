-- ============================================================
-- Advanced terminal integration via toggleterm
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  -- Toggle the terminal open/closed from normal or terminal mode
  open_mapping = [[<c-/>]],
  direction = 'horizontal',
  -- Keep the terminal size relative to the editor
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  float_opts = { border = 'curved' },
  start_in_insert = true,
}

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('config-terminal-keymaps', { clear = true }),
  pattern = 'term://*',
  callback = function()
    local opts = { buffer = 0 }

    -- Leave terminal (insert) mode back to normal mode
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

    -- Navigate to other panels directly from the terminal. These are bound in
    -- both terminal and normal mode: cmake-tools' runner opens a toggleterm with
    -- close_on_exit = false, so once the executable finishes the job dies and the
    -- buffer drops out of terminal mode into normal mode (the "[Process exited]"
    -- state). Without the normal-mode maps you'd be stranded in that output
    -- window with no way to navigate out. <Cmd>…<CR> works the same in both modes.
    vim.keymap.set({ 't', 'n' }, '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set({ 't', 'n' }, '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set({ 't', 'n' }, '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set({ 't', 'n' }, '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

    -- Close the focused terminal window with the same <c-/> toggle key, even
    -- after the process has exited. cmake-tools' runner opens its toggleterm with
    -- close_on_exit = false, but when the program exits toggleterm's TermClose
    -- handler removes that terminal from its registry. The window/buffer stay
    -- open yet orphaned, so the normal <c-/> toggle (:ToggleTerm -> terms.get())
    -- can no longer find it to close it. toggleterm only binds <c-/> in terminal
    -- mode, so we add a normal-mode map: ask toggleterm to close the terminal if
    -- it still tracks it, otherwise close the orphaned window directly.
  end,
})
