require("toggleterm").setup({
    shade_terminals = false
})

vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

vim.api.nvim_create_autocmd("TermOpen", {pattern = "term://*", command = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]]})

vim.api.nvim_create_autocmd({"TermEnter", "TermOpen", "BufNew", "BufEnter"}, {
    pattern = "term://*",

    callback = function(arg)
        if not arg.file:match("dap%-terminal") then
            vim.api.nvim_command("startinsert")
        end
    end
})

vim.api.nvim_create_autocmd({"TermLeave", "BufLeave"}, {pattern = "term://*", command = [[stopinsert]]})
