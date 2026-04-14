vim.opt_local.conceallevel = 0

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(arg)
        vim.keymap.set("n", "<localleader>m", "<CMD>MarkdownPreviewToggle<CR>",
            { buffer = arg.buf, desc = "Markdown - Toggle Preview" })
    end
})
