return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },

        opts = function ()
            return {
                highlight = { enable = true },
                indent = { enable = true, disable = { "python" } },
                context_commentstring = { enable = true, enable_autocmd = false },
                autopairs = { enable = true },

                rainbow = {
                    enable = true,
                    query = "rainbow-parens",
                    strategy = require("ts-rainbow.strategy.global")
                },

                nt_cpp_tools = {
                    enable = true,
                    preview = {
                        quit = "q",
                        accept = "<CR>"
                    }
                },

                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "help",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "regex",
                    "svelte",
                    "tsx",
                    "typescript",
                    "vim",
                },
            }
        end,

        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "HiPhish/nvim-ts-rainbow2",
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
    {
        "Badhi/nvim-treesitter-cpp-tools",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = {"c", "cpp"},

        keys = {
            {"<leader>tdf", "<CMD>TSCppDefineClassFunc<CR>", mode = "v"},
            {"<leader>tmc", "<CMD>TSCppMakeConcreteClass<CR>", mode = "v"},
            {"<leader>tr3", "<CMD>TSCppRuleOf3<CR>", mode = "v"},
            {"<leader>tr5", "<CMD>TSCppRuleOf5<CR>", mode = "v"},
        },
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true,

        keys = {
            {"<leader>tj", function() require("treesj").toggle() end},
        }
    },
    {
        "stevearc/aerial.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },

        opts = {
            icons = require("config.common").lsp_kinds,
            attach_mode = "global",
            backends = { "lsp", "treesitter", "markdown", "man" },
            layout = { min_width = 28 },
            show_guides = true,
            filter_kind = false,
            guides = {
                mid_item = "├ ",
                last_item = "└ ",
                nested_top = "│ ",
                whitespace = "  ",
            },
        },

        keys = {
            {"<leader>os", "<CMD>AerialToggle!<CR>"},
        }
    }
}
