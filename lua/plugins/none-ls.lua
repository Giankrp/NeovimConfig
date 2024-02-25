return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local lint = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.prettier.with { filetypes = { "astro" } },
      formatting.gofumpt,
      formatting.goimports,
      formatting.golines,
    }

    null_ls.setup({sources = sources})
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "code format" })
  end
}
