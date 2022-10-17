vim.api.nvim_create_autocmd("BufReadPost", {callback = function() require("neo-tree").show() end})
vim.api.nvim_create_autocmd("TextYankPost", {callback = function() vim.highlight.on_yank() end})
vim.api.nvim_create_autocmd("TermOpen", {pattern = "term://*", command = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]]})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {command = "set syntax=scss", pattern = "*.postcss"})
vim.api.nvim_create_autocmd({"TermEnter", "TermOpen", "BufNew", "BufEnter"}, {pattern = "term://*", command = [[startinsert]]})
vim.api.nvim_create_autocmd({"TermLeave", "BufLeave"}, {pattern = "term://*", command = [[stopinsert]]})
