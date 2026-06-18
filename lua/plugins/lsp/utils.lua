local M = {}

-- M.vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

local default_vue_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

-- Detección dinámica para NixOS
if vim.fn.executable 'vue-language-server' == 1 then
  local handle = io.popen 'readlink -f $(which vue-language-server) 2>/dev/null'
  if handle then
    local result = handle:read '*a'
    handle:close()
    if result and result ~= '' then
      local bin_path = result:gsub('\n', '')
      -- En NixOS, las librerías cuelgan de /lib/node_modules/vue-language-server
      local nix_path = bin_path:gsub('/bin/vue-language-server$', '/lib/node_modules/vue-language-server')
      if vim.fn.isdirectory(nix_path) == 1 then default_vue_path = nix_path end
    end
  end
end

M.vue_language_server_path = default_vue_path

M.tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

M.vue_plugin = {
  name = '@vue/typescript-plugin',
  location = M.vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return M
