local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions

vim.keymap.set("n", "<C-h>", builtin.oldfiles)
vim.keymap.set("n", "<C-k>", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<C-g>", builtin.live_grep)
vim.keymap.set("n", "<C-s>", builtin.lsp_document_symbols)
vim.keymap.set("n", "<C-Enter>", builtin.lsp_references)
vim.keymap.set("n", "<C-S-Enter>", builtin.lsp_dynamic_workspace_symbols)

vim.keymap.set("n", "<C-f>", function()
    local Path = require("plenary.path")

    extensions.file_browser.file_browser({
        path = tostring(Path.new(vim.fn.expand("%:p")):parent())
    })
end)
