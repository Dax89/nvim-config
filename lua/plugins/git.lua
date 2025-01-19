return {
    {
        "tpope/vim-fugitive",

        keys = {
            { "<leader>gg", ":Git<CR>",                                                 mode = "n", desc = "Git - Open" },
            { "<leader>gl", ":vertical :Git log<CR>",                                   mode = "n", desc = "Git - Log" },
            { "<leader>gc", ":vertical Git commit --quiet<CR>",                         mode = "n", desc = "Git - Commit" },
            { "<leader>ga", ":vertical Git commit --amend --quiet<CR>",                 mode = "n", desc = "Git - Commit" },
            { "<leader>gf", ":Git fetch --quiet<CR>",                                   mode = "n", desc = "Git - Fetch" },
            { "<leader>gp", ":Git pull --quiet<CR>",                                    mode = "n", desc = "Git - Pull" },
            { "<leader>gP", ":Git push --quiet<CR>",                                    mode = "n", desc = "Git - Push" },
            { "<leader>gd", ":vertical :Gdiffsplit<CR>",                                mode = "n", desc = "Git - Diff" },
            { "<leader>gA", ":Gwrite<CR>",                                              mode = "n", desc = "Git - Add Current" },
            { "<leader>gR", ":Gread<CR>",                                               mode = "n", desc = "Git - Reset Current" },
            { "<leader>gs", function() require("telescope.builtin").git_status() end,   mode = "n", desc = "Git - Status" },
            { "<leader>gb", function() require("telescope.builtin").git_branches() end, mode = "n", desc = "Git - Branches" },
        }
    }
}
