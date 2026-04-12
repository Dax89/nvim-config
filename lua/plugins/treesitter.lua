local TS_PARSERS = {
    "bash", "c", "cpp", "ruby", "css", -- "help",
    "html", "javascript", "json", "lua", "markdown",
    "markdown_inline", "python", "regex", "svelte",
    "tsx", "typescript", "vim", -- "dap_repl"
}


return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
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
            }
        end,

        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = TS_PARSERS,
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end
            })

            require("nvim-treesitter").install(TS_PARSERS)
        end,
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        event = "VeryLazy",

        init = function()
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
    { "windwp/nvim-ts-autotag", config = true },
}
