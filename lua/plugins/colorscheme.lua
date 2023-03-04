return {
    {
        "rebelot/kanagawa.nvim",
        -- commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",

        config = function()
            vim.o.background = "dark"

            require("kanagawa").setup({
                overrides = function(colors)
                    return {
                        QuickFixWarning = { fg = colors.roninYellow }
                    }
                end,
            })

            require("config.common").exec_commands("colorscheme kanagawa")
        end
    }
}
