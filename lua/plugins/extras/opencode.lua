-- Bridge Neovim and OpenCode AI
-- See https://github.com/nickjvandyke/opencode.nvim

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'nickjvandyke/opencode.nvim' }

-- Configuration options
vim.g.opencode_opts = {
  lsp = { enabled = true }, -- Enable experimental LSP for hover and code actions
}

-- Required for automatic buffer reloading after AI edits
vim.o.autoread = true

-- Recommended Keymaps
vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode...' })
vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Select opencode...' })
vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator '@this ' end, { desc = 'Add range to opencode', expr = true })
vim.keymap.set('n', 'goo', function() return require('opencode').operator '@this ' .. '_' end, { desc = 'Add line to opencode', expr = true })
