return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },

        opts = function ()
            return {
                -- indent = { enable = false, disable = { "python" } },
                context_commentstring = { enable = true, enable_autocmd = false },
                autopairs = { enable = true },

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = {"org"},
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
                    "org",
                },
            }
        end,

        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        event = "VeryLazy",

        config = function()
            local rainbowdelimiters = require("rainbow-delimiters")

            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbowdelimiters.strategy["global"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                },
            }
        end
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true,

        keys = {
            {"<leader>tj", function() require("treesj").toggle() end},
        }
    },
}
