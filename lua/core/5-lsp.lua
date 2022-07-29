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

local function lsp_onattach(client)
    local aerial, illuminate = require("aerial"), require("illuminate")
    aerial.on_attach(client)
    illuminate.on_attach(client)
end

local function setup_lspconfig_servers()
    local CUSTOM_SERVERS = {"nimls"}
    local lspconfig = require("lspconfig")

    for _, name in ipairs(CUSTOM_SERVERS) do
        lspconfig[name].setup({
            on_attach = lsp_onattach,
            capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
        })
    end
end

local CUSTOM_LSP_CALLBACKS = {
    sumneko_lua =  setup_lsp_sumneko_lua
}

local function setup_lspinstaller_servers()
    local SERVERS = {"pyright", "tsserver", "svelte", "sumneko_lua", "cmake", "clangd", "zls"}
    local lspinstaller, installedcount  = require("nvim-lsp-installer"), 0

    for _, name in ipairs(SERVERS) do
        local ok, server = lspinstaller.get_server(name)

        if ok and not server:is_installed() then
            print("[nvim-lsp-installer]: Installing " .. name .. "...")
            server:install()
            installedcount = installedcount + 1
        end
    end

    lspinstaller.on_server_ready(function(server)
        local lspconfig, opts = require("lspconfig"), {on_attach = lsp_onattach}

        lspconfig[server.name]:setup({
            capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
        })

        if CUSTOM_LSP_CALLBACKS[server.name] then
            opts = common.merge_tables(opts, CUSTOM_LSP_CALLBACKS[server.name]())
        end

        server:setup(opts)

        if installedcount > 0 then
            vim.api.nvim_command(":LspInstallInfo")
        end
    end)
end

setup_lspinstaller_servers()
setup_lspconfig_servers()
