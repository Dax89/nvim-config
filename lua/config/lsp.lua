local M = {
    IGNORE_FORMATTING = { "css" }, -- FileType
}

-- HACK: LSPConfig defaults commmand to buffer 0 (the current one)
-- https://github.com/neovim/nvim-lspconfig/blob/ac1dfbe3b60e5e23a2cff90e3bd6a3bc88031a57/lsp/clangd.lua#L81
local function clangd_switch_source_header(client, bufnr)
    local method_name = "textDocument/switchSourceHeader"
    local params = vim.lsp.util.make_text_document_params(bufnr)
    client.request(method_name, params, function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            vim.notify("corresponding file cannot be determined")
            return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

vim.lsp.set_log_level("ERROR")

function M.on_attach(client, bufnr)
    local function setkey(key, cb, desc)
        local options = { buffer = bufnr, desc = desc }
        vim.keymap.set("n", key, cb, options)
    end

    local function client_supports_method(method)
        return client and client:supports_method(method, bufnr)
    end

    -- Setup shortcuts
    setkey("<A-Enter>", function() vim.lsp.buf.code_action() end, "LSP - Code Action")
    setkey("<F2>", function() vim.lsp.buf.rename() end, "LSP - Rename")
    setkey("gt", function() vim.lsp.buf.type_definition() end, "LSP - GoTo Type Definition")
    setkey("gi", function() vim.lsp.buf.implementation() end, "LSP - GoTo Implementation")
    setkey("gd", function() vim.lsp.buf.definition() end, "LSP - GoTo Definition")
    setkey("gD", function() vim.lsp.buf.declaration() end, "LSP - GoTo Declaration")
    setkey("K", function() vim.lsp.buf.hover() end, "LSP - Hover")

    if client and client.name == "clangd" then
        setkey("<F4>", function() clangd_switch_source_header(client, bufnr) end, "LSP - Switch Source/Header")
    end

    -- Auto Formatting (optional)
    local filetype = vim.bo[bufnr].filetype

    if not vim.tbl_contains(M.IGNORE_FORMATTING, filetype) and
        client_supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function() vim.lsp.buf.format() end,
            buffer = bufnr,
        })
    end
end

return M
