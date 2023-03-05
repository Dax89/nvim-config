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
                    globals = {"vim"} -- Get the language server to recognize the `vim` global
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
        cmd = {"clangd", "--background-index", "--header-insertion=never"}
    }
end

local CUSTOM_LSP_CONFIGS = {
    lua_ls =  setup_lsp_lua_ls,
    clangd = setup_lsp_clangd,
}

local CUSTOM_SERVERS = {"nimls"}

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
    { "ray-x/lsp_signature.nvim", opts = { hint_prefix = " "} },

    {
        "folke/trouble.nvim",
        config = true,
        keys = {
            {"<C-F3>", "<CMD>TroubleToggle<CR>"}
        }
    },

    {
        "onsails/lspkind-nvim",
        opts = function() 
            return {
                symbol_map = require("config.common").lsp_kinds
            }
        end,
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
                "marksman",
                "perlnavigator"
            }
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
            setup_servers()
        end
    },

    {
        "utilyre/barbecue.nvim",
        branch = "fix/E36",

        dependencies = {
            "smiteshp/nvim-navic",
        },

        opts = function()
            local colors = require("kanagawa.colors").setup()
            local common = require("config.common")

            return {
                exclude_filetypes = common.filetype_blacklist,
                kinds = common.lsp_kinds,
                theme = vim.tbl_deep_extend("force", require("barbecue.theme.default"), {
                    normal = { background = colors.palette.sumiInk1 }
                })
            }
        end
    }
}
