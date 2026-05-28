-- Auto-close brackets, quotes, and other pairs
-- See https://github.com/windwp/nvim-autopairs

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}
