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

-- Configure file browser
require 'config.filebrowser'

-- Configure treesitter
require 'config.treesitter'

-- Configure diagnostics
require 'config.diagnostics'

-- Configure git
require 'config.git'

-- Configure search and navigation
require 'config.navigation'

-- Confiugre lsps, completions, linters and formatters
require 'config.lsp'

-- Configure advanced formatting
require 'config.formatting'

-- Configure advanced autocompletion
require 'config.autocomplete'

-- Configure testing capabilities
require 'config.testing'

-- Miscellaneous utility features
require 'config.editing'

-- Xcodebuild
require 'config.xcode'
