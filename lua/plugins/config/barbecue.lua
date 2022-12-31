local palette = require("kanagawa.colors").setup()
local common = require("config.common")

require("barbecue").setup({
    exclude_filetypes = common.filetype_blacklist,
    kinds = common.lsp_kinds,
    theme = vim.tbl_deep_extend("force", require("barbecue.theme.default"), {
        normal = { background = palette.sumiInk1 }
    })
})
