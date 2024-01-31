vim.o.background = "dark"

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,

        config = function()
            require("kanagawa").setup()
            require("config.common").exec_commands("colorscheme kanagawa")
        end
    }
}
