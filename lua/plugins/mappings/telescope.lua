local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-h>", builtin.oldfiles)
vim.keymap.set("n", "<C-k>", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<C-f>", builtin.file_browser)
vim.keymap.set("n", "<C-g>", builtin.live_grep)
vim.keymap.set("n", "<C-Enter>", builtin.lsp_references)
vim.keymap.set("n", "<C-S-Enter>", builtin.lsp_dynamic_workspace_symbols)
