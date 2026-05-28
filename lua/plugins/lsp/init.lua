-- LSP configuration: language servers, keymaps, and Mason-managed installations
-- See :help lsp-config and :help lsp-vs-treesitter

local function gh(repo) return 'https://github.com/' .. repo end

-- LSP status notifications in the corner
vim.pack.add { gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

-- LSP keymaps and features, set per buffer on LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Highlight references of symbol under cursor on CursorHold
        -- See :help CursorHold
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local hl_group = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = hl_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = hl_group,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        -- Enable inlay hints by default if the server supports them
        -- See :help lsp-inlay_hint
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
            map('<leader>th',
                function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
                '[T]oggle Inlay [H]ints')
        end
    end,
})

-- Language server configurations
-- Add servers here to have Mason install them and Neovim enable them automatically.
-- See :help lsp-config for available keys per server entry.

---@type table<string, vim.lsp.Config>
local servers = {
    -- Servers without specific configuration can be added here
    -- clangd = {},
    -- pyright = {},
}

-- Dynamically load server configurations from the 'servers' directory
local servers_dir = vim.fn.stdpath 'config' .. '/lua/plugins/lsp/servers'
if vim.uv.fs_stat(servers_dir) then
    for _, file in ipairs(vim.fn.readdir(servers_dir)) do
        local name = file:match '(.+)%.lua$'
        if name then
            servers[name] = require('plugins.lsp.servers.' .. name)
        end
    end
end

-- Standalone tools for Mason to install (used by none-ls for formatting/linting)
local tools = {
    'stylua',
    'prettier',
    'markdownlint',
    'tailwindcss-language-server',
}

vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('mason').setup {}

-- Prepend Mason bin path to Neovim PATH
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin:' .. vim.env.PATH

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, tools)
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- Enable language servers using the new built-in Neovim LSP API (0.11+)
-- See :help vim.lsp.config and :help vim.lsp.enable
for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
end
