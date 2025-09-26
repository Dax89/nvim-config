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
    },

    {
        "vlime/vlime",
        ft = { "lisp", "commonlisp" },

        dependencies = {
            "kovisoft/paredit"
        },

        enabled = function()
            return vim.fn.executable("sbcl")
        end,

        init = function()
            vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/vlime/vim")

            vim.g.vlime_enable_autodoc = 1
            vim.g.vlime_window_settings = {
                repl = { pos = "belowright", vertical = true },
                sldb = { pos = "belowright", size = 20 },
                server = { pos = "belowright", size = 10 },
                inspector = { pos = "belowright", size = 15 },
            }
        end,
    },
}
