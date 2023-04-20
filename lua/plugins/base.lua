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
        "X3eRo0/dired.nvim",

        keys = {
            {
                "<C-f>",
                function()
                    local filepath = vim.api.nvim_buf_get_name(0)

                    if filepath then
                        local p = require("plenary.path"):new(filepath)

                        if p:exists() and p:is_file() then
                            p = p:parent()
                        end

                        if p:is_dir() then
                            vim.api.nvim_command(":Dired " .. tostring(p))
                        end
                    end

                    vim.api.nvim_command(":Dired")
                end
            }
        },

        opts = {
            show_banner = false,
            show_colors = true,
        },

        dependencies = {
            "MunifTanjim/nui.nvim"
        },

        config = function(_, opts)
            require("dired").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dired",

                callback = function()
                    vim.keymap.set("n", "s", function()
                        local Display = require("dired.display")
                        local filename = Display.get_filename_from_listing(vim.api.nvim_get_current_line())

                        if filename ~= nil then
                            local filepath = require("plenary.path"):new(vim.g.current_dired_path, filename)

                            if filepath:is_file() then
                                filepath = filepath:parent()
                            end

                            require("config.common").os_open(filepath)
                        end
                    end, {buffer = true})
                end
            })
        end
    }
}
