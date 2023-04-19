return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },

        opts = function ()
            return {
                highlight = { enable = true },
                -- indent = { enable = false, disable = { "python" } },
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
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true,

        keys = {
            {"<leader>tj", function() require("treesj").toggle() end},
        }
    },
}
