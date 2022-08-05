local mason = require("mason")

mason.setup()
vim.pretty_print(mason._registry)

require("mason-lspconfig").setup({
    ensure_installed = {"pyright", "tsserver", "svelte", "sumneko_lua", "cmake", "clangd", "zls"}
})
