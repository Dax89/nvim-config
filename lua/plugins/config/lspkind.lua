local common = require("config.common")

require("lspkind").init({
    symbol_map = common.lsp_kinds
})
