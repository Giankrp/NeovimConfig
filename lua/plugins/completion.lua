-- Autocompletion and snippet engine
-- See :help ins-completion and :help blink-cmp

local function gh(repo) return 'https://github.com/' .. repo end

-- Snippet engine
-- See :help luasnip
vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Optional: community snippet collection
-- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
-- require('luasnip.loaders.from_vscode').lazy_load()

-- Completion engine
-- See :help blink-cmp-config
vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = {
    -- 'default': <c-y> to accept, <c-n>/<c-p> to navigate
    -- 'super-tab': <Tab> to accept, <c-n>/<c-p> to navigate
    -- 'enter': <Enter> to accept
    -- See :help blink-cmp-config-keymap
    preset = 'enter',
  },

  appearance = {
    -- 'mono' for Nerd Font Mono, 'normal' for Nerd Font
    nerd_font_variant = 'mono',
  },

  completion = {
    -- Set auto_show = true to show docs automatically after a delay
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  -- Use the Lua fuzzy matcher by default.
  -- Switch to 'prefer_rust_with_warning' for the faster Rust-based matcher.
  -- See :help blink-cmp-config-fuzzy
  fuzzy = { implementation = 'lua' },

  -- Show function signature help while typing arguments
  signature = { enabled = true },
}
