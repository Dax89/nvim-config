return {
    "nvim-lua/plenary.nvim",
    "famiu/bufdelete.nvim",
    "Bekaboo/deadcolumn.nvim",

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

    {"stevearc/dressing.nvim", config = true},
    {"kyazdani42/nvim-web-devicons", config = true},
    {"norcalli/nvim-colorizer.lua", config = true },
    {"kylechui/nvim-surround", config = true},
    {"numToStr/Comment.nvim", config = true},

    {
        "nvim-pack/nvim-spectre",
        config = true,

        keys = {
            {"&", "<CMD>Spectre<CR>"}
        }
    },

    {
        "TimUntersberger/neogit",
        opts = { disable_builtin_notifications = true, },

        keys = {
            {
                "<leader>g",
                function()
                    local cwd = vim.fn.expand('%:p:h')
                    vim.api.nvim_command(":Neogit kind=split")
                    vim.cmd(":lcd" .. cwd)
                end
            }
        }
    },

    {
        url = "https://gitlab.com/yorickpeterse/nvim-window",
        keys = {
            {"<leader>w", function() require("nvim-window").pick() end}
        }
    },

    {
        "windwp/nvim-autopairs",

        opts = {
            check_ts = true,
            disable_filetype = {"fennel", "lisp"}
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

        keys = {
            {"<leader>ou", "<CMD>UndotreeToggle<CR>"}
        }
    },

    {
        "stevearc/oil.nvim",

        keys = {
            {"<C-f>", "<CMD>Oil<CR>"}
        },

        opts = {
            columns = {
                "permissions",
                "size",
                "mtime",
                "icon"
            },

            keymaps = {
                ["S"] = function()
                    local Oil = require("oil")
                    local d = Oil.get_current_dir()
                    local e = Oil.get_cursor_entry()

                    if e.type == "directory" then
                        local Path = require("plenary.path")
                        require("config.common").os_open(tostring(Path:new(d, e.name)))
                    else
                        require("config.common").os_open(d)
                    end
                end
            }
        }
    }
}
