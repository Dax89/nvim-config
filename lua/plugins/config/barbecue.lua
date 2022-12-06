local common = require("config.common")

require("barbecue").setup({
    exclude_filetypes = common.filetype_blacklist
})
