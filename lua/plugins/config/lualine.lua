require("lualine").setup({
    options = {
        theme = "tundra",
        disabled_filetypes = require("config.common").filetype_blacklist
    },
    integration = {nvimtree = {enabled = true, show_root = true}}
})
