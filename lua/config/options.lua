-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- General --
  vim.g.mapleader = ' ' -- set leader key
  vim.g.maplocalleader = ' ' -- set leader key
  vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
  vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
  vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end) -- Sync clipboard between OS and Neovim.
  vim.opt.errorbells = false -- no sounds

  -- Font --
  vim.g.have_nerd_font = true -- Global variable for nerd font. Convention by many plugins
  vim.opt.encoding = 'utf-8'

  -- Window --
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- Editor --
  vim.opt.number = true -- Make line numbers default
  vim.opt.relativenumber = false -- Show line numbers as relative numbers
  vim.opt.breakindent = true -- Enable break indent
  vim.opt.signcolumn = 'yes' -- Determine when to show the sign column
  vim.opt.guicursor = 'n-v-c-sm:block-blinkwait700-blinkon400-blinkoff250,i-ci-ve:ver25,r-cr-o:hor20'
  vim.opt.scrolloff = 10
  vim.opt.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- File & Folder --
  vim.opt.autochdir = false
  vim.opt.backup = false
  vim.opt.writebackup = false
  vim.opt.swapfile = false
  vim.opt.undofile = true -- Enable undo/redo changes even after closing and reopening a file
  vim.opt.updatetime = 250 -- Decrease update time
  vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
  vim.opt.ttimeoutlen = 10 -- Key code timeout
  vim.opt.autoread = true -- auto-reload changes if outside of neovim
  vim.opt.autowrite = false -- do not auto-save
  vim.opt.confirm = true

  -- Buffers --
  vim.opt.hidden = true
  vim.opt.modifiable = true

  -- Search & Replace--
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.hlsearch = true
  vim.opt.incsearch = true
  vim.opt.inccommand = 'split'

  -- Editing --
  vim.opt.iskeyword:append '-' -- include - in words
  vim.opt.selection = 'inclusive'
  vim.opt.backspace = 'indent,eol,start'
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.foldmethod = 'expr' -- use expression for folding
  vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter for folding
  vim.opt.foldlevel = 99 -- start with all folds open
end
