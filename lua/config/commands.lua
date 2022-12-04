vim.api.nvim_create_autocmd("TextYankPost", {callback = function() vim.highlight.on_yank() end})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {command = "set syntax=scss", pattern = "*.postcss"})
