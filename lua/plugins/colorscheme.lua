vim.o.background = "dark"

return {
    {
        dir = vim.fn.stdpath("config") .. "/lua/ansi16",
        priority = 1000,
        lazy = false,

        dependencies = {
            "rktjmp/lush.nvim",
        },

        config = function()
            vim.cmd("colorscheme ansi16")
        end
    }
}
