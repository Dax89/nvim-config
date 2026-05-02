vim.lsp.log.set_level("ERROR")

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
    pylsp    = setup_lsp_pylsp,
    ts_ls    = {},
    svelte   = {},
    bashls   = {},
    marksman = {},
}

local LSP_IGNORE_FORMATTING = { "css" }

local function lsp_attach(client, bufnr)
    local function setkey(key, cb, desc)
        local options = { buffer = bufnr, desc = desc }
        vim.keymap.set("n", key, cb, options)
    end

    local filetype = vim.bo[bufnr].filetype

    -- Setup shortcuts
    setkey("<A-Enter>", function() vim.lsp.buf.code_action() end, "LSP - Code Action")
    setkey("<F2>", function() vim.lsp.buf.rename() end, "LSP - Rename")
    setkey("gt", function() vim.lsp.buf.type_definition() end, "LSP - GoTo Type Definition")
    setkey("gi", function() vim.lsp.buf.implementation() end, "LSP - GoTo Implementation")
    setkey("gd", function() vim.lsp.buf.definition() end, "LSP - GoTo Definition")
    setkey("gD", function() vim.lsp.buf.declaration() end, "LSP - GoTo Declaration")
    setkey("K", function() vim.lsp.buf.hover() end, "LSP - Hover")

    if client.name == "clangd" then
        setkey("<F4>", "<CMD>LspClangdSwitchSourceHeader<CR>", "LSP - Switch Source/Header")
    end

    -- Auto Formatting (optional)
    if not vim.tbl_contains(LSP_IGNORE_FORMATTING, filetype) and
        client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting, bufnr) then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function() vim.lsp.buf.format() end,
            buffer = bufnr,
        })
    end
end


vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(e)
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if client then
            lsp_attach(client, e.buf)
        end
    end
})

return {
    {
        "neovim/nvim-lspconfig",

        config = function()
            vim.lsp.enable(LSP_SERVERS)

            for name, ep in pairs(LSP_SERVERS) do
                if vim.is_callable(ep) then
                    vim.lsp.config(name, ep())
                end
            end
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
        opts = { hint_prefix = " ", }
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
