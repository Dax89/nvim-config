vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {command = "set syntax=scss", pattern = "*.postcss"})
vim.api.nvim_create_autocmd("TextYankPost", {command = "silent! lua vim.highlight.on_yank()"})
