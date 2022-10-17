local common = require("config.common")

common.set_options("g", {
    completion_matching_strategy_list = {"exact", "fuzzy"},
    completion_matching_smart_case = true
})

-- Diagnostic (https://github.com/VonHeikemen/lsp-zero.nvim/blob/main/lua/lsp-zero/presets.lua)
local function set_sign(name, icon)
    vim.fn.sign_define(name, {texthl = name, text = icon, numhl = ""})
end

set_sign("DiagnosticSignError", "✘")
set_sign("DiagnosticSignWarn",  "▲")
set_sign("DiagnosticSignHint",  "⚑")
set_sign("DiagnosticSignInfo",  "")

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
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
