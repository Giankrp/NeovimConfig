local M = {}

M.vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

M.tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

M.vue_plugin = {
  name = '@vue/typescript-plugin',
  location = M.vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return M
