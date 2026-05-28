local utils = require 'plugins.lsp.utils'

return {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          utils.vue_plugin,
        },
      },
    },
  },
  filetypes = utils.tsserver_filetypes,
}
