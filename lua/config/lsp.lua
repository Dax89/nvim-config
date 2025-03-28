local M = {
    IGNORE_FORMATTING = { "css" }, -- FileType
}

vim.lsp.set_log_level("off")

function M.on_attach(client, bufnr)
    local setkey = function(key, cb, desc)
        local options = { buffer = bufnr, remap = false, desc = desc }
        vim.keymap.set("n", key, cb, options)
    end

    setkey("<A-Enter>", function() vim.lsp.buf.code_action() end, "LSP - Code Action")
    setkey("<F2>", function() vim.lsp.buf.rename() end, "LSP - Rename")
    setkey("gt", function() vim.lsp.buf.type_definition() end, "LSP - GoTo Type Definition")
    setkey("gi", function() vim.lsp.buf.implementation() end, "LSP - GoTo Implementation")
    setkey("gd", function() vim.lsp.buf.definition() end, "LSP - GoTo Definition")
    setkey("gD", function() vim.lsp.buf.declaration() end, "LSP - GoTo Declaration")
    setkey("K", function() vim.lsp.buf.hover() end, "LSP - Hover")

    if client.name == "clangd" then
        vim.keymap.set("n", "<F4>", ":ClangdSwitchSourceHeader<CR>", { desc = "LSP - Switch Source/Header" })
    end

    local filetype = vim.bo[bufnr].filetype

    if not vim.tbl_contains(M.IGNORE_FORMATTING, filetype) and
        client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function() vim.lsp.buf.format() end,
            buffer = bufnr,
        })
    end
end

return M
