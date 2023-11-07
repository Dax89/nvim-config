return {
    "ThePrimeagen/harpoon",
    config = true,

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },

    keys = {
        { "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon - Open" },
        { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Harpoon - Mark" },
        { "<leader>hp", function() require("harpoon.ui").nav_prev() end,          desc = "Harpoon = Prev" },
        { "<leader>hn", function() require("harpoon.ui").nav_next() end,          desc = "Harpoon - Next" },
        { "<leader>h1", function() require("harpoon.ui").nav_file(1) end,         desc = "Harpoon - Bookmark 1" },
        { "<leader>h2", function() require("harpoon.ui").nav_file(2) end,         desc = "Harpoon - Bookmark 2" },
        { "<leader>h3", function() require("harpoon.ui").nav_file(3) end,         desc = "Harpoon - Bookmark 3" },
        { "<leader>h4", function() require("harpoon.ui").nav_file(4) end,         desc = "Harpoon - Bookmark 4" },
        { "<leader>h5", function() require("harpoon.ui").nav_file(5) end,         desc = "Harpoon - Bookmark 5" },
        { "<leader>h6", function() require("harpoon.ui").nav_file(6) end,         desc = "Harpoon - Bookmark 6" },
        { "<leader>h7", function() require("harpoon.ui").nav_file(7) end,         desc = "Harpoon - Bookmark 7" },
        { "<leader>h8", function() require("harpoon.ui").nav_file(8) end,         desc = "Harpoon - Bookmark 8" },
        { "<leader>h9", function() require("harpoon.ui").nav_file(9) end,         desc = "Harpoon - Bookmark 9" },
        { "<leader>h0", function() require("harpoon.ui").nav_file(10) end,        desc = "Harpoon - Bookmark 10" },
    },
}
