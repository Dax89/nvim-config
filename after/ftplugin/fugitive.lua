local opts = { noremap = true, silent = true };

vim.api.nvim_buf_set_keymap(0, "n", "cc", "<CMD>Git commit --quiet<CR>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "ca", "<CMD>Git commit --quiet --amend<CR>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "ce", "<CMD>Git commit --quiet --amend --no-edit<CR>", opts)
