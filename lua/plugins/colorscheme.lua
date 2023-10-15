return {
    {
        "rebelot/kanagawa.nvim",

        config = function()
            require("kanagawa").setup({
                overrides = function(colors)
                    return {
                        QuickFixWarning = { fg = colors.palette.roninYellow },
                        CursorColumn = { bg = colors.palette.sumiInk3, fg = colors.palette.oldWhite },
                        -- SignColumn = { bg = colors.palette.sumiInk3, fg = colors.palette.oldWhite },
                        FoldColumn = { bg = colors.palette.sumiInk3, fg = colors.palette.oldWhite },
                        LineNr = { bg = colors.palette.sumiInk3, fg = colors.palette.oldWhite },
                    }
                end
            })

            require("config.common").exec_commands("colorscheme kanagawa")
        end
    }
}
