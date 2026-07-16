-- ============================================================
-- Rust specific configuration
-- ============================================================

vim.pack.add {
  {
    src = 'https://github.com/mrcjkb/rustaceanvim',
    -- To avoid being surprised by breaking changes,
    -- I recommend you set a version range
    version = vim.version.range '^9',
  },
}

vim.g.rustaceanvim = function()
  -- Update this path
  local extension_path = vim.env.HOME .. '/.local/share/codelldb/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb'
  local this_os = vim.uv.os_uname().sysname

  -- The path is different on Windows
  if this_os:find 'Windows' then
    codelldb_path = extension_path .. 'adapter\\codelldb.exe'
    liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
  else
    -- The liblldb extension is .so for Linux and .dylib for MacOS
    liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')
  end

  local cfg = require 'rustaceanvim.config'
  return {
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
      default_settings = {
        ['rust-analyzer'] = {
          -- Lint on save with clippy instead of plain `cargo check`.
          checkOnSave = true,
          check = {
            command = 'clippy',
            extraArgs = { '--no-deps' },
          },
        },
      },
    },
  }
end

-- ============================================================
-- Rust keymaps (rustaceanvim / rust-analyzer extensions)
--
-- Registered in an LspAttach autocmd filtered to rust-analyzer. Because
-- config.rust is required after config.lsp (see config/init.lua), these
-- buffer-local maps run last and override the generic LSP maps for Rust.
-- ============================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('rustaceanvim-keymaps', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or client.name ~= 'rust-analyzer' then return end

    local map = function(mode, keys, action, desc)
      vim.keymap.set(mode, keys, function() vim.cmd.RustLsp(action) end, { buffer = event.buf, desc = desc })
    end

    -- Override: replace the generic hover with the richer rustaceanvim UI
    map('n', 'K', { 'hover', 'actions' }, 'Hover actions (press again to enter)')

    -- Additions: rust-analyzer extensions with no plain-LSP equivalent
    map({ 'n', 'x' }, '<leader>ca', 'codeAction', 'Code [A]ction')
    map('n', '<leader>rr', 'runnables', '[R]unnables')
    map('n', '<leader>rt', 'testables', '[T]estables')
    map('n', '<leader>rd', 'debuggables', '[D]ebuggables') -- needs codelldb
    map('n', '<leader>rm', 'expandMacro', 'Expand [M]acro')
    map('n', '<leader>rp', 'parentModule', '[P]arent module')
    map('n', '<leader>rD', 'openDocs', 'Open [D]ocs.rs')
    map('n', '<leader>rc', 'openCargo', 'Open [C]argo.toml')
    map('n', '<leader>re', 'renderDiagnostic', 'R[e]nder diagnostic')
    map('n', '<leader>rE', 'explainError', '[E]xplain error (rustc --explain)')
    map('n', '<leader>rk', { 'moveItem', 'up' }, 'Move item up')
    map('n', '<leader>rj', { 'moveItem', 'down' }, 'Move item down')
  end,
})
