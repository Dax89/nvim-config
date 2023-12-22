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

local function setup_lsp_qmlls()
    return {
        cmd = { "qmlls6" },
        filetypes = { "qmljs", "qml" }
    }
end

local function setup_lsp_solargraph()
    return {
        single_file_support = true
    }
end

local CUSTOM_LSP_CONFIGS = {
    lua_ls     = setup_lsp_lua_ls,
    clangd     = setup_lsp_clangd,
    qmlls      = setup_lsp_qmlls,
    solargraph = setup_lsp_solargraph,
}

local CUSTOM_SERVERS = { "qmlls" }

local function setup_servers()
    local installedservers = require("mason-lspconfig").get_installed_servers()
    local lspconfig = require("lspconfig")

    for _, name in ipairs(vim.list_extend(installedservers, CUSTOM_SERVERS)) do
        local config = {
            on_attach = require("config.lsp").on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        }

        if vim.is_callable(CUSTOM_LSP_CONFIGS[name]) then
            config = vim.tbl_deep_extend("force", config, CUSTOM_LSP_CONFIGS[name]())
        end

        lspconfig[name].setup(config)
    end
end

return {
    "neovim/nvim-lspconfig",
    "RRethy/vim-illuminate",

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
        config = true
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "pyright",
                "tsserver",
                "svelte",
                "lua_ls",
                "cmake",
                "clangd",
                "bashls",
                "marksman",
                "solargraph"
            }
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
            setup_servers()
        end
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
