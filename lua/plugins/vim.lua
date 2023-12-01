return {
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
    {
        "easymotion/vim-easymotion",

        init = function()
            vim.g.EasyMotion_keys = "hjklasdfgyuiopqwertnmzxcvb"
            vim.g.EasyMotion_prompt = "Jump to → "
            vim.g.EasyMotion_leader_key = " "
            vim.g.EasyMotion_smartcase = 1
            vim.g.EasyMotion_grouping = 1
            vim.g.EasyMotion_do_mapping = 0
            vim.g.EasyMotion_verbose = 0
        end,

        keys = {
            { ",w", "<Plug>(easymotion-bd-w)",  desc = "EasyMotion - Find Word" },
            { ",W", "<Plug>(easymotion-bd-W)",  desc = "EasyMotion - Find WORD" },
            { ",f", "<Plug>(easymotion-bd-f2)", desc = "EasyMotion - Find" },
        }
    }
}
