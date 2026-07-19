-- ============================================================
-- Init file for all neovim configurations and plugins
-- Ties together all configs and plugins in correct order
-- ============================================================

-- Set standard neovim options
require 'config.options'

-- Set a theme for neovim
require 'config.theme'

-- Set keymaps for standard neovim functions
require 'config.keymaps'

-- Configure git
require 'config.git'

-- Configure file browser
require 'config.filebrowser'

-- Configure treesitter
require 'config.treesitter'

-- Configure diagnostics
require 'config.diagnostics'

-- Configure search and navigation
require 'config.navigation'

-- Miscellaneous utility features
require 'config.editing'

-- Configure debugging capabilitites
require 'config.debug'

-- Configure task and job manager
require 'config.task'

-- Configure advanced terminal
require 'config.terminal'

-- ============================================================
-- Language & Ecosystem specific configurations
-- Ties together all configs and plugins in correct order
-- ============================================================
-- Confiugre lsps, completions, linters and formatters
require 'config.lsp'

-- Configure advanced formatting
require 'config.formatting'

-- Configure advanced autocompletion
require 'config.autocomplete'

-- Configure cmake capabilitites for cross-platform development
require 'config.cmake'

-- Configure tooling for apple development
require 'config.xcode'

-- Configure python specific tooling
require 'config.python'

-- Configure rustaceanvim
require 'config.rust'

-- Configure testing capabilities
require 'config.testing'
