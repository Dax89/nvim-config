local wk = require("which-key")

wk.register({
    name = "+telescope",
    ["<C-h>"] = {"<CMD>Telescope oldfiles<CR>", "File History"},
    ["<C-S-k>"] = {"<CMD>Telescope live_grep<CR>", "Find in Files"},
    ["<A-S-k>"] = {"<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols"},
    ["<S-Enter>"] = {"<CMD>Telescope lsp_references<CR>", "Find LSP References"},
    ["<C-k>"] = {"<CMD>Telescope find_files<CR>", "Find Files"},
})
