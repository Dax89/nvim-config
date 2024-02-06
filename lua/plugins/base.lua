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
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                rgb_fn = true,
                hsl_fn = true,
            }
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
        "NeogitOrg/neogit",
        opts = {
            signs = {
                item = { "", "" },
                section = { "", "" },
            },
            disable_builtin_notifications = true,
        },
        config = true,

        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },

        keys = {
            {
                "<leader>gg",
                function()
                    require("neogit").open({ kind = "vsplit" })
                end,

                desc = "NeoGit = Open"
            }
        }
    },

    {
        "windwp/nvim-autopairs",

        opts = {
            check_ts = true,
            disable_filetype = { "fennel", "lisp" }
        }
    },

    {
        "mbbill/undotree",

        init = function()
            vim.g.undotree_CustomUndotreeCmd = "vertical 50 new"
            vim.g.undotree_CustomDiffpanelCmd = "botright 10 new"
            vim.g.undotree_TreeNodeShape = "●"
            vim.g.undotree_TreeVertShape = "│"
            vim.g.undotree_TreeSplitShape = "╱"
            vim.g.undotree_TreeReturnShape = "╲"
            vim.g.undotree_SetFocusWhenToggle = true
            vim.g.undotree_DiffAutoOpen = true
            vim.g.undotree_HelpLine = false
            vim.g.undotree_ShortIndicators = true
        end,

        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "UndoTree - Open" }
        }
    },
}
