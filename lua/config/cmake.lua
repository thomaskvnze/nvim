-- ============================================================
-- CMake Integration in neovim
-- ============================================================

local helper = require 'config.helper'

vim.pack.add { helper.gh 'nvim-lua/plenary.nvim' }
vim.pack.add { helper.gh 'civitasv/cmake-tools.nvim' }

local osys = require 'cmake-tools.osys'
require('cmake-tools').setup {
  cmake_command = 'cmake', -- this is used to specify cmake command path
  ctest_command = 'ctest', -- this is used to specify ctest command path
  ctest_show_labels = false, -- also show labels in the test picker
  cmake_use_preset = true,
  cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
  cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- this will be passed when invoke `CMakeGenerate`
  cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  -- support macro expansion:
  --       ${kit}
  --       ${kitGenerator}
  --       ${variant:xx}
  cmake_build_directory = function()
    if osys.iswin32 then return 'build\\${variant:buildType}' end
    return 'build/${variant:buildType}'
  end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
  cmake_compile_commands_options = {
    action = 'lsp', -- available options: soft_link, copy, lsp, none
    -- soft_link: this will automatically make a soft link from compile commands file to target
    -- copy:      this will automatically copy compile commands file to target
    -- lsp:       this will automatically set compile commands file location using lsp
    -- none:      this will make this option ignored
    -- target = vim.loop.cwd, -- path or function returning path to directory, this is used only if action == "soft_link" or action == "copy"
  },
  cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  cmake_variants_message = {
    short = { show = true }, -- whether to show short message
    long = { show = true, max_length = 40 }, -- whether to show long message
  },
  cmake_dap_configuration = { -- debug settings for cmake
    name = 'cmake',
    type = 'codelldb',
    request = 'launch',
    stopOnEntry = false,
    console = 'integratedTerminal',
  },
  cmake_executor = { -- executor to use
    name = 'quickfix', -- name of the executor
    opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for executors
      quickfix = {
        show = 'always', -- "always", "only_on_error"
        position = 'horizontal', -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
        size = 10,
        encoding = 'utf-8', -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      -- toggleterm = {
      --   direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
      --   close_on_exit = true, -- whether close the terminal when exit
      --   auto_scroll = true, -- whether auto scroll to the bottom
      --   scroll_on_error = true, -- scroll to bottom on error
      --   auto_focus = true, -- auto focus the terminal on activation
      --   focus_on_error = false, -- focus the terminal on a non-zero exit
      --   singleton = false, -- single instance, autocloses the opened one, if present
      -- },
      -- overseer = {
      --   new_task_opts = {
      --       strategy = {
      --           "toggleterm",
      --           direction = "horizontal",
      --           auto_scroll = true,
      --           quit_on_exit = "success"
      --       }
      --   }, -- options to pass into the `overseer.new_task` command
      --   on_new_task = function(task)
      --       require("overseer").open(
      --           { enter = false, direction = "right" }
      --       )
      --   end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
      -- },
      -- terminal = {
      --   name = "Main Terminal",
      --   prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
      --   split_direction = "horizontal", -- "horizontal", "vertical"
      --   split_size = 11,
      --
      --   -- Window handling
      --   single_terminal_per_instance = true, -- Single viewport, multiple windows
      --   single_terminal_per_tab = true, -- Single viewport per tab
      --   keep_terminal_static_location = true, -- Static location of the viewport if avialable
      --   auto_resize = true, -- Resize the terminal if it already exists
      --
      --   -- Running Tasks
      --   start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
      --   focus = false, -- Focus on terminal when cmake task is launched.
      --   do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      -- }, -- terminal executor uses the values in cmake_terminal
    },
  },
  cmake_runner = { -- runner to use
    name = 'toggleterm', -- name of the runner
    opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for runners
      -- quickfix = {
      --   show = 'always', -- "always", "only_on_error"
      --   position = 'belowright', -- "bottom", "top"
      --   size = 10,
      --   encoding = 'utf-8',
      --   auto_close_when_success = false, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      -- },
      toggleterm = {
        direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = false, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
        scroll_on_error = true, -- scroll to bottom on error
        auto_focus = true, -- auto focus the terminal on activation
        focus_on_error = false, -- focus the terminal on a non-zero exit
        singleton = false, -- single instance, autocloses the opened one, if present
      },
      -- overseer = {
      --   new_task_opts = {
      --     strategy = {
      --       'toggleterm',
      --       direction = 'horizontal',
      --       autos_croll = true,
      --       quit_on_exit = 'success',
      --     },
      --   }, -- options to pass into the `overseer.new_task` command
      --   on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
      -- },
      -- terminal = {
      --   name = 'Main Terminal',
      --   prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
      --   split_direction = 'horizontal', -- "horizontal", "vertical"
      --   split_size = 11,
      --
      --   -- Window handling
      --   single_terminal_per_instance = true, -- Single viewport, multiple windows
      --   single_terminal_per_tab = true, -- Single viewport per tab
      --   keep_terminal_static_location = true, -- Static location of the viewport if avialable
      --   auto_resize = true, -- Resize the terminal if it already exists
      --
      --   -- Running Tasks
      --   start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
      --   focus = false, -- Focus on terminal when cmake task is launched.
      --   do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      --   use_shell_alias = false, -- Hide the verbose command wrapper by using a shell alias, showing only the program's output (currently not supported on Windows)
      -- },
    },
  },
  cmake_notifications = {
    runner = { enabled = true },
    executor = { enabled = true },
    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },
  cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
  cmake_use_scratch_buffer = false, -- A buffer that shows what cmake-tools has done
}

-- ============================================================
-- Keymaps (under the [C]Make which-key group)
-- Attached only while Neovim's cwd is inside a CMake project (a
-- CMakeLists.txt exists at or above the cwd). They are removed again
-- when you :cd out of the project.
-- ============================================================
local cmake_keymaps = {
  { '<leader>cg', '<cmd>CMakeGenerate<cr>', '[G]enerate' },
  { '<leader>cb', '<cmd>CMakeBuild<cr>', '[B]uild' },
  { '<leader>cr', '<cmd>CMakeRun<cr>', '[R]un' },
  { '<leader>cd', '<cmd>CMakeDebug<cr>', '[D]ebug' },
  { '<leader>cx', '<cmd>CMakeClean<cr>', 'Clean (X)' },
  { '<leader>cq', '<cmd>CMakeStop<cr>', 'Stop / [Q]uit task' },
  { '<leader>ct', '<cmd>CMakeSelectBuildTarget<cr>', 'Select build [T]arget' },
  { '<leader>cl', '<cmd>CMakeSelectLaunchTarget<cr>', 'Select [L]aunch target' },
  { '<leader>ck', '<cmd>CMakeSelectKit<cr>', 'Select [K]it' },
  { '<leader>cp', '<cmd>CMakeSelectConfigurePreset<cr>', 'Select [P]reset' },
  { '<leader>cv', '<cmd>CMakeSelectBuildType<cr>', 'Select [V]ariant / build type' },
  { '<leader>cT', '<cmd>CMakeRunTest<cr>', 'Run [T]ests (ctest)' },
  { '<leader>co', '<cmd>CMakeOpenRunner<cr>', '[O]pen executor output' },
  { '<leader>cc', '<cmd>CMakeCloseRunner<cr>', '[C]lose executor output' },
}

local keymaps_attached = false

local function attach_cmake_keymaps()
  if keymaps_attached then return end
  keymaps_attached = true
  require('which-key').add { { '<leader>c', group = '[C]Make', mode = 'n' } }
  for _, m in ipairs(cmake_keymaps) do
    vim.keymap.set('n', m[1], m[2], { desc = m[3] })
  end
end

local function detach_cmake_keymaps()
  if not keymaps_attached then return end
  keymaps_attached = false
  for _, m in ipairs(cmake_keymaps) do
    vim.keymap.del('n', m[1])
  end
end

local function sync_cmake_keymaps()
  if vim.fs.root(vim.uv.cwd(), 'CMakeLists.txt') ~= nil then
    attach_cmake_keymaps()
  else
    detach_cmake_keymaps()
  end
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  group = vim.api.nvim_create_augroup('cmake-tools-keymaps', { clear = true }),
  desc = 'Attach/detach CMake keymaps as the cwd enters/leaves a CMake project',
  callback = sync_cmake_keymaps,
})

sync_cmake_keymaps()
