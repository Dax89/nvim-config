return {
    {
        "akinsho/toggleterm.nvim",

        keys = {
            {"<leader>ot", "<CMD>ToggleTerm<CR>"}
        },

        opts = {
            shade_terminals = false
        },

        config = function(_, opts)
            vim.api.nvim_create_autocmd("TermOpen", {pattern = "term://*", command = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]]})

            vim.api.nvim_create_autocmd({"TermEnter", "TermOpen", "BufNew", "BufEnter"}, {
                pattern = "term://*",

                callback = function(arg)
                    if not arg.file:match("dap%-terminal") then
                        vim.api.nvim_command("startinsert")
                    end
                end
            })

            require("toggleterm").setup(opts)
        end
    }
}
