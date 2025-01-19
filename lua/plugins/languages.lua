return {
    { "peterhoeg/vim-qml",          ft = "qml" },
    { "mechatroner/rainbow_csv",    ft = "csv" },
    { "MTDL9/vim-log-highlighting", ft = "log" },
    { "bakpakin/fennel.vim",        ft = "fennel" },
    { "alaviss/nim.nvim",           ft = "nim" },
    { "ziglang/zig.vim",            ft = "zig" },
    { "bfrg/vim-jq",                ft = "jq" },

    {
        {
            "lukas-reineke/headlines.nvim",
            ft = { "markdown" },
            opts = {
                markdown = {
                    fat_headline_upper_string = "▁",
                    fat_headline_lower_string = "▔",
                }
            }
        }
    }
}
