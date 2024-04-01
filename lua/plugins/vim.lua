return {
    "cocopon/colorswatch.vim",
    {
        "vifm/vifm.vim",
        event = "VeryLazy",

        init = function()
            vim.g["vifm_replace_netrw"] = 1
            vim.g["vifm_replace_netrw_cmd"] = "Vifm"
        end,

        keys = {
            { "<C-f>", "<CMD>Vifm<CR>", desc = "VIFM - Open" }
        },
    },
}
