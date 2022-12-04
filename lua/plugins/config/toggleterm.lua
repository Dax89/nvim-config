require("toggleterm").setup({
    shade_terminals = false,
    open_mapping = "<F6>"
})

vim.api.nvim_create_autocmd("TermOpen", {pattern = "term://*", command = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]]})
vim.api.nvim_create_autocmd({"TermEnter", "TermOpen", "BufNew", "BufEnter"}, {pattern = "term://*", command = [[startinsert]]})
vim.api.nvim_create_autocmd({"TermLeave", "BufLeave"}, {pattern = "term://*", command = [[stopinsert]]})
