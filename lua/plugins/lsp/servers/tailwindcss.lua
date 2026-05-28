return {
    -- Configuración para tailwindcss
    -- Ver :help vim.lsp.config para opciones disponibles
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
