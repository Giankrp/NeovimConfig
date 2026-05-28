-- Leader keys must be set before any plugin loads
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.relativenumber = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable faster startup via Lua bytecode caching
vim.loader.enable()

-- ── Core (no plugin dependencies) ────────────────────────────────────────────
require 'config.options' -- vim.o.*, vim.opt.*, vim.diagnostic.config
require 'config.keymaps' -- global keymaps
require 'config.autocmds' -- global autocommands
require 'config.pack' -- vim.pack build hooks (must come before any vim.pack.add)

-- ── Plugins ───────────────────────────────────────────────────────────────────
require 'plugins.ui' -- catppuccin, gitsigns, which-key, mini.*, todo-comments
require 'plugins.snacks' -- snacks.nvim (picker, explorer, indent, lazygit, dashboard, etc.)
require 'plugins.lsp' -- language servers + mason + fidget
require 'plugins.none-ls' -- formatting, linting, and code actions
require 'plugins.completion' -- blink.cmp + LuaSnip
require 'plugins.treesitter' -- syntax highlighting and indentation

-- ── Optional extras (uncomment to enable) ────────────────────────────────────
require 'plugins.extras.gitsigns' -- extended git hunk keymaps
require 'plugins.extras.autopairs' -- auto-close brackets and quotes
require 'plugins.extras.opencode' -- Bridge Neovim and OpenCode AI (See warning in config if on Windows)
-- require 'plugins.extras.flutter'     -- Flutter/Dart development tools
-- require 'plugins.extras.debug'        -- DAP debugger (Go + extensible)
