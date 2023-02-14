local common = require("config.common")
local palette = require("kanagawa.colors").setup()

vim.o.background = "dark"

require("kanagawa").setup({
    overrides = {
        QuickFixWarning = { fg= palette.roninYellow }
    }
})

common.exec_commands("colorscheme kanagawa")
