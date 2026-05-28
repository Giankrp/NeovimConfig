-- DAP (Debug Adapter Protocol): nvim-dap + nvim-dap-ui
-- Primarily configured for Go (delve), extendable to other languages.
-- See https://github.com/mfussenegger/nvim-dap

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'mfussenegger/nvim-dap',
  gh 'rcarriga/nvim-dap-ui',
  gh 'nvim-neotest/nvim-nio',
  gh 'mason-org/mason.nvim',
  gh 'jay-babu/mason-nvim-dap.nvim',
  gh 'leoluz/nvim-dap-go',
}

local dap    = require 'dap'
local dapui  = require 'dapui'

-- Keymaps
vim.keymap.set('n', '<F5>',      function() dap.continue() end,           { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>',      function() dap.step_into() end,          { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>',      function() dap.step_over() end,          { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>',      function() dap.step_out() end,           { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end,  { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Conditional Breakpoint' })
vim.keymap.set('n', '<F7>',      function() dapui.toggle() end,           { desc = 'Debug: Toggle UI' })

require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve', -- Go debugger — add other adapters here
  },
}

---@diagnostic disable-next-line: missing-fields
dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  ---@diagnostic disable-next-line: missing-fields
  controls = {
    icons = {
      pause      = '⏸', play       = '▶', step_into = '⏎',
      step_over  = '⏭', step_out   = '⏮', step_back = 'b',
      run_last   = '▶▶', terminate  = '⏹', disconnect = '⏏',
    },
  },
}

-- Auto-open/close dapui with DAP session lifecycle
dap.listeners.after.event_initialized['dapui_config']  = dapui.open
dap.listeners.before.event_terminated['dapui_config']  = dapui.close
dap.listeners.before.event_exited['dapui_config']      = dapui.close

-- Go-specific DAP configuration via nvim-dap-go
require('dap-go').setup {
  delve = {
    -- On Windows, delve must run attached or it crashes
    detached = vim.fn.has 'win32' == 0,
  },
}
