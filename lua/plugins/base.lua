return {
    "nvim-lua/plenary.nvim",
    "famiu/bufdelete.nvim",
    "Bekaboo/deadcolumn.nvim",

    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup()
        end,
    },

    {
        "rcarriga/nvim-notify",

        opts = {
            stages = "static",
            top_down = false,
            timeout = 2000,
            max_width = 50,
            render = "wrapped-compact",
            fps = 60,
        },

        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end
    },

    { "stevearc/dressing.nvim",       config = true },
    { "kyazdani42/nvim-web-devicons", config = true },
    { "kylechui/nvim-surround",       config = true },
    { "numToStr/Comment.nvim",        config = true },

    {
        "catgoose/nvim-colorizer.lua",
        opts = {
            options = {
                parsers = {
                    css = true,
                    names = false,

                    tailwind = {
                        enable = true,
                        lsp = true,
                        update_names = true,
                    },

                    hex = {
                        rgb = true,
                        rgba = true,
                        rrggbb = true,
                        rrggbbaa = true,
                        aarrggbb = false,
                    },
                },

                display = {
                    mode = "virtualtext",

                    virtualtext = {
                        char = "■",
                        position = "before",
                        hl_mode = "foreground",
                    },
                }
            },

            filetypes = { "*", "!TelescopePrompt" }

        },
        config = true
    },

    {
        "nvim-pack/nvim-spectre",
        config = true,

        keys = {
            { "&", "<CMD>Spectre<CR>", desc = "Spectre - Open" }
        }
    },

    {
        "windwp/nvim-autopairs",

        opts = {
            check_ts = true,
            disable_filetype = { "fennel", "lisp", "TelescopePrompt" }
        }
    },
}
