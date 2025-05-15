-- Custom LSP Callbacks
local function setup_lsp_lua_ls()
    -- Make runtime files discoverable to the server
    local runtimepath = vim.split(package.path, ";")
    table.insert(runtimepath, "lua/?.lua")
    table.insert(runtimepath, "lua/?/init.lua")

    return {
        settings = {
            Lua = {
                telemetry = { enable = false },
                runtime = {
                    version = "LuaJIT",
                    path = runtimepath
                },
                diagnostics = {
                    globals = { "vim" } -- Get the language server to recognize the `vim` global
                },
                workspace = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.stdpath("config") .. "/lua"
                },
            }
        }
    }
end

local function setup_lsp_clangd()
    return {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders=false",
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        }
    }
end

-- local function setup_lsp_qmlls()
--     return {
--         cmd = { "qmlls6" },
--         filetypes = { "qmljs", "qml" }
--     }
-- end

local function setup_lsp_pylsp()
    return {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { "E501", "W504" },
                    }
                }
            }
        }
    }
end

local LSP_SERVERS = {
    lua_ls   = setup_lsp_lua_ls,
    clangd   = setup_lsp_clangd,
    -- qmlls  = setup_lsp_qmlls,
    pylsp    = setup_lsp_pylsp,
    ts_ls    = {},
    svelte   = {},
    -- cmake = { },
    bashls   = {},
    marksman = {},
}

local function setup_servers()
    for name, ep in pairs(LSP_SERVERS) do
        local config = {
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        }

        if vim.is_callable(ep) then -- Customize config (if any)
            config = vim.tbl_deep_extend("force", config, ep())
        end

        -- NOTE: Some servers may require an old setup until they are updated.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3705
        -- require("lspconfig")[name].setup(config)
        vim.lsp.config(name, config)
    end
end

return {
    {
        "neovim/nvim-lspconfig",

        config = function()
            setup_servers()

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),

                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    require("config.lsp").on_attach(client, event.buf)
                end
            })
        end
    },

    "RRethy/vim-illuminate",

    {
        "j-hui/fidget.nvim",
        config = true
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            hint_prefix = " ",
        },
        config = function(_, opts)
            require "lsp_signature".setup(opts)
        end
    },

    {
        "onsails/lspkind-nvim",
        opts = {
            preset = "codicons",
            symbol_map = {
                Snippet = ""
            }
        },
        config = function(_, opts)
            require("lspkind").init(opts)
        end
    },

    {
        "williamboman/mason.nvim",
        config = true,
        opts = {
            ui = {
                border = "rounded"
            }
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = vim.tbl_keys(LSP_SERVERS),
        },
    },

    {
        "SmiteshP/nvim-navic",

        opts = {
            lsp = { auto_attach = true },
            separator = " ",
            icons = {
                File = " ",
                Module = " ",
                Namespace = " ",
                Package = " ",
                Class = " ",
                Method = " ",
                Property = " ",
                Field = " ",
                Constructor = " ",
                Enum = " ",
                Interface = " ",
                Function = "󰡱 ",
                Variable = " ",
                Constant = " ",
                String = "󰅳 ",
                Number = "󰎠 ",
                Boolean = " ",
                Array = "󰅨 ",
                Object = " ",
                Key = " ",
                Null = "󰟢 ",
                EnumMember = " ",
                Struct = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            }
        }
    }
}
