local M = {}

function M.on_attach(client, bufnr)
    local options = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<A-Enter>", function() vim.lsp.buf.code_action() end, options)
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, options)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, options)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, options)

    if client.name == "clangd" then
        vim.keymap.set("n", "<F4>", ":ClangdSwitchSourceHeader<CR>")
    end

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function() vim.lsp.buf.format() end,
            buffer = bufnr,
        })
    end
end

return M
