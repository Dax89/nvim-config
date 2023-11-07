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
        "norcalli/nvim-colorizer.lua",
        opts = { "*" },
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
        opts = { disable_builtin_notifications = true, },
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
                    local cwd = vim.fn.expand('%:p:h')
                    vim.api.nvim_command(":Neogit kind=split")
                    vim.cmd(":lcd" .. cwd)
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
        "nacro90/numb.nvim",

        opts = {
            show_numbers = true,
            show_cursorline = true,
            number_only = false,
            centered_peeking = true,
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
