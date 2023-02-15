local M = { }

function M.on_attach(client, bufnr)
    local options = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "<A-Enter>", function() vim.lsp.buf.code_action() end, options)
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, options)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, options)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, options)

    if client.name == "clangd" then
        vim.keymap.set("n", "<F4>", ":ClangdSwitchSourceHeader<CR>")
    end
end

return M
