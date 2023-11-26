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

                -- https://github.com/AstroNvim/AstroNvim/blob/ef4538c8d1075afe872b2116f90b3499c88f059a/lua/plugins/treesitter.lua#L5
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,

                        keymaps = {
                            ["ak"] = { query = "@block.outer", desc = "Around block" },
                            ["ik"] = { query = "@block.inner", desc = "Inside block" },
                            ["ac"] = { query = "@class.outer", desc = "Around class" },
                            ["ic"] = { query = "@class.inner", desc = "Inside class" },
                            ["a?"] = { query = "@conditional.outer", desc = "Around conditional" },
                            ["i?"] = { query = "@conditional.inner", desc = "Inside conditional" },
                            ["af"] = { query = "@function.outer", desc = "Around function" },
                            ["if"] = { query = "@function.inner", desc = "Inside function" },
                            ["al"] = { query = "@loop.outer", desc = "Around loop" },
                            ["il"] = { query = "@loop.inner", desc = "Inside loop" },
                            ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
                            ["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true,

                        goto_next_start = {
                            -- ["]k"] = { query = "@block.outer", desc = "Next block start" },
                            -- ["]f"] = { query = "@function.outer", desc = "Next function start" },
                            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
                        },
                        goto_next_end = {
                            -- ["]K"] = { query = "@block.outer", desc = "Next block end" },
                            -- ["]F"] = { query = "@function.outer", desc = "Next function end" },
                            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
                        },
                        goto_previous_start = {
                            -- ["[k"] = { query = "@block.outer", desc = "Previous block start" },
                            -- ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
                        },
                        goto_previous_end = {
                            -- ["[K"] = { query = "@block.outer", desc = "Previous block end" },
                            -- ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                            ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
                        },
                    },
                    swap = {
                        enable = true,

                        swap_next = {
                            -- [">K"] = { query = "@block.outer", desc = "Swap next block" },
                            -- [">F"] = { query = "@function.outer", desc = "Swap next function" },
                            [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
                        },
                        swap_previous = {
                            -- ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
                            -- ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
                            ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
                        },
                    },
                },

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
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "InsertEnter"
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
