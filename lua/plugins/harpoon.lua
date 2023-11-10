return {
    "ThePrimeagen/harpoon",
    config = true,

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },

    keys = function()
        local tbl = {
            { "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon - Open" },
            { "H",          function() require("harpoon.ui").nav_prev() end,          desc = "Harpoon = Prev" },
            { "L",          function() require("harpoon.ui").nav_next() end,          desc = "Harpoon - Next" },
            {
                "<leader>ha",
                function()
                    require("harpoon.mark").add_file()

                    local common = require("config.common")
                    local filename = common.get_filename(vim.api.nvim_buf_get_name(0))
                    vim.notify("'" .. filename .. "' added", "info", { title = "Harpoon" })
                end,
                desc = "Harpoon - Add"
            }
        }

        for i = 1, 10 do
            table.insert(tbl, {
                "<leader>" .. (i % 10),
                function() require("harpoon.ui").nav_file(i) end,
                desc = "Harpoon - Bookmark " .. i,
            })
        end

        return tbl
    end
}
