local mason = require("mason")

mason.setup()

require("mason-lspconfig").setup({
    ensure_installed = {"pyright", "tsserver", "svelte", "sumneko_lua", "cmake", "clangd", "zls"}
})
