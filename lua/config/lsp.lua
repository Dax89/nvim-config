local M = {}

function M.on_attach(client, bufnr)
    local setkey = function(key, cb, desc)
        local options = { buffer = bufnr, remap = false, desc = desc }
        vim.keymap.set("n", key, cb, options)
    end

    setkey("<A-Enter>", function() vim.lsp.buf.code_action() end, "LSP - Code Action")
    setkey("<F2>", function() vim.lsp.buf.rename() end, "LSP - Rename")
    setkey("gd", function() vim.lsp.buf.definition() end, "LSP - GoTo Definition")
    setkey("K", function() vim.lsp.buf.hover() end, "LSP - Hover")

    if client.name == "clangd" then
        vim.keymap.set("n", "<F4>", ":ClangdSwitchSourceHeader<CR>", { desc = "LSP - Switch Source/Header" })
    end

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function() vim.lsp.buf.format() end,
            buffer = bufnr,
        })
    end
end

return M
