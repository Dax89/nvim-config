local wk = require("which-key")

wk.register({
    name = "+lsp",
    ["<C-F6>"] = {"<CMD>TroubleToggle<CR>", "Toggle LSP Troubles"},
})
