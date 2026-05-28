-- Quality of life utilities and UI enhancements via snacks.nvim
-- Replaces Telescope, Neo-tree, Indent-blankline, and Lazygit
-- See https://github.com/folke/snacks.nvim

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'folke/snacks.nvim' }

-- Setup snacks modules
require('snacks').setup {
  bigfile = { enabled = true }, -- Optimize performance for big files
  quickfile = { enabled = true }, -- Optimize Neovim startup speed
  notifier = { enabled = true }, -- Pretty notification manager
  dashboard = {
    enabled = true,
    preset = {
      header = [[
  ⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄
  ⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄
  ⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄
  ⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄
  ⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰
  ⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤
  ⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗
  ⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄
  ⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄
  ⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄
  ⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄
  ⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄
  ⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄
  ⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴
  ⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿
      ]],
    },
    sections = {
      { section = 'header' },
      {
        pane = 2,
        section = 'terminal',
        cmd = 'colorscript -e square',
        height = 5,
        padding = 1,
        enabled = function() return vim.fn.executable('colorscript') == 1 end,
      },
      { section = 'keys', gap = 1, padding = 1 },
      { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
      {
        pane = 2,
        icon = ' ',
        title = 'Git Status',
        section = 'terminal',
        enabled = function() return Snacks.git.get_root() ~= nil end,
        cmd = 'git status --short --branch --renames',
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
    },
  },
  statuscolumn = { enabled = true }, -- Clean statuscolumn (numbers, git signs)
  words = { enabled = true }, -- Highlight words under cursor with LSP
  indent = { enabled = true }, -- Indent guides (replaces indent-blankline)
  lazygit = { enabled = true }, -- Git terminal UI (replaces lazygit.nvim)
  input = { enabled = true }, -- Beautiful floating input box (for LSP rename, etc.)
  select = { enabled = true }, -- Beautiful floating select box (for LSP code actions, etc.)
  bufdelete = { enabled = true }, -- Delete buffers without disrupting layout
  gitbrowse = { enabled = true }, -- Open current file/line in git web interface
  scratch = { enabled = true }, -- Persistent scratch buffers
  picker = {
    enabled = true,
    actions = {
      opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
    },
    win = {
      input = {
        keys = {
          ['<A-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
        },
      },
    },
    sources = {
      explorer = {
        hidden = true, -- Show hidden files/dotfiles by default
        layout = {
          layout = {
            position = 'right', -- Position explorer on the right side
          },
        },
        win = {
          input = {
            keys = {
              ['<C-n>'] = { 'close', mode = { 'n', 'i' } }, -- Close explorer with Ctrl+N
            },
          },
        },
      },
    },
  },
}

-- ── Keymaps ──────────────────────────────────────────────────────────────────

-- File Explorer
vim.keymap.set('n', '<C-n>', function() Snacks.explorer() end, { desc = 'Toggle File Explorer', silent = true })

-- Lazygit Integration
vim.keymap.set('n', '<leader>lg', function() Snacks.lazygit() end, { desc = '[L]azy[G]it (cwd)' })
vim.keymap.set('n', '<leader>lG', function() Snacks.lazygit { file = vim.api.nvim_buf_get_name(0) } end, { desc = '[L]azy[G]it current file' })

-- General Search Keymaps (replacing Telescope builtins)
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.pickers() end, { desc = '[S]earch [S]elect Picker' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', function() Snacks.picker.recent() end, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.commands() end, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.buffers() end, { desc = '[ ] Find existing buffers' })

-- Fuzzy search within the current buffer
vim.keymap.set('n', '<leader>/', function() Snacks.picker.lines() end, { desc = '[/] Fuzzily search in current buffer' })

-- Live grep across all open buffers
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.grep { buffers = true } end, { desc = '[S]earch [/] in Open Files' })

-- Search Neovim config files
vim.keymap.set('n', '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })

-- Buffer Delete (without breaking layouts)
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' })

-- Git Browse (open current file/lines on GitHub/GitLab/etc.)
vim.keymap.set({ 'n', 'x' }, '<leader>gb', function() Snacks.gitbrowse() end, { desc = '[G]it [B]rowse' })

-- Scratch Buffers (persistent quick notes / scratchpads)
vim.keymap.set('n', '<leader>bs', function() Snacks.scratch() end, { desc = '[B]uffer [S]cratch toggle' })
vim.keymap.set('n', '<leader>bS', function() Snacks.scratch.select() end, { desc = '[B]uffer [S]cratch select' })

-- ── LSP Pickers on LspAttach ──────────────────────────────────────────────────
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('snacks-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    vim.keymap.set('n', 'grr', function() Snacks.picker.lsp_references() end, { buffer = buf, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gri', function() Snacks.picker.lsp_implementations() end, { buffer = buf, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', 'grd', function() Snacks.picker.lsp_definitions() end, { buffer = buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gO', function() Snacks.picker.lsp_symbols() end, { buffer = buf, desc = 'Open Document Symbols' })
    vim.keymap.set('n', 'gW', function() Snacks.picker.lsp_workspace_symbols() end, { buffer = buf, desc = 'Open Workspace Symbols' })
    vim.keymap.set('n', 'grt', function() Snacks.picker.lsp_type_definitions() end, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})
