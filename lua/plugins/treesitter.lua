return {
    "HiPhish/nvim-ts-rainbow2",

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
    }
}
