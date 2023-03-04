return {
    {
        "rebelot/kanagawa.nvim",
        commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",

        config = function()
            local common = require("config.common")
            local palette = require("kanagawa.colors").setup()

            vim.o.background = "dark"

            require("kanagawa").setup({
                overrides = {
                    QuickFixWarning = { fg = palette.roninYellow }
                }
            })

            common.exec_commands("colorscheme kanagawa")
        end
    }
}
