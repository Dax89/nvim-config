local mason = require("mason")

mason.setup()

require("mason-lspconfig").setup({
    ensure_installed = {"pyright", "tsserver", "svelte", "sumneko_lua", "cmake", "clangd", "marksman", "zls"}
})

-- Custom LSP Callbacks
local function setup_lsp_sumneko_lua()
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

local CUSTOM_LSP_CALLBACKS = {
    sumneko_lua =  setup_lsp_sumneko_lua
}

local CUSTOM_SERVERS = {"nimls"}

local function setup_servers()
    local installedservers = require("mason-lspconfig").get_installed_servers()
    local lspconfig = require("lspconfig")

    for _, name in ipairs(vim.list_extend(installedservers, CUSTOM_SERVERS)) do
        local options = {
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        }

        if vim.is_callable(CUSTOM_LSP_CALLBACKS[name]) then
            options = vim.tbl_extend("force", options, CUSTOM_LSP_CALLBACKS[name]())
        end

        lspconfig[name].setup(options)
    end
end

setup_servers()
