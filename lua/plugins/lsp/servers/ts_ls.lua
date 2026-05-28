local utils = require 'plugins.lsp.utils'

return {
  init_options = {
    plugins = {
      utils.vue_plugin,
    },
  },
  filetypes = utils.tsserver_filetypes,
}
