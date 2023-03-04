return {
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = false,

        keys = {
            {
                "<leader>rr",
                [[<ESC><CMD>lua require("telescope").extensions.refactoring.refactors()<CR>]],
                mode = "v"
            },
            {
                "<leader>rb",
                [[<CMD>lua require("refactoring").refactor("Extract Block")<CR>]]
            },
            {
                "<leader>ri",
                [[<CMD>lua require("refactoring").refactor("Inline Variable")<CR>]]
            }
        },

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
        },

        config = function()
            require("telescope").load_extension("refactoring")
        end
    }
}
