return {
    "justinmk/vim-sneak",

    init = function()
        vim.g["sneak#label"] = 1

        local ok, colors = pcall(require, "kanagawa.colors")

        if ok then
            colors = colors.setup()
            vim.api.nvim_set_hl(0, "Sneak", {
                fg = colors.palette.sumiInk0,
                bg = colors.palette.roninYellow
            })

            vim.api.nvim_set_hl(0, "SneakScope", {
                fg = colors.palette.oldWhite,
                bg = colors.palette.waveBlue2
            })

            vim.api.nvim_set_hl(0, "SneakLabel", {
                fg = colors.palette.sumiInk0,
                bg = colors.palette.roninYellow
            })
        end
    end
}
