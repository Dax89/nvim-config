local common = require("core.common")

common.set_options("g", {
    completion_matching_strategy_list = {"exact", "fuzzy"},
    completion_matching_smart_case = true
})

-- Custom LSP Callbacks
local function setup_lsp_sumneko_lua()
    return {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"} -- Get the language server to recognize the `vim` global
                }
            }
        }
    }
end

local CUSTOM_LSP_CALLBACKS = {
    sumneko_lua =  setup_lsp_sumneko_lua
}

local CUSTOM_SERVERS = {"nimls"}

local function lsp_onattach(client)
    local illuminate = require("illuminate")
    illuminate.on_attach(client)
end

local function setup_servers()
    local installedservers = require("mason-lspconfig").get_installed_servers()
    local lspconfig = require("lspconfig")

    for _, name in ipairs(vim.list_extend(installedservers, CUSTOM_SERVERS)) do
        local options = {
            on_attach = lsp_onattach,
            capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
        }

        if CUSTOM_LSP_CALLBACKS[name] then
            options = vim.tbl_extend("force", options, CUSTOM_LSP_CALLBACKS[name]())
        end

        lspconfig[name].setup(options)
    end
end

setup_servers()
require("lspsaga").init_lsp_saga()

