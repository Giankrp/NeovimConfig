-- Bridge Neovim and OpenCode AI
-- See https://github.com/nickjvandyke/opencode.nvim
--
-- WARNING (Windows/PowerShell):
-- Spawning the OpenCode server automatically in Windows can cause significant lag.
-- If you experience performance issues, run the server manually in an external terminal:
--   opencode --port 3000
-- And uncomment the `server` config option below.

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'nickjvandyke/opencode.nvim' }

-- Configuration options
vim.g.opencode_opts = {
  lsp = { enabled = true }, -- Enable experimental LSP for hover and code actions
  -- server = {
  --   url = "http://127.0.0.1:3000", -- Run 'opencode --port 3000' in external shell
  -- }
}

-- Required for automatic buffer reloading after AI edits
vim.o.autoread = true

-- Recommended Keymaps
vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode...' })
vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Select opencode...' })
vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator '@this ' end, { desc = 'Add range to opencode', expr = true })
vim.keymap.set('n', 'goo', function() return require('opencode').operator '@this ' .. '_' end, { desc = 'Add line to opencode', expr = true })
