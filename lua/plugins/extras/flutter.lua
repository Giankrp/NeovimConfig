-- Tools to help create Flutter apps with Neovim
-- See https://github.com/nvim-flutter/flutter-tools.nvim

local function gh(repo) return 'https://github.com/' .. repo end

-- Dependencies: plenary is already added in none-ls.lua, but we add dressing for better UI
vim.pack.add {
  gh 'nvim-flutter/flutter-tools.nvim',
  gh 'stevearc/dressing.nvim',
}

require('flutter-tools').setup {}
