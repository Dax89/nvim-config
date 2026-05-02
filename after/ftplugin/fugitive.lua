local opts = { noremap = true, silent = true };

vim.api.nvim_buf_set_keymap(0, "n", "cC", "<CMD>Git commit --quiet<CR>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "cA", "<CMD>Git commit --quiet --amend<CR>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "cE", "<CMD>Git commit --quiet --amend --no-edit<CR>", opts)
