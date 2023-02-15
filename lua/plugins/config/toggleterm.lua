require("toggleterm").setup({
    shade_terminals = false,
    open_mapping = "<C-F7>"
})

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
