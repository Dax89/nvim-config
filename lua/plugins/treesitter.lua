return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },

        keys = {
            { "<leader>ti", "<CMD>Inspect<CR>",     desc = "TreeSitter - Inspect" },
            { "<leader>tt", "<CMD>InspectTree<CR>", desc = "TreeSitter - Inspect Tree" },
        },

        opts = function()
            return {
                context_commentstring = { enable = true, enable_autocmd = false },
                autopairs = { enable = true },

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },

                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "ruby",
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
                    "dap_repl"
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
}
