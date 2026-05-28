return {
    -- Configuration for tailwindcss
    -- See :help vim.lsp.config for available options
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*)\"']" },
                    { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    "(?:cls|className|\\w*Classes\\w*)\\s*(?:=|:)\\s*['\"`]([^'\"`]*)['\"`]",
                    "\\.className\\s*\\+?=\\s*['\"]([^'\"]*)['\"]",
                    "\\.setAttribute(?:NS)?\\([^)]*?['\"]class['\"],\\s*['\"]([^'\"]*)['\"]",
                    "\\.classList\\.(?:add|remove|toggle|contains)\\(([^)]*)\\)",
                    "\\.classList\\.replace\\(([^)]*)\\)",
                    "\\b\\w*Classes\\w*\\s*=\\s*\\{([\\s\\S]*?)\\}",
                    'class="([^"]*)"',
                    "class='([^']*)'",
                    ':class="([^"]*)"',
                    ":class='([^']*)'",
                },
            },
        },
    },
}
