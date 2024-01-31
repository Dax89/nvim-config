vim.o.background = "dark"

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,

        opts = {
            extend_background_behind_borders = false,

            highlight_groups = {
                EndOfBuffer = { fg = "base" },
                DashboardHeader = { fg = "love" },
            }
        },

        config = function(_, opts)
            -- https://rosepinetheme.com/palette/ingredients
            require("rose-pine").setup(opts)
            require("config.common").exec_commands("colorscheme rose-pine")
        end
    },
}
