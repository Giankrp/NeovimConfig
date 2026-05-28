-- Formatting, linting, and code actions via none-ls
-- none-ls is the community-maintained successor to null-ls.nvim
-- See https://github.com/nvimtools/none-ls.nvim
--
-- none-ls registers as an LSP client, so formatting is done via vim.lsp.buf.format().
-- Tools must be installed separately — add them to the 'tools' table in plugins/lsp.lua
-- so Mason installs them automatically.

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvimtools/none-ls.nvim',
  gh 'nvim-lua/plenary.nvim', -- required dependency
}

local none_ls = require 'null-ls'
local b = none_ls.builtins

none_ls.setup {
  sources = {
    -- Formatters
    b.formatting.stylua, -- Requires mason tool: stylua

    b.formatting.prettier.with {
      filetypes = { 'html', 'css', 'markdown', 'json', 'yaml' },
    },

    -- Custom formatter: oxfmt (ultra-fast formatter for JS/TS)
    {
      name = 'oxfmt',
      method = none_ls.methods.FORMATTING,
      filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'astro' },
      generator = none_ls.formatter {
        command = 'oxfmt',
        args = { '--stdin-filepath', '$FILENAME' },
        to_stdin = true,
      },
    },
    -- Diagnostics (Linters)
    b.diagnostics.markdownlint, -- Requires mason tool: markdownlint

    -- Code Actions
    b.code_actions.gitsigns,
  },

  -- Format on save (opt-in per filetype)
  on_attach = function(client, bufnr)
    if client:supports_method 'textDocument/formatting' then
      local fmt_filetypes = {
        lua = true,
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        html = true,
        css = true,
        markdown = true,
      }
      if fmt_filetypes[vim.bo[bufnr].filetype] then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function() vim.lsp.buf.format { bufnr = bufnr, async = false } end,
        })
      end
    end
  end,
}

-- Manual format keymap — works for any filetype with an attached formatter
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = '[F]ormat buffer' })
