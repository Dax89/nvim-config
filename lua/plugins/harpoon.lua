return {
    "ThePrimeagen/harpoon",
    config = true,

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },

    keys = {
        {"<C-m>", function() require("harpoon.ui").toggle_quick_menu() end},
        {"<leader>ha", function() require("harpoon.mark").add_file() end},
        {"<leader>hp", function() require("harpoon.ui").nav_prev() end},
        {"<leader>hn", function() require("harpoon.ui").nav_next() end}
    },
}
