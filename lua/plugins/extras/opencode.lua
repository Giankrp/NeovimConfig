-- Bridge Neovim and OpenCode AI
-- See https://github.com/nickjvandyke/opencode.nvim
--
-- WARNING (Windows/PowerShell):
-- Spawning the OpenCode server automatically in Windows can cause significant lag.
-- If you experience performance issues, run the server manually in an external terminal:
--   opencode --port 3000
-- And uncomment the `server` config option below.

local function gh(repo) return 'https://github.com/' .. repo end

-- Required for automatic buffer reloading after AI edits
vim.o.autoread = true

-- Configuration options (applied on first load)
vim.g.opencode_opts = {
  lsp = { enabled = true }, -- Enable experimental LSP for hover and code actions
  -- server = {
  --   url = "http://127.0.0.1:3000", -- Run 'opencode --port 3000' in external shell
  -- }
}

-- Lazy loader: adds the plugin and loads it only once
local loaded = false
local function load_opencode()
  if not loaded then
    loaded = true
    vim.pack.add { gh 'nickjvandyke/opencode.nvim' }
  end
end

-- Keymaps — plugin is loaded only when one of these is pressed for the first time
vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
  load_opencode()
  require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask opencode...' })

vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
  load_opencode()
  require('opencode').select()
end, { desc = 'Select opencode...' })

vim.keymap.set({ 'n', 't' }, '<C-.>', function()
  load_opencode()
  require('opencode').toggle()
end, { desc = 'Toggle opencode' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
  load_opencode()
  return require('opencode').operator '@this '
end, { desc = 'Add range to opencode', expr = true })

vim.keymap.set('n', 'goo', function()
  load_opencode()
  return require('opencode').operator '@this ' .. '_'
end, { desc = 'Add line to opencode', expr = true })

-- Kill opencode process completely and reset state
vim.keymap.set('n', '<leader>oq', function()
  vim.system({ 'pkill', '-9', 'opencode' }, {}, function(result)
    loaded = false
    vim.schedule(function()
      if result.code == 0 then
        vim.notify('OpenCode terminado.', vim.log.levels.INFO)
      else
        vim.notify('OpenCode no estaba corriendo.', vim.log.levels.WARN)
      end
    end)
  end)
end, { desc = 'Quit opencode (kill process)' })
