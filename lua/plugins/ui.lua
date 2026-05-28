-- UI and core UX plugins
-- guess-indent, nvim-web-devicons, gitsigns, which-key, catppuccin, todo-comments, mini.*

local function gh(repo) return 'https://github.com/' .. repo end

-- Automatic indentation detection
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}


-- Git status signs in the gutter
-- See :help gitsigns
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
    signs = {
        add          = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change       = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete       = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete    = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
}

-- Pending keymap hints popup
-- See :help which-key.nvim
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
        { '<leader>s', group = '[S]earch',    mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk',  mode = { 'n', 'v' } },
        { '<leader>l', group = '[L]azygit' },
        { 'gr',        group = 'LSP Actions', mode = { 'n' } },
    },
}

-- Catppuccin colorscheme
-- flavour options: 'latte' (light), 'frappe', 'macchiato', 'mocha' (dark)
-- See https://github.com/catppuccin/nvim
vim.pack.add { gh 'catppuccin/nvim' }
require('catppuccin').setup {
    flavour = 'mocha',
    background = { light = 'latte', dark = 'mocha' },
    styles = {
        comments = { 'italic' },
        keywords = { 'italic' },
    },
    integrations = {
        gitsigns   = true,
        telescope  = { enabled = true },
        which_key  = true,
        treesitter = true,
        mason      = true,
        blink_cmp  = true,
        mini       = { enabled = true },
    },
    custom_highlights = function(colors)
        return {
            MiniStatuslineModeNormal = { fg = colors.base, bg = colors.blue, style = { 'bold' } },
            MiniStatuslineModeInsert = { fg = colors.base, bg = colors.green, style = { 'bold' } },
            MiniStatuslineModeVisual = { fg = colors.base, bg = colors.mauve, style = { 'bold' } },
            MiniStatuslineModeReplace = { fg = colors.base, bg = colors.red, style = { 'bold' } },
            MiniStatuslineModeCommand = { fg = colors.base, bg = colors.peach, style = { 'bold' } },
            MiniStatuslineDevinfo = { fg = colors.text, bg = colors.surface0 },
            MiniStatuslineFilename = { fg = colors.text, bg = colors.mantle },
            MiniStatuslineFileinfo = { fg = colors.text, bg = colors.surface0 },
            MiniStatuslineLsp = { fg = colors.mauve, bg = colors.surface0, style = { 'bold' } },
        }
    end,
}
vim.cmd.colorscheme 'catppuccin-mocha'

-- Highlight todo, fixme, notes, etc. in comments
vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- Highlight color codes in the buffer
vim.pack.add { gh 'brenoprata10/nvim-highlight-colors' }
require('nvim-highlight-colors').setup {
    render = 'virtual',
    virtual_symbol = '■',
    enable_named_colors = true,
    enable_tailwind = true,
}

-- mini.nvim collection
-- See https://github.com/nvim-mini/mini.nvim
vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- Setup mini.icons and mock nvim-web-devicons
local mini_icons = require 'mini.icons'
mini_icons.setup()
mini_icons.mock_nvim_web_devicons()

-- Enhanced text objects: va), yi), ci', yiiq, etc.
-- NOTE: mappings adjusted to avoid conflict with Neovim >=0.12 incremental selection
-- See :help mini.ai
require('mini.ai').setup {
    mappings = {
        around_next = 'aa',
        inside_next = 'ii',
    },
    n_lines = 500,
}

-- Surround actions: saiw), sd', sr)'
-- See :help mini.surround
require('mini.surround').setup()

-- Statusline
-- See :help mini.statusline
local statusline = require 'mini.statusline'
statusline.setup {
    use_icons = vim.g.have_nerd_font,
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = '%2l:%-2v'

            -- LSP section
            local lsp_name = ''
            local clients = vim.lsp.get_clients { bufnr = 0 }
            if #clients > 0 then
                local names = {}
                for _, client in ipairs(clients) do
                    table.insert(names, client.name)
                end
                lsp_name = ' ' .. table.concat(names, ', ')
            end

            return MiniStatusline.combine_groups {
                { hl = mode_hl,                 strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineLsp',      strings = { lsp_name } },
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { location } },
            }
        end,
    },
}
