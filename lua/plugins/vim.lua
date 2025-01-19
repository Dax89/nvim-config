return {
    "cocopon/colorswatch.vim",
    {
        "vifm/vifm.vim",
        event = "VeryLazy",

        init = function()
            vim.g["vifm_replace_netrw"] = 1
            vim.g["vifm_replace_netrw_cmd"] = "Vifm"
            vim.g["vifm_exec_args"] = "-c only" -- One pane
        end,

        keys = {
            { "<C-f>", "<CMD>Vifm<CR>", desc = "VIFM - Open" }
        },
    },
}
